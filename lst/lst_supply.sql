/* Dune query number  - 3464170 */
/* rETH */
SELECT
    day,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
FROM query_3440968
UNION ALL
/* cbETH */
SELECT
    day,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
FROM query_3441005
UNION ALL
/* stETH */
SELECT
    day,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
FROM query_3458937