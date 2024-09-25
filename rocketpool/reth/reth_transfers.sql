/* Dune query number  - 4098262 */
select
    transfers.blockchain,
    'rETH' as token_name,
    transfers.to,
    transfers."from",
    transfers.evt_block_time,
    date_trunc('day', transfers.evt_block_time) as d,
    transfers.value
from
    evms.erc20_transfers as transfers
where
/*rETH address */
    ((
        transfers.blockchain = 'ethereum'
        and transfers.contract_address = transfers.0xae78736cd615f374d3085123a210448e74fc6393
    )
    or
    (
        transfers.blockchain = 'arbitrum'
        and transfers.contract_address = transfers.0xec70dcb4a1efa46b8f2d97c310c9c4790ba5ffa8
    )
    or
    (
        transfers.blockchain = 'optimism'
        and transfers.contract_address = transfers.0x9bcef72be871e61ed4fbbc7630889bee758eb81d
    )
    or
    (
        transfers.blockchain = 'base'
        and transfers.contract_address = transfers.0xb6fe221fe9eef5aba221c348ba20a1bf5e73624c
    ))
    and transfers.evt_block_time >= cast('2021-10-02' as timestamp)
    and transfers.value > 0
