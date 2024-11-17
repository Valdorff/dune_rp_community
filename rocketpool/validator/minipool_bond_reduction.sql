/* Dune query number  - 4118925 */
select
    minipool,
    evt_block_time as t,
    newBondAmount / 1e18 as new_bond_amount,
    0.14 as new_node_fee
from rocketpool_ethereum.RocketMinipoolBondReducer_evt_BeginBondReduction
