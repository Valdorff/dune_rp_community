/* Dune query number  - 3429922 */
SELECT
  date_trunc('day',call_block_time) as day,
  contract_address as token_contract_address,
  'RPL' as token_name,
  sum(output_0) / 1e18 as token_mint_amount
FROM
  rocketpool_ethereum.RocketTokenRPL_call_inflationMintTokens
WHERE
  output_0 > 0
group by 
    1,2
UNION ALL
VALUES(cast('2021-10-02 00:00' as timestamp)
    , 0xd33526068d116ce69f19a9ee46f0bd304f21a51f 
    ,'RPL'
    , 17863991.22041118917 
    )