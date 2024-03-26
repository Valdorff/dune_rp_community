/* Dune query number  - 3440960 */
select
    date_trunc('day', evt_block_time) as d,
    contract_address as token_contract_address,
    'rETH' as token_name,
    sum(cast(amount as double)) / 1e18 as token_burn_amount
from
    rocketpool_ethereum.rockettokenreth_evt_tokensburned
group by
    1, 2
