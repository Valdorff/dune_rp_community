/* Dune query number  - 3440999 */
select
    date_trunc('day', evt_block_time) as d,
    contract_address as token_contract_address,
    'cbETH' as token_name,
    sum(value / cast(1e18 as double)) as token_mint_amount
from
    evms.erc20_transfers
where
    contract_address = 0xbe9895146f7af43049ca1c1ae358b0541ea49704
    and "from" = 0x0000000000000000000000000000000000000000
    and blockchain = 'ethereum'
group by
    1, 2
