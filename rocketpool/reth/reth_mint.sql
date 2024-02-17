/* Dune query number  - 3440949 */
SELECT
  date_trunc('day', evt_block_time) as day,
  contract_address as token_contract_address,
  'rETH' as token_name,
  SUM(CAST(amount AS DOUBLE)) / 1e18 AS token_mint_amount
FROM
  rocketpool_ethereum.RocketTokenRETH_evt_TokensMinted
group by 
    1,2