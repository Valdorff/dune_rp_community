/* Dune query number  - 4119023 */
with
pub_key as (
    select
        minipool,
        pubkey
    from
        query_4250058 --minipool_deposit
)

select
    pub_key.minipool,
    pub_key.pubkey,
    sum(
        bytearray_to_uint256(bytearray_reverse(dep.amount)) / 1e9
    ) as beacon_amount_deposited
from
    pub_key
inner join eth2_ethereum.DepositContract_evt_DepositEvent as dep
    on pub_key.pubkey = dep.pubkey
group by
    1,
    2
