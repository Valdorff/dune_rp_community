/* Dune query number  - 3463887 */
SELECT
  date_trunc('day', block_time) as day,
  0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
  'stETH' as token_name,
  SUM(cast(value AS DOUBLE)) / 1e18 AS token_mint_amount
FROM
  evms.traces
WHERE
  to = 0x00000000219ab540356cbb839cbe05303d7705fa -- beacon contract
  AND blockchain = 'ethereum'
  AND block_time >= CAST('2020-10-01' as timestamp)
  AND call_type = 'call'
  AND success = True
  AND "from" in (
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 --stETH contract
    ,0xB9D7934878B5FB9610B3fE8A5e441e8fad7E293f --withdrawl vault
    ,0xFdDf38947aFB03C621C71b06C9C70bce73f12999 --staking router
  ) 
GROUP BY
  1