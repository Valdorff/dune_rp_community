/* Dune query number  - 4118904 */
select
    _expectedMinipoolAddress as minipool,
    call_block_time as t,
    coalesce(_bondAmount / 1e18, 16) as bond_amount,
    _validatorPubkey as pubkey,
    _minimumNodeFee / 1e18 as node_fee
from
    rocketpool_ethereum.RocketNodeDeposit_call_deposit
where
    call_success = true
    and _expectedMinipoolAddress is not null
