/* Dune query number  - 4060394 */
/* rETH */
select
    "from",
    d,
    t,
    token_deposit_amount,
    token_name
from query_4057295

union all

/* stETH */
select
    "from",
    d,
    t,
    token_deposit_amount,
    token_name
from query_4057282
