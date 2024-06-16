/* Dune query number  - 3674441 */
/* wstETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3661977

union all

/* stETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3664583

union all

/* cbETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3661946

union all

/* rETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3664567

union all

/* ezETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3742163

union all

/* swETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3763815

union all

/* sfrxETH */
select
    hr,
    token_contract_address,
    token_name,
    token_price_usd,
    weth_price_usd,
    token_price_eth
from
    query_3810147
