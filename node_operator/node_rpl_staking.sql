/* Dune query number  - 4108361 */
with
rpl_staked as (
    select
        "from" as node_address,
        cast(amount / 1e18 as double) as amount,
        evt_block_time as t
    from
        rocketpool_ethereum.RocketNodeStaking_evt_RPLStaked
)
,
rpl_withdrawn as (
    select
        to as node_address,
        -1 * cast(amount / 1e18 as double) as amount,
        evt_block_time as t
    from
        rocketpool_ethereum.RocketNodeStaking_evt_RPLWithdrawn
)
,
rpl_slashed as (
    select
        node as node_address,
        evt_block_time as t,
        -1 * cast(amount / 1e18 as double) as amount
    from
        rocketpool_ethereum.RocketNodeStaking_evt_RPLSlashed
)

select
    node_address,
    t,
    amount
from rpl_staked
union all
select
    node_address,
    t,
    amount
from rpl_withdrawn
union all
select
    node_address,
    t,
    amount
from rpl_slashed
