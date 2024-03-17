/* Dune query number  - 3463887 */
select
    date_trunc('day', block_time) as d,
    0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
    'stETH' as token_name,
    sum(cast(value as double)) / 1e18 as token_mint_amount
from
    evms.traces
where
    to = 0x00000000219ab540356cbb839cbe05303d7705fa -- beacon contract
    and blockchain = 'ethereum'
    and block_time >= cast('2020-10-01' as timestamp)
    and call_type = 'call'
    and success = true
    and "from" in (
        0xae7ab96520de3a18e5e111b5eaab095312d7fe84, --stETH contract
        0xb9d7934878b5fb9610b3fe8a5e441e8fad7e293f, --withdrawl vault
        0xfddf38947afb03c621c71b06c9c70bce73f12999 --staking router
    )
group by
    1
