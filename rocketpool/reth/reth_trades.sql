/* Dune query number  - 3480086 */
with
trades as (
    select
        block_time as t,
        0xae78736cd615f374d3085123a210448e74fc6393 as token_contract_address,
        case
            when token_bought_address = 0xae78736cd615f374d3085123a210448e74fc6393 then token_bought_amount
            else token_sold_amount
        end as token_trade_amount,
        amount_usd as token_trade_amount_usd
    from
        dex.trades
    where
        blockchain = 'ethereum'
        and (
            token_bought_address = 0xae78736cd615f374d3085123a210448e74fc6393
            or token_sold_address = 0xae78736cd615f374d3085123a210448e74fc6393
        )
        and block_time >= cast('2021-10-02' as timestamp)
        and amount_usd > 10
)

select
    trades.t,
    date_trunc('day', trades.t) as d,
    trades.token_trade_amount,
    trades.token_trade_amount_usd,
    trades.token_trade_amount_usd / cast(prices.price as double) as token_trade_amount_eth,
    /* Trade size in USD divided by USD/ETH is amount of USD. */
    'rETH' as token_name,
    trades.token_contract_address
from
    trades
inner join
    prices.usd
        as prices
    on prices.minute = date_trunc('minute', trades.t)
        and prices.symbol = 'WETH'
        and not trades.token_trade_amount_usd is null /* We need to drop trades if the ETH amount will be unknown. */
        and not prices.price is null
        and prices.price > 0
where
    prices.blockchain = 'ethereum'
