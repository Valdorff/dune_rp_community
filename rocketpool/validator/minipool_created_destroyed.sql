/* Dune query number  - 4108319 */
with created as (
    select
        minipool,
        node as node_address,
        contract_address,
        evt_block_time as created_t
    from
        rocketpool_ethereum.rocketminipoolmanager_evt_minipoolcreated
)
,
destroyed as (
    select
        minipool,
        node as node_address,
        contract_address,
        evt_block_time as destroyed_t
    from
        rocketpool_ethereum.rocketminipoolmanager_evt_minipooldestroyed
)

select
    created.minipool,
    created.node_address,
    created.contract_address,
    created.created_t,
    destroyed.destroyed_t
from created
left join destroyed on created.minipool = destroyed.minipool
