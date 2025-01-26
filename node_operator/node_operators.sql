/* Dune query number  - 4108312 */
with registered as (
    select
        node as node_address,
        evt_block_time as t
    from
        rocketpool_ethereum.rocketnodemanager_evt_noderegistered
)
,
ens as (
    select
        address,
        name
    from
        ens.reverse_latest
)

select
    reg.node_address,
    ens.name as node_ens,
    reg.t
from registered as reg
left join ens on reg.node_address = ens.address
