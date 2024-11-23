/* Dune query number  - 4322604 */
with days as (select tbl.d from unnest(sequence(date('2021-10-02'), current_date, interval '1' day)) as tbl (d)
),

staked as (
    select
        date_trunc('day', t) as d,
        sum(amount) as amount
    from query_4108361 group by 1
),

totals as (
    select
        days.d,
        cast(coalesce(sum(staked.amount), 0) as double) as token_staked_amount
    from
        days
    left join
        staked
        on days.d = staked.d
    group by 1
)

select
    d,
    token_staked_amount,
    sum(token_staked_amount) over (order by d asc) as total_staked_amount,
    'RPL' as token_name
from totals
order by 1 asc
