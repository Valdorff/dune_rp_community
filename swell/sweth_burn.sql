/* Dune query number  - 3763830 */
select
    date_trunc('day', evt_block_time) as d,
    contract_address as token_contract_address,
    'swETH' as token_name,
    sum(swethburned / cast(1e18 as double)) as token_burn_amount
from
    swell_v3_ethereum.sweth_evt_ethwithdrawn
group by
    1, 2
