/* Dune query number  - 3480245 */
/* rETH */
SELECT
    hour,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_trade_amount_eth,
    token_trade_amount,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
FROM query_3480165
UNION ALL
/* cbETH */
SELECT
    hour,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_trade_amount_eth,
    token_trade_amount,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
FROM query_3465286
UNION ALL
/* stETH */
SELECT
    hour,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_trade_amount_eth,
    token_trade_amount,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
FROM query_3480205