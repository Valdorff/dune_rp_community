/* Dune query number  - 4250134 */
with pubkey as (
    select
        pubkey,
        minipool
    from query_4250058  --minipool_deposit

)

select
    pubkey.minipool,
    pubkey.pubkey,
    index.validator_index
from
    query_4278045 as index --validator_pubkey_index
inner join pubkey on index.pubkey = pubkey.pubkey
