/* Dune query number  - 3465242 */
with
trades as (
    select
        block_time as t,
        0xbe9895146f7af43049ca1c1ae358b0541ea49704 as token_contract_address,
        case
            when token_bought_address = 0xbe9895146f7af43049ca1c1ae358b0541ea49704 then token_bought_amount
            else token_sold_amount
        end as token_trade_amount,
        amount_usd as token_trade_amount_usd
    from
        dex.trades
    where
        blockchain = 'ethereum'
        and (
            token_bought_address = 0xbe9895146f7af43049ca1c1ae358b0541ea49704
            or token_sold_address = 0xbe9895146f7af43049ca1c1ae358b0541ea49704
        )
        and block_time >= cast('2022-02-07' as timestamp)
        and amount_usd > 10
)

select
    trades.t,
    date_trunc('day', trades.t) as d,
    trades.token_trade_amount,
    trades.token_trade_amount_usd,
    trades.token_trade_amount_usd / cast(prices.price as double) as token_trade_amount_eth,
    /* Trade size in USD divided by USD/ETH is amount of USD. */
    'cbETH' as token_name,
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
