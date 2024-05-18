/* Dune query number  - 3742163 */
with weth as (
    select
        date_trunc('hour', minute) as hr,
        avg(price) as price
    from
        prices.usd
    where
        contract_address = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
        and minute >= cast(current_timestamp - interval '1' year as timestamp)
    group by
        date_trunc('hour', minute)
)
,
token as (
    select
        date_trunc('hour', minute) as hr,
        contract_address,
        avg(price) as price
    from
        prices.usd
    where
        contract_address = 0xbf5495efe5db9ce00f80364c8b423567e58d2110
        and minute >= cast(current_timestamp - interval '1' year as timestamp)
    group by
        date_trunc('hour', minute),
        contract_address
)

select
    token.hr,
    token.contract_address as token_contract_address,
    'ezETH' as token_name,
    token.price as token_price_usd,
    weth.price as weth_price_usd,
    token.price / weth.price as token_price_eth
from
    token
inner join weth on
    token.hr = weth.hr
