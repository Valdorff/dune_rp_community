/* Dune query number  - 3464170 */
/* rETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3440968

union all

/* cbETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3441005

union all

/* stETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3458937

union all

/* ezETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3738624

union all

/* swETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3763838

union all

/* sfrxETH */
select
    d,
    token_mint_amount,
    token_burn_amount,
    token_supply_change_amount,
    token_total_mint,
    token_total_burn,
    token_total_supply,
    token_name
from query_3810114
