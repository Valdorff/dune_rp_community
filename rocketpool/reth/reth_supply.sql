/* Dune query number  - 5780919 */
with days as (select date as day from unnest(sequence(date('2021-10-02'),CURRENT_DATE,interval '1' day)) tbl(date)
)
, totals as (
    SELECT
        days.day,
        cast(coalesce(sum(token_mint_amount),0) as int256) as token_mint_amount,
        cast(coalesce(sum(token_burn_amount),0) as int256) as token_burn_amount,
        cast(coalesce(sum(token_mint_amount),0) as int256) - cast(coalesce(sum(token_burn_amount),0) as int256) as token_supply_change_amount
        from days
        left join 
          query_3440949 as mint on days.day = mint.day
        left join 
          query_3440960 as burn on days.day = burn.day
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
    'rETH' as token_name
from totals
order by 1 asc