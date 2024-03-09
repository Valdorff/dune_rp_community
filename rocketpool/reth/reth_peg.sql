/* Dune query number  - 3480099 */
with
  reth_evt_preatlas AS (
    SELECT
      evt_block_time as time,
      date_trunc('day', evt_block_time) as day,
      block,
      totalEth,
      rethSupply
    FROM
      rocketnetwork_ethereum.RocketNetworkBalances_evt_BalancesUpdated
    WHERE
      evt_block_time >= cast('2022-07-15 00:00' as timestamp)
  ),
  reth_evt_atlas AS (
    -- Grab BalancesUpdated(_block, _totalEth, _stakingEth, _rethSupply, block.timestamp);
    SELECT
      block_time as time,
      date_trunc('day', block_time) as day,
      bytearray_to_uint256 (bytearray_substring (data, 1, 32)) as block,
      bytearray_to_uint256 (bytearray_substring (data, 33, 32)) as totalEth,
      bytearray_to_uint256 (bytearray_substring (data, 97, 32)) as rethSupply
    FROM
      ethereum.logs
    WHERE
      contract_address = 0x07FCaBCbe4ff0d80c2b1eb42855C0131b6cba2F4
      AND topic0 = 0x7bbbb137fdad433d6168b1c75c714c72b8abe8d07460f0c0b433063e7bf1f394
  )
SELECT
  time,
  day,
  block,
  "totalEth" / CAST("rethSupply" AS DOUBLE) AS token_peg_eth,
  0xae78736Cd615f374D3085123A210448E74Fc6393 as token_contract_address,
  'rETH' as token_name
from
  reth_evt_preatlas
UNION
SELECT
  time,
  day,
  block,
  "totalEth" / CAST("rethSupply" AS DOUBLE) AS token_peg_eth,
  0xae78736Cd615f374D3085123A210448E74Fc6393 as token_contract_address,
  'rETH' as token_name
from
  reth_evt_atlas
order by 1 asc
