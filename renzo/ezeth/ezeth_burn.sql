/* Dune query number  - 3738613 */
select
    date_trunc('day', evt_block_time) as d,
    0xbf5495efe5db9ce00f80364c8b423567e58d2110 as token_contract_address,
    'ezETH' as token_name,
    sum(ezethburned) as token_burn_amount
from renzo_ethereum.restakemanager_evt_userwithdrawcompleted
group by 1, 2
