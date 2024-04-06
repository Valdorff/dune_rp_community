/* Dune query number  - 3480099 */
with
reth_evt_preatlas as (
    select
        evt_block_time as t,
        date_trunc('day', evt_block_time) as d,
        block,
        totaleth,
        rethsupply
    from
        rocketnetwork_ethereum.rocketnetworkbalances_evt_balancesupdated
    where
        evt_block_time >= cast('2022-07-15 00:00' as timestamp)
),

reth_evt_atlas as (
    -- Grab BalancesUpdated(_block, _totalEth, _stakingEth, _rethSupply, block.timestamp);
    select
        block_time as t,
        date_trunc('day', block_time) as d,
        bytearray_to_uint256(bytearray_substring(data, 1, 32)) as block,
        bytearray_to_uint256(bytearray_substring(data, 33, 32)) as totaleth,
        bytearray_to_uint256(bytearray_substring(data, 97, 32)) as rethsupply
    from
        ethereum.logs
    where
        contract_address = 0x07fcabcbe4ff0d80c2b1eb42855c0131b6cba2f4
        and topic0 = 0x7bbbb137fdad433d6168b1c75c714c72b8abe8d07460f0c0b433063e7bf1f394
)

select
    t,
    d,
    block,
    totaleth / cast(rethsupply as double) as token_peg_eth,
    0xae78736cd615f374d3085123a210448e74fc6393 as token_contract_address,
    'rETH' as token_name
from
    reth_evt_preatlas
union
select
    t,
    d,
    block,
    totaleth / cast(rethsupply as double) as token_peg_eth,
    0xae78736cd615f374d3085123a210448e74fc6393 as token_contract_address,
    'rETH' as token_name
from
    reth_evt_atlas
order by 1 asc
