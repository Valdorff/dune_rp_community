/* Dune query number  - 3440997 */
SELECT
  date_trunc('day', evt_block_time) as day,
  contract_address as token_contract_address,
  'cbETH' as token_name,
  SUM(value / CAST(1e18 AS DOUBLE)) AS token_burn_amount
FROM
  evms.erc20_transfers
WHERE
  contract_address = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
  AND "to" = 0x0000000000000000000000000000000000000000
  AND blockchain = 'ethereum'
GROUP BY
  1,2