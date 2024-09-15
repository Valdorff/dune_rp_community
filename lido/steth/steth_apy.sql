/* Dune query number  - 3599576 */
with hours as (
    select
        date_add('hour', step, day) as hr,
        day as d
    from
        unnest(sequence(cast('2022-07-15 00:00' as timestamp), current_date, interval '1' day)) as t (day)
    cross join
        (select * from unnest(sequence(1, 24, 1)) as t (step))
)
,
peg as (
    select
        evt_block_time as t,
        date_trunc('day', evt_block_time) as d,
        evt_block_number as block,
        timeelapsed as t_elapsed,
        posttotalether / cast(posttotalshares as double) as token_peg_eth
    from
        lido_ethereum.steth_evt_tokenrebased
    union all
    select
        evt_block_time as t,
        date_trunc('day', evt_block_time) as d,
        evt_block_number as block,
        timeelapsed as t_elapsed,
        posttotalpooledether / cast(totalshares as double) as token_peg_eth
    from
        lido_ethereum.legacyoracle_evt_posttotalshares
    where
        evt_block_time >= cast('2022-09-01 00:00' as timestamp)
        and evt_block_time <= cast('2023-05-16 00:00' as timestamp)
)
,

pre_apy as (
    select
        t,
        date_trunc('hour', t) as hr,
        d,
        lag(t) over (order by t) as prev_t,
        t - lag(t) over (order by t) as t_elapsed,
        block,
        lag(block) over (order by block) as prev_block,
        token_peg_eth,
        lag(token_peg_eth) over (order by t) as prev_token_peg_eth,
        100 * (token_peg_eth / lag(token_peg_eth) over (order by t) - 1) as peg_chg,
        0xae7ab96520de3a18e5e111b5eaab095312d7fe84 as token_contract_address,
        'stETH' as token_name,
        lead(date_trunc('hour', t)) over (order by date_trunc('hour', t)) as next_hr
    from
        peg
)
,

apy as (
    select
        hours.hr,
        hours.d,
        pre_apy.prev_t,
        pre_apy.block,
        pre_apy.prev_block,
        pre_apy.token_peg_eth,
        pre_apy.prev_token_peg_eth,
        pre_apy.peg_chg,
        day(pre_apy.t_elapsed) * 86400 + hour(pre_apy.t_elapsed) * 3600
        + minute(pre_apy.t_elapsed) * 60 + second(pre_apy.t_elapsed) as t_elapsed,
        31536000 / nullif(coalesce((
            day(pre_apy.t_elapsed) * 86400 + hour(pre_apy.t_elapsed) * 3600
            + minute(pre_apy.t_elapsed) * 60 + second(pre_apy.t_elapsed)
        ), 0
        ), 0) * pre_apy.peg_chg as apy,
        pre_apy.token_contract_address,
        pre_apy.token_name,
        case
            when
                pre_apy.peg_chg is not null
                then rank() over (order by case when pre_apy.peg_chg is not null then hours.hr end asc)
        end as hr_number
    from hours
    left join pre_apy on
        hours.hr >= pre_apy.hr
        and hours.hr < pre_apy.next_hr
)

select
    hr,
    d,
    block,
    token_peg_eth,
    apy,
    case when hr_number >= 24 then
            avg(apy) over (order by hr asc rows between 24 preceding and current row)
    end as apy_1d,
    case when hr_number >= 168 then
            avg(apy) over (order by hr asc rows between 168 preceding and current row)
    end as apy_7d,
    case when hr_number >= 720 then
            avg(apy) over (order by hr asc rows between 720 preceding and current row)
    end as apy_30d,
    case when hr_number >= 2160 then
            avg(apy) over (order by hr asc rows between 2160 preceding and current row)
    end as apy_90d,
    case when hr_number >= 2880 then
            avg(apy) over (order by hr asc rows between 2880 preceding and current row)
    end as apy_120d,
    date_trunc('hour', prev_t) as prev_hr,
    prev_block,
    prev_token_peg_eth,
    t_elapsed,
    peg_chg,
    token_contract_address,
    token_name
from
    apy
