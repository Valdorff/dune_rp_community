/* Dune query number  - 4118898 */
select
    node as node_address,
    max(evt_block_time) as t,
    max_by(state, evt_block_time) as in_smoothing_pool
from
    rocketpool_ethereum.rocketnodemanager_evt_nodesmoothingpoolstatechanged
group by
    node
