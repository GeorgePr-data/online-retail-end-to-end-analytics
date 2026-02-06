-- 03_fact_transactions.sql
-- Purpose: Daily product performance by country

CREATE TABLE fact_transactions AS
SELECT
    product_id,
    Country,
    DATE(invoice_dt) AS sales_date,
    SUM(Quantity) AS total_quantity,
    SUM(Quantity * unit_price) AS total_revenue
FROM stg_transactions
GROUP BY
    product_id,
    Country,
    DATE(invoice_dt);
