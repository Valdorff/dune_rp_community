/* Dune query number  - 3441005 */
with days as (select date as day from unnest(sequence(date('2022-02-07'),CURRENT_DATE,interval '1' day)) tbl(date)
)
, totals as (
    SELECT
        days.day,
        cast(coalesce(sum(token_mint_amount),0) as double) as token_mint_amount,
        cast(coalesce(sum(token_burn_amount),0) as double) as token_burn_amount,
        cast(coalesce(sum(token_mint_amount),0) as double) - cast(coalesce(sum(token_burn_amount),0) as double) as token_supply_change_amount
        from days
        left join 
          query_3440999 as mint on days.day = mint.day
        left join 
          query_3440997 as burn on days.day = burn.day
        group by 1
)
SELECT
    day,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    sum(token_mint_amount) over (order by day asc) as token_total_mint,
    sum(token_burn_amount) over (order by day asc) as token_total_burn,
    sum(token_supply_change_amount) over (order by day asc) as token_total_supply,
    'cbETH' as token_name
from totals
order by 1 asc