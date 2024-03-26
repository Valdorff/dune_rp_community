/* Dune query number  - 3465286 */
with hours as (
    select
        timestamp as hr,
        date_trunc('day', timestamp) as d
    from
        unnest(
            sequence(
                date_trunc('hour', cast(current_timestamp as timestamp) - interval '1' year),
                cast(current_timestamp as timestamp),
                interval '60' minute
            )
        ) as tbl(timestamp)
),

peg as (
    select
        hours.hr,
        peg.token_peg_eth
    from hours
    left join
        (select
            date_trunc('hour', t) as hr,
            token_peg_eth,
            lead(date_trunc('hour', t)) over (order by date_trunc('hour', t)) as next_hr
        from query_3465256) as peg on
        hours.hr >= peg.hr
        and hours.hr < peg.next_hr
),

trades as (
    select
        date_trunc('hour', trades.t) as hr,
        sum(trades.token_trade_amount_eth) as token_trade_amount_eth,
        sum(trades.token_trade_amount) as token_trade_amount,
        sum(trades.token_trade_amount_eth) / sum(trades.token_trade_amount) as token_price_eth
    from query_3465242 as trades
    where trades.t > cast(current_timestamp as timestamp) - interval '1' year
    group by 1
),

prices as (
    select
        hours.hr,
        prices.token_price_eth,
        prices.token_trade_amount_eth,
        prices.token_trade_amount
    from hours
    left join
        (select
            hr,
            token_price_eth,
            token_trade_amount_eth,
            token_trade_amount,
            lead(hr) over (order by hr) as next_hr
        from trades) as prices on
        hours.hr >= prices.hr
        and hours.hr < prices.next_hr
)

select
    hours.hr,
    'cbETH' as token_name,
    prices.token_price_eth,
    avg(prices.token_price_eth)
        over (order by hours.hr rows between 5 preceding and current row)
        as token_price_eth_6hr_ma,
    prices.token_trade_amount_eth,
    prices.token_trade_amount,
    peg.token_peg_eth,
    prices.token_price_eth / peg.token_peg_eth as token_price_peg_ratio,
    avg(prices.token_price_eth) over (order by hours.hr rows between 5 preceding and current row)
    / peg.token_peg_eth as token_price_peg_ratio_6hr_ma,
    (prices.token_price_eth / peg.token_peg_eth) - 1 as token_peg_pct_divergence,
    avg(prices.token_price_eth) over (order by hours.hr rows between 5 preceding and current row) / peg.token_peg_eth
    - 1 as token_peg_pct_divergence_6hr_ma
from hours
left join peg on hours.hr = peg.hr
left join prices on hours.hr = prices.hr
