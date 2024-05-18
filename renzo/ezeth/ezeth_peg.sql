/* Dune query number  - 3742160 */
select
    cast(evt_block_number as bigint) as block,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    sum(amount) / sum(cast(ezethminted as double)) as token_peg_eth,
    0xbf5495efe5db9ce00f80364c8b423567e58d2110 as token_contract_address,
    'ezETH' as token_name
from
    renzo_ethereum.restakemanager_evt_deposit
group by
    1, 2, 3, 5
