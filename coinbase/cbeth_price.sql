/* Dune query number  - 3661946 */
with weth as (
    select
        date_trunc('hour', minute) as hr,
        avg(price) as price
    from
        prices.usd
    where
        contract_address = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
        and minute >= cast('2022-07-15 00:00' as timestamp)
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
        contract_address = 0xbe9895146f7af43049ca1c1ae358b0541ea49704
        and minute >= cast('2022-07-15 00:00' as timestamp)
    group by
        date_trunc('hour', minute),
        contract_address
)

select
    token.hr,
    token.contract_address as token_contract_address,
    'cbETH' as token_name,
    token.price as token_price_usd,
    token.price / weth.price as token_price_eth
from
    token
inner join weth on
    token.hr = weth.hr
