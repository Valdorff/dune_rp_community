/* Dune query number  - 4098252 */
select distinct
    project,
    blockchain,
    --same vault on all chains, holds tokens for all pools.
    case
        when project = 'balancer'
            and version = '2' then 0xba12222222228d8ba445958a75a0704d566bf2c8
        else project_contract_address
    end as pool,
    'rETH' as token_name
from
    dex.trades
where
    (
        (
            blockchain = 'ethereum'
            and (
                token_sold_address = 0xae78736cd615f374d3085123a210448e74fc6393
                or token_bought_address = 0xae78736cd615f374d3085123a210448e74fc6393
            )
        )
        or (
            blockchain = 'arbitrum'
            and (
                token_sold_address = 0xec70dcb4a1efa46b8f2d97c310c9c4790ba5ffa8
                or token_bought_address = 0xec70dcb4a1efa46b8f2d97c310c9c4790ba5ffa8
            )
        )
        or (
            blockchain = 'optimism'
            and (
                token_sold_address = 0x9bcef72be871e61ed4fbbc7630889bee758eb81d
                or token_bought_address = 0x9bcef72be871e61ed4fbbc7630889bee758eb81d
            )
        )
        or (
            blockchain = 'base'
            and (
                token_sold_address = 0xb6fe221fe9eef5aba221c348ba20a1bf5e73624c
                or token_bought_address = 0xb6fe221fe9eef5aba221c348ba20a1bf5e73624c
            )
        )
    )
    and block_time >= cast('2021-10-02' as timestamp)
