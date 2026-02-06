-- 01_raw_ingest.sql
-- Purpose: Load raw Online Retail CSV with no transformations
CREATE TABLE raw_online_retail (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INT,
    InvoiceDate TEXT,
    UnitPrice TEXT,
    CustomerID TEXT,
    Country TEXT
);

LOAD DATA LOCAL INFILE 'C:/Users/centa/OneDrive/Desktop/sql project/Online Retail.csv'
INTO TABLE raw_online_retail
CHARACTER SET latin1
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Sanity check: ensure data loaded
SELECT COUNT(*) FROM raw_online_retail;
