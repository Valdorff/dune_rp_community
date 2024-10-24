/* Dune query number  - 4098262 */
select
    blockchain,
    'rETH' as token_name,
    to,
    "from",
    evt_block_time,
    date_trunc('day', evt_block_time) as d,
    value
from
    evms.erc20_transfers
where
/*rETH address */
    ((
        blockchain = 'ethereum'
        and contract_address = 0xae78736cd615f374d3085123a210448e74fc6393
    )
    or
    (
        blockchain = 'arbitrum'
        and contract_address = 0xec70dcb4a1efa46b8f2d97c310c9c4790ba5ffa8
    )
    or
    (
        blockchain = 'optimism'
        and contract_address = 0x9bcef72be871e61ed4fbbc7630889bee758eb81d
    )
    or
    (
        blockchain = 'base'
        and contract_address = 0xb6fe221fe9eef5aba221c348ba20a1bf5e73624c
    ))
    and evt_block_time >= cast('2021-10-02' as timestamp)
    and value > 0
