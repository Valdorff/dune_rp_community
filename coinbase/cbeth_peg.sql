/* Dune query number  - 3465256 */
SELECT
  CAST(evt_block_number as bigint) as block,
  evt_block_time as time,
  date_trunc('day',evt_block_time) as day,
  cast(newExchangeRate as double) / 1e18 AS token_peg_eth,
  0xBe9895146f7AF43049ca1c1AE358B0541Ea49704 as token_contract_address,
  'cbETH' as token_name
FROM
  coinbase_ethereum.StakedTokenV1_evt_ExchangeRateUpdated
WHERE
  evt_block_time >= cast('2022-07-15 00:00' as timestamp)
ORDER BY
  time ASC