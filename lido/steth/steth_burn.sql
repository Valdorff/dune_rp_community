/* Dune query number  - 3463911 */
select
    date_trunc('day', block_time) as d,
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
    'stETH' as token_name,
    sum(case when amount between 20000000000 and 32000000000 then cast(amount as double) / 1e9
        when amount > 32000000000 then 32 else 0
    end) as token_burn_amount
from ethereum.withdrawals
where address = 0xb9d7934878b5fb9610b3fe8a5e441e8fad7e293f --withdrawl vault
    and amount >= 20000000000
group by 1
