/* Dune query number  - 3742160 */
select
    call_block_number as block,
    call_block_time as t,
    date_trunc('day', call_block_time) as d,
    output_0 / 1e18 as token_peg_eth,
    0xbf5495efe5db9ce00f80364c8b423567e58d2110 as token_contract_address,
    'ezETH' as token_name
from
    renzo_ethereum.balancerrateprovider_call_getrate
where
    call_success = true
