/* Dune query number  - 4125574 */
with
pub_key as (
    select
        minipool,
        pubkey,
        validator_index
    from
        query_4250134 --validator_pubkey_index
),

withdrawals as (
    select
        wth.block_time as t,
        pky.validator_index,
        wth.amount / 1e9 as amount,
        pky.minipool,
        pky.pubkey
    from
        pub_key as pky
    inner join ethereum.withdrawals as wth
        on pky.validator_index = wth.validator_index
)

select
    minipool,
    validator_index,
    pubkey,
    sum(amount) as beacon_amount_withdrawn,
    sum(if(amount < 8, amount, 0)) as beacon_amount_skim_withdrawn,
    bool_or(amount > 8) as exited
from
    withdrawals
group by
    1,
    2,
    3
