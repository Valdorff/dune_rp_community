/* Dune query number  - 3766963 */
select
    cast(evt_block_number as bigint) as block,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    cast(newswethtoethrate as double) / 1e18 as token_peg_eth,
    0xf951e335afb289353dc249e82926178eac7ded78 as token_contract_address,
    'swETH' as token_name
from
    swell_v3_ethereum.sweth_evt_reprice
