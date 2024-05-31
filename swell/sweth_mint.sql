/* Dune query number  - 3763826 */
select
    date_trunc('day', evt_block_time) as d,
    0xf951e335afb289353dc249e82926178eac7ded78 as token_contract_address,
    'swETH' as token_name,
    sum(value / cast(1e18 as double)) as token_mint_amount
from
    swell_v3_ethereum.sweth_evt_transfer
where
    "from" = 0x0000000000000000000000000000000000000000
group by
    1, 2
