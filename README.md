# Online Retail SQL Analytics Project

## Overview
End-to-end SQL analytics project built on a real-world online retail transaction dataset.
The project demonstrates raw data ingestion, data cleaning and staging, multi-grain fact
modeling, and dimensional schema design suitable for BI and analytical use.

## Dataset
Public online retail dataset (~500k rows).

- Each row represents a **product line within a customer invoice**
- A single invoice may contain multiple products (multiple rows)
- Data includes sales quantities, prices, timestamps, and countries

## Data Pipeline

### Raw Layer
**`raw_online_retail`**
- Direct CSV ingestion
- No transformations applied
- Preserves original data for traceability

### Staging Layer
**`stg_transactions`**
- Parsed text-based dates into proper datetime
- Parsed text-based prices into numeric values
- Removed non-product rows (fees, postage, adjustments)
- Ensured filtering occurs *after* parsing to avoid implicit casting issues

### Fact Tables

**`fact_transactions`**
- Grain: **product × country × day**
- Metrics:
  - total_quantity
  - total_revenue
- Used for product performance and time-series analysis

**`fact_receipts`**
- Grain: **invoice (receipt)**
- Metrics:
  - receipt_quantity
  - receipt_revenue
  - distinct_products
- Used for basket analysis and customer spending behavior

### Dimension Tables

**`dim_product`**
- One row per product
- Deduplicated by product_id
- Deterministic description selection
- Primary key enforced

**`dim_date`**
- One row per calendar date
- Includes year, month, quarter, and weekday attributes
- Primary key enforced

## Schema Design
The project follows a star-schema style design:
- Fact tables store measurable events
- Dimension tables provide descriptive context
- Different fact tables exist at different grains to support different analytical questions

## Key Decisions & Learnings
- Filtering numeric conditions must occur **after parsing text fields** to avoid data loss
- Product descriptions were not perfectly consistent; products were deduplicated by ID
- Separate fact tables were created for different analytical grains (product vs receipt)
- Real-world data quality issues were handled explicitly rather than assumed away

## Tools
- MySQL
- GitHub

## Next Steps (Optional)
- Connect fact tables to Power BI or Tableau
- Add additional dimensions (e.g. country, customer)
- Extend receipt analysis with spend buckets
