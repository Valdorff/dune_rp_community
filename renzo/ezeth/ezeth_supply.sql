/* Dune query number  - 3738624 */
with days as (select tbl.d from unnest(sequence(date('2023-12-06'), current_date, interval '1' day)) as tbl (d)
),

totals as (
    select
        days.d,
        cast(coalesce(sum(mint.token_mint_amount), 0) as double) as token_mint_amount,
        cast(coalesce(sum(burn.token_burn_amount), 0) as double) as token_burn_amount,
        cast(coalesce(sum(mint.token_mint_amount), 0) as double)
        - cast(coalesce(sum(burn.token_burn_amount), 0) as double) as token_supply_change_amount
    from days
    left join
        query_3738564 as mint
        on days.d = mint.d
    left join
        query_3738613 as burn
        on days.d = burn.d
    group by 1
)

select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    sum(token_mint_amount) over (order by d asc) as token_total_mint,
    sum(token_burn_amount) over (order by d asc) as token_total_burn,
    sum(token_supply_change_amount) over (order by d asc) as token_total_supply,
    'ezETH' as token_name
from totals
order by 1 asc
