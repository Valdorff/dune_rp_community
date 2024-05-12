/* Dune query number  - 3621805 */
/* rETH */
select
    block,
    t,
    d,
    token_peg_eth,
    token_name,
    token_contract_address
from
    query_3480099

union all

/* stETH */
select
    block,
    t,
    d,
    token_peg_eth,
    token_name,
    token_contract_address
from
    query_3621788

union all

/* cbETH */
select
    block,
    t,
    d,
    token_peg_eth,
    token_name,
    token_contract_address
from
    query_3465256
