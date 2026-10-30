MODEL (
  name fake.transactions,
  kind FULL,
  ignored_rules ['nomissingaudits', 'nomissingunittest']
);

SELECT
  t * 10000 + prod.product_id AS transaction_id,
  prod.product_id,
  TIMESTAMP_ADD('2026-01-01 00:00:00'::TIMESTAMP, INTERVAL (
    CAST(RAND() * 290 * 24 * 60 AS INT64)
  ) MINUTE) AS sale_timestamp,
  ROUND(prod.price * (
    0.5 + RAND()
  ), 2) AS sale_amount
FROM fake.products AS prod
CROSS JOIN UNNEST(GENERATE_ARRAY(1, 5)) AS t