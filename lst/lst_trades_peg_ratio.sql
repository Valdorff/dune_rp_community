/* Dune query number  - 3480245 */
/* rETH */
select
    hr,
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
from query_3480165

union all

/* cbETH */
select
    hr,
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
from query_3465286

union all

/* stETH */
select
    hr,
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
from query_3480205

union all

/* wstETH */
select
    hr,
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
from query_3642007

union all

/* swETH */
select
    hr,
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
from query_3784121

union all

/* sfrxETH */
select
    hr,
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
from query_3833519
