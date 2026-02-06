-- 02_stg_transactions.sql
-- Purpose: Clean and stage raw online retail transactions

CREATE TABLE stg_transactions AS
SELECT
    InvoiceNo,
    product_id,
    Description,
    Quantity,
    invoice_dt,
    unit_price,
    Country
FROM (
    SELECT
        InvoiceNo,
        StockCode AS product_id,
        Description,
        Quantity,
        STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') AS invoice_dt,
        CAST(REPLACE(UnitPrice, ',', '.') AS DECIMAL(10,2)) AS unit_price,
        Country
    FROM raw_online_retail
    WHERE
        StockCode REGEXP '[0-9]{4,}'
        AND TRIM(Description) <> ''
) t
WHERE
    invoice_dt IS NOT NULL
    AND unit_price IS NOT NULL
    AND unit_price > 0;
