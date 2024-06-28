/* Dune query number  - 3614743 */
/* rETH */
select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    apy_1d,
    apy_7d,
    apy_30d,
    apy_90d,
    apy_120d,
    prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    query_3597612

union

/* stETH */
select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    apy_1d,
    apy_7d,
    apy_30d,
    apy_90d,
    apy_120d,
    prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    query_3599576

union

/* cbETH */
select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    apy_1d,
    apy_7d,
    apy_30d,
    apy_90d,
    apy_120d,
    prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    query_3599495

union

/* swETH */
select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    apy_1d,
    apy_7d,
    apy_30d,
    apy_90d,
    apy_120d,
    prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    query_3784128

union

/* sfrxETH */
select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    apy_1d,
    apy_7d,
    apy_30d,
    apy_90d,
    apy_120d,
    prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    query_3833527
