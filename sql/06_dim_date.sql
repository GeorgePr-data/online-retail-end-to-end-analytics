-- 06_dim_date.sql
-- Purpose: Date dimension for time-based analysis

CREATE TABLE dim_date AS
SELECT DISTINCT
    DATE(invoice_dt) AS date,
    YEAR(invoice_dt) AS year,
    MONTH(invoice_dt) AS month,
    MONTHNAME(invoice_dt) AS month_name,
    QUARTER(invoice_dt) AS quarter,
    DAYNAME(invoice_dt) AS day_of_week
FROM stg_transactions;

ALTER TABLE dim_date
ADD PRIMARY KEY (date);
