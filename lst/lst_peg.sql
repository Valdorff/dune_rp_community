/* Dune query number  - 3621805 */
/* rETH */
with peg as (
    select
        block,
        t,
        d,
        token_peg_eth,
        token_name,
        token_contract_address
    from
        query_3480099

    union all

    /* stETH */
    select
        block,
        t,
        d,
        token_peg_eth,
        token_name,
        token_contract_address
    from
        query_3621788

    union all

    /* cbETH */
    select
        block,
        t,
        d,
        token_peg_eth,
        token_name,
        token_contract_address
    from
        query_3465256

    union all

    /* swETH */
    select
        block,
        t,
        d,
        token_peg_eth,
        token_name,
        token_contract_address
    from
        query_3766963

    union all

    /* sfrxETH */
    select
        block,
        t,
        d,
        token_peg_eth,
        token_name,
        token_contract_address
    from
        query_3810178

)
,
times as (
    select
        block,
        t,
        d
    from
        peg
)

select
    times.block,
    times.t,
    times.d,
    pegs.token_peg_eth,
    pegs.token_name,
    pegs.token_contract_address
from
    times
left join (
    select
        t,
        token_peg_eth,
        token_name,
        token_contract_address,
        lead(t) over (partition by token_name order by t) as next_t
    from
        peg
) as pegs on
    times.t >= pegs.t
    and times.t < pegs.next_t
