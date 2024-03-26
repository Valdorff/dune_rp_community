/* Dune query number  - 3465256 */
select
    cast(evt_block_number as bigint) as block,
    evt_block_time as t,
    date_trunc('day', evt_block_time) as d,
    cast(newexchangerate as double) / 1e18 as token_peg_eth,
    0xbe9895146f7af43049ca1c1ae358b0541ea49704 as token_contract_address,
    'cbETH' as token_name
from
    coinbase_ethereum.stakedtokenv1_evt_exchangerateupdated
where
    evt_block_time >= cast('2022-07-15 00:00' as timestamp)
