/* Dune query number  - 3674480 */
/* rETH */
select
    hr,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
from query_3671485

union all

/* cbETH */
select
    hr,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
from query_3664524

union all

/* stETH */
select
    hr,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
from query_3668358

union all

/* wstETH */
select
    hr,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
from query_3656961

union all

/* swETH */
select
    hr,
    token_name,
    token_price_eth,
    token_price_eth_6hr_ma,
    token_peg_eth,
    token_price_peg_ratio,
    token_price_peg_ratio_6hr_ma,
    token_peg_pct_divergence,
    token_peg_pct_divergence_6hr_ma
from query_3784108
