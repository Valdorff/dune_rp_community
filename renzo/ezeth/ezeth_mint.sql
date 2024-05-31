/* Dune query number  - 3738564 */
select
    date_trunc('day', evt_block_time) as d,
    0xbf5495efe5db9ce00f80364c8b423567e58d2110 as token_contract_address,
    'ezETH' as token_name,
    sum(cast(ezethminted as double)) / 1e18 as token_mint_amount
from
    renzo_ethereum.restakemanager_evt_deposit
group by
    1, 2
