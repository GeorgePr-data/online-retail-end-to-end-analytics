-- 05_dim_product.sql
-- Purpose: Product dimension with one row per product

CREATE TABLE dim_product AS
SELECT
    product_id,
    MIN(Description) AS Description
FROM stg_transactions
GROUP BY product_id;

ALTER TABLE dim_product
MODIFY product_id VARCHAR(20) NOT NULL,
ADD PRIMARY KEY (product_id);
