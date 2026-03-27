# Online Retail SQL Analytics Project

## Overview
End-to-end SQL analytics project built on a real-world online retail transaction dataset.

The focus of the project is not just querying data, but structuring raw transactional data into a clean analytical model that can support reliable analysis and future BI use cases.

## Dataset
Public online retail dataset (~500k rows).

- Each row represents a **product line within a customer invoice**
- A single invoice may contain multiple products (multiple rows)
- Data includes sales quantities, prices, timestamps, and countries

## Business Objective

The goal of this project is to simulate how raw retail transaction data can be transformed into a structured model that supports real analytical and BI use cases.

It is designed to support questions such as:

- Which products drive the highest revenue over time?
- How does customer purchase behavior vary at invoice level?
- How should transaction data be structured to support both operational analysis and reporting?

## Dataset

Public online retail transaction dataset (~500k rows).

Each row represents a product line within a customer invoice:

- one invoice can include multiple products
- data is recorded at line level (not basket level)
- includes quantities, prices, timestamps, and country

## Data Pipeline

### Raw Layer
**`raw_online_retail`**
- Direct CSV ingestion
- No transformations applied
- Preserves original data for traceability

### Staging Layer
**`stg_transactions`**

Key transformations: 

- Parsed text-based dates into proper datetime values
- Parsed text-based prices into numeric values
- Removed non-product rows (fees, postage, adjustments)
- applied filtering after parsing to avoid casting issues

### Fact Tables

**`fact_transactions`**
- Grain: **product × country × day**
- Metrics:
  - total_quantity
  - total_revenue
- Supports product performance and time-series analysis

**`fact_receipts`**
- Grain: **invoice (receipt)**
- Metrics:
  - receipt_quantity
  - receipt_revenue
  - distinct_products
- Supports basket and customer behavior analysis

### Dimension Tables

**`dim_product`**
- One row per product
- Deduplicated by product_id
- Deterministic description selection

**`dim_date`**
- One row per calendar date
- Includes year, month, quarter, and weekday attributes

## Schema Design

The model follows a star-schema approach with multiple fact tables at different grains:

- product-level fact table for trend analysis
- invoice-level fact table for basket and customer behavior

This separation allows more flexible analysis compared to a single flat table and better reflects real BI modeling practices.

## Key Analytical Questions

This project focuses on four main analytical areas:

1. Product Performance
Which products drive the highest quantity and revenue over time?

2. Time-Based Trends
How do sales evolve across months, quarters, and weekdays?

3. Basket / Invoice Behavior
What does invoice-level data reveal about order size and product mix?

4. Data Modeling for BI
How should transactional data be structured to support consistent reporting?

## What I Focused On

In this project, I focused on building a structured analytical layer rather than just writing queries.

Specifically:

- transforming raw transactional data into clean, usable tables
- designing fact tables at different grains depending on analytical needs
- separating product-level and invoice-level analysis
- handling real-world data issues such as inconsistent formats and non-product rows

The goal was to simulate how raw retail data can be prepared for reliable analysis and future BI reporting.

## Key Learnings

- filtering conditions should be applied after parsing when working with text-based numeric fields
- product descriptions may not be consistent, so stable identifiers are critical
- different analytical questions require different data grains
- real-world datasets require explicit cleaning and validation steps

## Tools
- MySQL
- GitHub

## Next Steps
- connect the model to Power BI for reporting
- extend with additional dimensions (e.g. customer segmentation)
- build customer-level analysis (repeat behavior, segmentation)
