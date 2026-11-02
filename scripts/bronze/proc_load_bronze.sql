/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


SELECT '========== LOADING BRONZE LAYER ==========' AS message;

SELECT '---------- LOADING CRM TABLES ----------' AS message;

SET @bronze_start_time = NOW(6);
-- 1. CRM Customer Info
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_crm_cust_info;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.bronze_crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_crm_cust_info loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;


-- 2. CRM Product Info
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_crm_prd_info;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.bronze_crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_crm_prd_info loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;


-- 3. CRM Sales Details
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_crm_sales_details;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.bronze_crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_crm_sales_details loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;


SELECT '---------- LOADING ERP TABLES ----------' AS message;

-- 4. ERP Location
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_erp_loc_a101;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv'
INTO TABLE bronze.bronze_erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_erp_loc_a101 loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;


-- 5. ERP Customer
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_erp_cust_az12;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv'
INTO TABLE bronze.bronze_erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_erp_cust_az12 loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;


-- 6. ERP Product Categories
SET @start_time = NOW(6);

TRUNCATE TABLE bronze.bronze_erp_px_g1v2;

LOAD DATA LOCAL INFILE 'C:/Users/dell/Downloads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv'
INTO TABLE bronze.bronze_erp_px_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET @end_time = NOW(6);

SELECT CONCAT(
    'bronze_erp_px_g1v2 loaded. Duration: ',
    TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000,
    ' seconds'
) AS message;

SET @bronze_end_time = NOW(6);

SELECT CONCAT(
    'Total Bronze Layer Load Duration: ',
    TIMESTAMPDIFF(
        MICROSECOND,
        @bronze_start_time,
        @bronze_end_time
    ) / 1000000,
    ' seconds'
) AS message;


-- Verify row counts
SELECT 'bronze_crm_cust_info' AS table_name, COUNT(*) AS row_count
FROM bronze.bronze_crm_cust_info
UNION ALL
SELECT 'bronze_crm_prd_info', COUNT(*)
FROM bronze.bronze_crm_prd_info
UNION ALL
SELECT 'bronze_crm_sales_details', COUNT(*)
FROM bronze.bronze_crm_sales_details
UNION ALL
SELECT 'bronze_erp_loc_a101', COUNT(*)
FROM bronze.bronze_erp_loc_a101
UNION ALL
SELECT 'bronze_erp_cust_az12', COUNT(*)
FROM bronze.bronze_erp_cust_az12
UNION ALL
SELECT 'bronze_erp_px_g1v2', COUNT(*)
FROM bronze.bronze_erp_px_g1v2;
