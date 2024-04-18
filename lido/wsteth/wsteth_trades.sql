/* Dune query number  - 3636570 */
with
trades as (
    select
        block_time as t,
        0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0 as token_contract_address,
        case
            when token_bought_address = 0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0 then token_bought_amount
            else token_sold_amount
        end as token_trade_amount,
        amount_usd as token_trade_amount_usd
    from
        dex.trades
    where
        blockchain = 'ethereum'
        and (
            token_bought_address = 0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0
            or token_sold_address = 0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0
        )
        and block_time >= cast('2020-10-01' as timestamp)
        and amount_usd > 10
)

select
    trades.t,
    date_trunc('day', trades.t) as d,
    trades.token_trade_amount,
    trades.token_trade_amount_usd,
    trades.token_trade_amount_usd / cast(prices.price as double) as token_trade_amount_eth,
    /* Trade size in USD divided by USD/ETH is amount of USD. */
    'wstETH' as token_name,
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
