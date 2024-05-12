/* Dune query number  - 3621788 */
select
    cast(evt_block_number as bigint) as block,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    posttotalether / cast(posttotalshares as double) as token_peg_eth,
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
    'stETH' as token_name
from
    lido_ethereum.steth_evt_tokenrebased
union all
select
    cast(evt_block_number as bigint) as block,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    posttotalpooledether / cast(totalshares as double) as token_peg_eth,
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
    'stETH' as token_name
from
    lido_ethereum.legacyoracle_evt_posttotalshares
where
    evt_block_time >= cast('2022-09-01 00:00' as timestamp)
    and evt_block_time <= cast('2023-05-16 00:00' as timestamp)
