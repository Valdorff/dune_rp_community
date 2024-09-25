/* Dune query number  - 4090664 */
with
pools as (
    select
        project,
        blockchain,
        pool
    from query_4098252
)
,
erc20_in as (
    select
        transfers.blockchain,
        pool.pool,
        transfers.d,
        sum(transfers.value) as amount_in
    from pools as pool
    inner join query_4098262 as transfers
        on pool.pool = transfers.to and pool.blockchain = transfers.blockchain
    group by 1, 2, 3
)
,
erc20_out as (
    select
        transfers.blockchain,
        pool.pool,
        transfers.d,
        sum(transfers.value) as amount_out
    from pools as pool
    inner join query_4098262 as transfers
        on pool.pool = transfers."from" and pool.blockchain = transfers.blockchain
    group by 1, 2, 3
)
,
days as (
    select distinct
        tbl.d,
        pools.pool,
        pools.blockchain
    from unnest(sequence(date('2021-10-02'), current_date, interval '1' day)) as tbl (d)
    cross join pools
)
,
erc20_agg as (
    select
        days.pool,
        days.blockchain,
        days.d,
        (cast(amount_in as double) - coalesce(cast(amount_out as double), 0))
        / pow(10, 18) as balance
    from days
    left join erc20_in on days.d = erc20_in.d and days.pool = erc20_in.pool and days.blockchain = erc20_in.blockchain
    left join
        erc20_out
        on days.d = erc20_out.d and days.pool = erc20_out.pool and days.blockchain = erc20_out.blockchain
)

select
    pools.project,
    pools.blockchain,
    erc20_agg.d,
    erc20_agg.pool,
    'rETH' as token_name,
    sum(erc20_agg.balance) as net_flow
from erc20_agg
left join pools on erc20_agg.pool = pools.pool and erc20_agg.blockchain = pools.blockchain
group by 1, 2, 3, 4
