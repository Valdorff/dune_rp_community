/* Dune query number  - 4129671 */
with deposits as (
    select
        _expectedminipooladdress as minipool,
        call_block_time as t,
        _bondamount / 1e18 as bond_amount,
        _validatorpubkey as pubkey,
        _minimumnodefee as node_fee
    from
        rocketpool_ethereum.rocketnodedeposit_call_createvacantminipool
    where call_success = true
)
,
/* there were duplicate public keys used on 5 vacant minipools.  this will ensure minipool is valid */
promoted as (
    select to as minipool
    from
        ethereum.transactions
    where
        data = 0x13dc01dc /*promote*/
        and to in (
            select minipool
            from
                deposits
        )
        and success = true
)

select
    deposits.minipool,
    deposits.t,
    deposits.bond_amount,
    deposits.pubkey,
    deposits.node_fee
from
    deposits
inner join promoted on
    deposits.minipool = promoted.minipool
