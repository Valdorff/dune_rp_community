/* Dune query number  - 4125671 */
with minipools as (
    select
        node_address,
        sum(case when beacon_amount_deposited > 0 then 1 else 0 end) as total_minipools,
        sum(case when beacon_amount_deposited > 1 and exited = false then 1 else 0 end) as active_minipools,
        sum(case when beacon_amount_deposited > 1 and exited = true then 1 else 0 end) as exited_minipools,
        sum(case when exited = false and beacon_amount_deposited > 1 then beacon_amount_deposited else 0 end)
            as active_effective_stake,
        sum(case when exited = false and beacon_amount_deposited > 1 then bond_amount else 0 end) as active_bond_amount
    from query_4125671 /*minipool_master*/
    group by 1
)
,
rpl_stake as (
    select
        node_address,
        round(sum(amount), 8) as rpl_staked_amount
    from query_4108361 /*node_rpl_staking*/
    group by 1
)
,
rpl_price as (
    select price as rpl_price_usd
    from prices.usd_latest
    where contract_address = 0xD33526068D116cE69F19A9ee46F0bd304F21A51f
)
,
weth_price as (
    select price as weth_price_usd
    from prices.usd_latest
    where contract_address = 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
)

select
    nodes.node_address,
    nodes.node_ens,
    nodes.t as node_registered_t,
    minipools.total_minipools,
    minipools.active_minipools,
    minipools.exited_minipools,
    minipools.active_effective_stake,
    minipools.active_bond_amount,
    minipools.active_effective_stake - minipools.active_bond_amount as active_borrowed_amount,
    rpl_stake.rpl_staked_amount,
    (select rpl_price_usd from rpl_price)
    / (select weth_price_usd from weth_price) as rpl_weth_price_ratio,
    (select rpl_price_usd from rpl_price)
    / (select weth_price_usd from weth_price) * rpl_stake.rpl_staked_amount as rpl_staked_amount_weth,
    case when minipools.active_effective_stake > 0
            then
                (
                    (select rpl_price_usd from rpl_price
                    ) / (select weth_price_usd from weth_price
                    ) * rpl_stake.rpl_staked_amount
                )
                / (minipools.active_effective_stake - minipools.active_bond_amount)
        else 0
    end as rpl_collateral_ratio,
    smooth.in_smoothing_pool,
    smooth.t as in_smoothing_pool_t
from query_4108312 as nodes /* node_operators */
left join minipools on nodes.node_address = minipools.node_address
left join rpl_stake on nodes.node_address = rpl_stake.node_address
left join query_4118898 as smooth on nodes.node_address = smooth.node_address
