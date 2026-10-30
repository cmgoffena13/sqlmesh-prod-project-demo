MODEL (
  name fake.products,
  kind FULL,
  ignored_rules ['nomissingaudits', 'nomissingunittest']
);

SELECT
  i AS product_id,
  RAND() * 100 AS price,
  CURRENT_TIMESTAMP() AS created_at
FROM UNNEST(GENERATE_ARRAY(1, 10000)) AS i