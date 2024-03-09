/* Dune query number  - 3458937 */
with days as (select date as day from unnest(sequence(date('2020-12-20'),CURRENT_DATE,interval '1' day)) tbl(date)
)
, totals as (
    SELECT
        days.day,
        cast(coalesce(sum(token_mint_amount),0) as double) as token_mint_amount,
        cast(coalesce(sum(token_burn_amount),0) as double) as token_burn_amount,
        cast(coalesce(sum(eth_balance),0) as double) as token_buffer_amount,
        cast(coalesce(sum(token_mint_amount),0) as double) - cast(coalesce(sum(token_burn_amount),0) as double) as token_supply_change_amount
        from days
        left join 
          query_3463887 as mint on days.day = mint.day
        left join 
          query_3463911 as burn on days.day = burn.day
        left join 
          query_2481449 as buffer on days.day = buffer.time  --Lido query
        group by 1
)
SELECT
    day,
    token_mint_amount,
    token_burn_amount,
    token_buffer_amount,
    token_supply_change_amount,
    sum(token_mint_amount) over (order by day asc) as token_total_mint,
    sum(token_burn_amount) over (order by day asc) as token_total_burn,
    token_buffer_amount + sum(token_supply_change_amount) over (order by day asc) as token_total_supply,
    'stETH' as token_name
from totals
order by 1 asc