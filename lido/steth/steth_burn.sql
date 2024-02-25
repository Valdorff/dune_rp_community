/* Dune query number  - 3463911 */
SELECT 
    date_trunc('day', block_time) as day,
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
    'stETH' as token_name,
    SUM(CASE WHEN amount BETWEEN 20000000000 AND 32000000000 THEN CAST(amount AS DOUBLE)/1e9 
    WHEN amount > 32000000000 THEN 32 ELSE 0 END) AS token_burn_amount
FROM ethereum.withdrawals
WHERE address = 0xB9D7934878B5FB9610B3fE8A5e441e8fad7E293f --withdrawl vault
    AND amount >= 20000000000 
GROUP BY 1

