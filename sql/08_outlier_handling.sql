-- Purpose:
-- Flag extreme low and high receipt-level values for controlled analysis.

-- Context:
-- A conservative outlier-handling approach was applied after return matching.
-- Instead of removing a full 1% from each side, only the most extreme edge cases were flagged,
-- in order to reduce distortion without excluding too many valid transactions.

-- Logic:
-- 1. Rank cleaned receipts into 1000 buckets based on receipt revenue
-- 2. Flag only the lowest and highest bucket as outliers
-- 3. Preserve all rows while adding an outlier flag for flexible filtering in BI

CREATE TABLE fact_receipts_cleaned_flagged AS
WITH ranked AS (
    SELECT
        *,
        NTILE(1000) OVER (ORDER BY receipt_revenue) AS bucket
    FROM fact_receipts_cleaned
)
SELECT
    *,
    CASE
        WHEN bucket = 1 THEN 1
        WHEN bucket = 1000 THEN 1
        ELSE 0
    END AS is_outlier
FROM ranked;
