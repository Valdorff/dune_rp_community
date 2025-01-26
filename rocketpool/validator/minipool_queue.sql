with
minipool as (
    select minipool
    from
        query_4108319
)
,
minipool_enqueued as (
    select
        evt_block_time as t,
        minipool
    from
        rocketpool_ethereum.RocketMinipoolQueue_evt_MinipoolEnqueued
)
,
minipool_dequeued as (
    select
        evt_block_time as t,
        minipool
    from
        rocketpool_ethereum.RocketMinipoolQueue_evt_MinipoolDequeued
)
,
minipool_removed as (
    select
        evt_block_time as t,
        minipool
    from
        rocketpool_ethereum.RocketMinipoolQueue_evt_MinipoolRemoved
)

select
    minipool.minipool,
    enq.t as enqueued_t,
    coalesce(deq.t, rem.t) as dequeued_t,
    date_diff('day', enq.t, coalesce(deq.t, rem.t)) as queue_days,
    date_diff('hour', enq.t, coalesce(deq.t, rem.t)) as queue_hrs
from
    minipool
left join minipool_enqueued as enq on minipool.minipool = enq.minipool
left join minipool_dequeued as deq on minipool.minipool = deq.minipool
left join minipool_removed as rem on minipool.minipool = rem.minipool
