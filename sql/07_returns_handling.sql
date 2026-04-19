-- Purpose:
-- Identify and remove direct, high-confidence return matches from invoice-level data.

-- Context:
-- This step focuses only on direct return matches with clear one-to-one relationships.
-- More complex or indirect return patterns may still exist in the dataset.

-- Logic:
-- 1. Detect return invoices (prefix "C")
-- 2. Search for nearby original invoices within a +/- 5 invoice number range
-- 3. Validate matches using equal and opposite quantity and revenue
-- 4. Keep only uniquely matched return invoices (avoid ambiguous matches)
-- 5. Exclude both the return invoice and its matched original invoice

CREATE TABLE fact_receipts_cleaned AS
WITH candidate_pairs AS (
    SELECT
        r.InvoiceNo AS return_invoice,
        o.InvoiceNo AS original_invoice
    FROM fact_receipts r
    JOIN fact_receipts o
        ON ABS(CAST(o.InvoiceNo AS SIGNED) - CAST(SUBSTRING(r.InvoiceNo, 2) AS SIGNED)) <= 5
    WHERE r.InvoiceNo LIKE 'C%'
      AND o.InvoiceNo NOT LIKE 'C%'
      AND r.total_items = -o.total_items
      AND ROUND(r.receipt_revenue, 2) = ROUND(-o.receipt_revenue, 2)
),
single_match_returns AS (
    SELECT
        return_invoice
    FROM candidate_pairs
    GROUP BY return_invoice
    HAVING COUNT(*) = 1
),
valid_pairs AS (
    SELECT
        cp.return_invoice,
        cp.original_invoice
    FROM candidate_pairs cp
    JOIN single_match_returns smr
        ON cp.return_invoice = smr.return_invoice
),
to_remove AS (
    SELECT return_invoice AS InvoiceNo FROM valid_pairs
    UNION
    SELECT original_invoice AS InvoiceNo FROM valid_pairs
)
SELECT *
FROM fact_receipts
WHERE InvoiceNo NOT IN (SELECT InvoiceNo FROM to_remove);
