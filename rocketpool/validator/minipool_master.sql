select
    minipool.minipool,
    minipool.created_t,
    minipool.destroyed_t,
    minipool.node_address,
    deposits.deposit_type,
    deposits.bond_amount as orig_bond_amount,
    deposits.node_fee as orig_node_fee,
    beacon_dep.beacon_amount_deposited,
    pubkey.pubkey,
    pubkey.validator_index,
    coalesce(reductions.new_bond_amount, deposits.bond_amount) as bond_amount,
    coalesce(reductions.new_node_fee, deposits.node_fee) as node_fee,
    reductions.new_bond_amount is not null as bond_reduced,
    beacon_wth.exited,
    beacon_wth.beacon_amount_withdrawn,
    beacon_wth.beacon_amount_skim_withdrawn,
    coalesce(dist.is_distributed, false) as is_distributed
from query_4108319 as minipool /*minipool_created*/
left join query_4250058 as deposits/*minipool_deposits*/
    on minipool.minipool = deposits.minipool
left join query_4118925 as reductions /* minipool_bond_reductions */
    on minipool.minipool = reductions.minipool
left join query_4250134 as pubkey /* minipool_pubkey_index */
    on minipool.minipool = pubkey.minipool
left join query_4119023 as beacon_dep /* minipool_beacon_deposits */
    on pubkey.pubkey = beacon_dep.pubkey
left join query_4125574 as beacon_wth /* minipool_beacon_withdrawals */
    on deposits.minipool = beacon_wth.minipool
left join query_4125568 as dist /* minipool_beacon_withdrawals */
    on minipool.minipool = dist.minipool
