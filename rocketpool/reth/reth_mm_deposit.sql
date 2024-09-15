/* Dune query number  - 4057295 */
with
txs as (
    select
        "from",
        block_time,
        value,
        hash
    from
        ethereum.transactions
    where
        block_time >= timestamp '2023-02-01'
)

select
    txs."from",
    date(txs.block_time) as d,
    cast(txs.block_time as timestamp) as t,
    txs.value / 1e18 as token_deposit_amount,
    'rETH' as token_name
from
    txs
inner join metamask_ethereum.stakingaggregator_call_deposittorp as mme on txs.hash = mme.call_tx_hash
where mme.call_success = true
