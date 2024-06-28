/* Dune query number  - 3810083 */
select
    date_trunc('day', evt_block_time) as d,
    contract_address as token_contract_address,
    'sfrxETH' as token_name,
    sum(cast(value as double)) / 1e18 as token_mint_amount
from
    erc20_ethereum.evt_transfer
where
    contract_address = 0xac3e018457b222d93114458476f3e3416abbe38f
    and "from" = 0x0000000000000000000000000000000000000000
    and evt_block_time >= cast('2022-10-06' as timestamp)
group by
    1, 2
