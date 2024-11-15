/* Dune query number  - 4250058 */

/* minipool_deposit_standard */
select
    minipool,
    t,
    bond_amount,
    pubkey,
    node_fee,
    'standard' as deposit_type
from query_4118904

union all

/* minipool_deposit_credit */
select
    minipool,
    t,
    bond_amount,
    pubkey,
    node_fee,
    'credit' as deposit_type
from query_4118914

union all

/* minipool_deposit_vacant */
select
    minipool,
    t,
    bond_amount,
    pubkey,
    node_fee,
    'vacant' as deposit_type
from query_4129671
