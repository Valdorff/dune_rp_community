/* Dune query number  - 3480165 */
with hours as (select timestamp as hour, date_trunc('day',timestamp) as day from unnest(sequence(date_trunc('hour',cast(CURRENT_TIMESTAMP as timestamp) - interval '1' year),cast(CURRENT_TIMESTAMP AS TIMESTAMP),interval '60' minute)) tbl(timestamp)
)
,
peg as (
    select hr.hour
        , pg.token_peg_eth
    from hours hr
    left join 
        (select date_trunc('hour',time) as hour 
            , token_peg_eth
            , lead(date_trunc('hour',time)) over (order by date_trunc('hour',time)) as next_time
            from query_3480099) as pg on 
                hr.hour  >= pg.hour
                and hr.hour < pg.next_time 
)
,
trades as (
    select
        date_trunc('hour',tr.time) as hour,
        sum(token_trade_amount_eth) as token_trade_amount_eth,
        sum(token_trade_amount) as token_trade_amount,
        sum(token_trade_amount_eth)/sum(token_trade_amount) as token_price_eth
    from query_3480086 tr
    where tr.time > cast(CURRENT_TIMESTAMP as timestamp) - interval '1' year
    group by 1
)
,
prices as (
select hr.hour,
    pr.token_price_eth,
    pr.token_trade_amount_eth,
    pr.token_trade_amount
    from hours hr
    left join       
        (select hour 
            , token_price_eth
            , token_trade_amount_eth
            , token_trade_amount
            , lead(hour) over (order by hour) as next_time
            from trades) as pr on 
                hr.hour  >= pr.hour
                and hr.hour < pr.next_time 
)
select 
    hr.hour,
    'rETH' as token_name,
    pr.token_price_eth,
    avg(pr.token_price_eth) over (order by hr.hour ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) as token_price_eth_6hr_ma,
    token_trade_amount_eth,
    token_trade_amount,
    pg.token_peg_eth,
    pr.token_price_eth/pg.token_peg_eth as token_price_peg_ratio,
    avg(pr.token_price_eth) over (order by hr.hour ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)/pg.token_peg_eth as token_price_peg_ratio_6hr_ma,
    (pr.token_price_eth/pg.token_peg_eth) - 1 as token_peg_pct_divergence,
    avg(pr.token_price_eth) over (order by hr.hour ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)/token_peg_eth - 1 as token_peg_pct_divergence_6hr_ma
from hours hr
left join peg pg on pg.hour = hr.hour
left join prices pr on pr.hour = hr.hour

    