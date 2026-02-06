-- 04_fact_receipts.sql
-- Purpose: Invoice-level (receipt) aggregation for basket analysis

CREATE TABLE fact_receipts AS
SELECT
    InvoiceNo,
    Country,
    DATE(invoice_dt) AS sales_date,
    SUM(Quantity) AS receipt_quantity,
    SUM(Quantity * unit_price) AS receipt_revenue,
    COUNT(DISTINCT product_id) AS distinct_products
FROM stg_transactions
GROUP BY
    InvoiceNo,
    Country,
    DATE(invoice_dt);
