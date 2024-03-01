/* Dune query number  - 3465242 */
with
  trades AS (
    SELECT
      block_time AS time,
      0xBe9895146f7AF43049ca1c1AE358B0541Ea49704 as token_contract_address,
      CASE
        WHEN token_bought_address = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704 THEN token_bought_amount
        ELSE token_sold_amount
      END AS token_trade_amount,
      amount_usd as token_trade_amount_usd
    FROM
      dex.trades
    WHERE
      blockchain = 'ethereum'
      AND (
        token_bought_address = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
        OR token_sold_address = 0xBe9895146f7AF43049ca1c1AE358B0541Ea49704
      )
      AND block_time >= CAST('2022-02-07' AS TIMESTAMP)
      and amount_usd > 10
  )
SELECT
  tr.time,
  date_trunc('day',tr.time) as day,
  tr.token_trade_amount,
  tr.token_trade_amount_usd,
  tr.token_trade_amount_usd / CAST(pr.price AS DOUBLE) AS token_trade_amount_eth, /* Trade size in USD divided by USD/ETH is amount of USD. */
  'cbETH' as token_name,
  tr.token_contract_address
FROM
  trades AS tr
  JOIN prices.usd AS pr ON pr.minute = DATE_TRUNC('minute', tr.time)
  AND pr.symbol = 'WETH'
  AND NOT tr.token_trade_amount_usd IS NULL /* We need to drop trades if the ETH amount will be unknown. */
  AND NOT pr.price IS NULL
  AND pr.price > 0
WHERE
  pr.blockchain = 'ethereum'