with
nodes as (
    select node_address
    from
        query_4108312
)
,
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
        -1 * cast(amount / 1e18 as double) as amount,
        evt_block_time as t
    from
        rocketpool_ethereum.RocketNodeStaking_evt_RPLSlashed
)

select
    nodes.node_address,
    coalesce(rpl_staked.t, rpl_withdrawn.t, rpl_slashed.t) as t,
    coalesce(rpl_staked.amount, rpl_withdrawn.amount, rpl_slashed.amount) as amount
from nodes
left join rpl_staked on nodes.node_address = rpl_staked.node_address
left join rpl_withdrawn on nodes.node_address = rpl_withdrawn.node_address
left join rpl_slashed on nodes.node_address = rpl_slashed.node_address
