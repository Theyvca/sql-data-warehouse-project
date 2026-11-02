/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

CREATE DATABASE IF NOT EXISTS bronze;

DROP TABLE IF EXISTS bronze.bronze_crm_cust_info;

CREATE TABLE bronze.bronze_crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);


DROP TABLE IF EXISTS bronze.bronze_crm_prd_info;

CREATE TABLE bronze.bronze_crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);


DROP TABLE IF EXISTS bronze.bronze_crm_sales_details;

CREATE TABLE bronze.bronze_crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);


DROP TABLE IF EXISTS bronze.bronze_erp_loc_a101;

CREATE TABLE bronze.bronze_erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);


DROP TABLE IF EXISTS bronze.bronze_erp_cust_az12;

CREATE TABLE bronze.bronze_erp_cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);


DROP TABLE IF EXISTS bronze.bronze_erp_px_g1v2;

CREATE TABLE bronze.bronze_erp_px_g1v2 (
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);




  CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end-time DATETIME;
BEGIN TRY
SET @batch_start_time = NOW(6);
PRINT '===================================================';
PRINT 'LOADING BRONZE LAYER';
PRINT '===================================================';

PRINT '----------------------------------------------------';
PRINT 'LOADING CRM TABLES';
PRINT '----------------------------------------------------';

SET @start_time = NOW(6);
PRINT '>> Truncating table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.bronze_crm_cust_info;

PRINT '>> Inserting data into table: bronze.crm_cust_info';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';

SET @start_time = NOW(6);
PRINT '>> Truncating table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.bronze_crm_prd_info;

PRINT '>> Inserting data into table: bronze.crm_prd_info';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';


SET @start_time = GETDATE();
PRINT '>> Truncating table: bronze.crm_sales_info';
TRUNCATE TABLE bronze.bronze_crm_sales_details;

PRINT '>> Inserting data into table: bronze.crm_sales_info';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';


PRINT '----------------------------------------------------';
PRINT 'LOADING ERP TABLES';
PRINT '----------------------------------------------------';

SET @start_time = GETDATE();
PRINT '>> Truncating table: bronze.erp_loc_a101';
TRUNCATE TABLE bronze.bronze_erp_loc_a101;

PRINT '>> Inserting data into table: bronze.erp_loc_a101';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';


SET @start_time = GETDATE();
PRINT '>> Truncating table: bronze.erp_cust_az12';
TRUNCATE TABLE bronze.bronze_erp_cust_az12;

PRINT '>> Inserting data into table: bronze.erp_cust_az12';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';


SET @start_time = GETDATE();
PRINT '>> Truncating table: bronze.erp_px_g1v2';
TRUNCATE TABLE bronze.bronze_erp_px_g1v2;

PRINT '>> Inserting data into table: bronze.erp_px_g1v2';
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

PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------------------------';

SET @batch_end_time = NOW(6);
PRINT '========================================================';
PRINT 'Loading Bronze layer is completed';

SELECT CONCAT(
    'Total Bronze Layer Load Duration: ',
    TIMESTAMPDIFF(
        MICROSECOND,
        @bronze_start_time,
        @bronze_end_time
    ) / 1000000,
    ' seconds'
) AS message;

END TRY
BEGIN CATCH
PRINT '===================================================';
PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
PRINT 'Error Message' + ERROR_MESSAGE();
PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT '===================================================';
END CATCH
END

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

SELECT COUNT(*) FROM bronze.bronze_crm_cust_info; = 18494

SELECT COUNT(*) FROM bronze.bronze_crm_prd_info; = 397

SELECT COUNT(*) FROM bronze.bronze_crm_sales_details; = 60398

SELECT COUNT(*) FROM bronze.bronze_erp_loc_a101; = 18494

SELECT COUNT(*) FROM bronze.bronze_erp_cust_az12; = 18494

SELECT COUNT(*) FROM bronze.bronze_erp_px_g1v2; =37

calling stored procedure in MySQL 
CALL bronze.load_bronze();

