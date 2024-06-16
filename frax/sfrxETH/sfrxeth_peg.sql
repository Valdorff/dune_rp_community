/* Dune query number  - 3810178 */
select
    evt_tx_hash,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    evt_block_number as block,
    assets / cast(shares as double) as token_peg_eth,
    0xac3e018457b222d93114458476f3e3416abbe38f as token_contract_address,
    'sfrxETH' as token_name
from
    frax_ethereum.sfrxeth_evt_deposit
where
    assets > 100 --filter 3 txs under 100 wei
