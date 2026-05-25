-- ======================= NULL VALIDATION ===============================



-- ====================== POSTGRES SQL =================================


DO $$
DECLARE
    r RECORD;
    v_sql TEXT;
BEGIN
    -- 1. Create temporary table explicitly
    CREATE TEMP TABLE IF NOT EXISTS pg_null_matrix (
        table_name TEXT,
        column_name TEXT,
        null_count BIGINT
    );
    TRUNCATE TABLE pg_null_matrix;

    FOR r IN 
        SELECT c.table_schema, c.table_name, c.column_name
        FROM information_schema.columns c
        JOIN information_schema.tables t ON c.table_name = t.table_name AND c.table_schema = t.table_schema
        WHERE t.table_type = 'BASE TABLE'
          AND c.is_nullable = 'YES'
          AND (c.table_schema || '_' || c.table_name) IN (
            'sales_salesorderdetail', 'production_transactionhistory', 'production_transactionhistoryarchive', 
            'production_workorder', 'production_workorderrouting', 'sales_salesorderheader', 
            'sales_salesorderheadersalesreason', 'person_personphone', 'person_emailaddress', 
            'person_password', 'sales_customer', 'person_person', 'person_businessentityaddress', 
            'person_businessentity', 'person_address', 'sales_personcreditcard', 'sales_creditcard', 
            'sales_currencyrate', 'purchasing_purchaseorderdetail', 'purchasing_purchaseorderheader', 
            'production_billofmaterials', 'production_productinventory', 'person_businessentitycontact', 
            'production_productdescription', 'production_productmodelproductdescriptionculture', 
            'sales_store', 'sales_specialofferproduct', 'production_product', 'production_productproductphoto', 
            'purchasing_productvendor', 'production_productcosthistory', 'production_productlistpricehistory', 
            'humanresources_employeepayhistory', 'humanresources_employeedepartmenthistory', 
            'humanresources_employee', 'person_countryregion', 'person_stateprovince', 
            'sales_salespersonquotahistory', 'production_productmodel', 'sales_countryregioncurrency', 
            'sales_currency', 'purchasing_vendor', 'production_productphoto', 'production_unitmeasure', 
            'production_productsubcategory', 'production_productdocument', 'sales_salestaxrate', 
            'person_contacttype', 'sales_salesperson', 'sales_salesterritoryhistory', 'production_scrapreason', 
            'humanresources_department', 'sales_specialoffer', 'production_location', 'humanresources_jobcandidate', 
            'production_document', 'sales_salesreason', 'sales_salesterritory', 'production_culture', 
            'production_productmodelillustration', 'person_addresstype', 'production_illustration', 
            'purchasing_shipmethod', 'production_productreview', 'production_productcategory', 
            'humanresources_shift', 'sales_shoppingcartitem', 'person_phonenumbertype', 'awbuildversion', 
            'errorlog', 'databaselog'
          )
    LOOP
        -- FIXED: Ensured format placeholders safely build schema.table and filter by column correctly
        v_sql := format('INSERT INTO pg_null_matrix SELECT %L, %L, COUNT(*) FROM %I.%I WHERE %I IS NULL', 
                        r.table_name, r.column_name, r.table_schema, r.table_name, r.column_name);
        EXECUTE v_sql;
    END LOOP;
END $$;

SELECT table_name AS TableName, column_name AS ColumnName, null_count AS NullCount 
FROM pg_null_matrix 
WHERE null_count > 0
ORDER BY table_name, column_name;

DROP TABLE IF EXISTS pg_null_matrix;



-- ================================ MY SQL ==================================================


DROP PROCEDURE IF EXISTS GetExactNullCounts;

DELIMITER $$

CREATE PROCEDURE GetExactNullCounts(IN db_name VARCHAR(255))
BEGIN
    DROP TABLE IF EXISTS tmp_null_counts;
    CREATE TEMPORARY TABLE tmp_null_counts (
        table_name VARCHAR(255),
        column_name VARCHAR(255),
        null_count BIGINT
    );

    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE t_name VARCHAR(255);
        DECLARE c_name VARCHAR(255);
        
        DECLARE cur CURSOR FOR 
            SELECT TABLE_NAME, COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = db_name 
              AND IS_NULLABLE = 'YES'
              AND TABLE_NAME IN (
                'sales_salesorderdetail', 'production_transactionhistory', 'production_transactionhistoryarchive', 
                'production_workorder', 'production_workorderrouting', 'sales_salesorderheader', 
                'sales_salesorderheadersalesreason', 'person_personphone', 'person_emailaddress', 
                'person_password', 'sales_customer', 'person_person', 'person_businessentityaddress', 
                'person_businessentity', 'person_address', 'sales_personcreditcard', 'sales_creditcard', 
                'sales_currencyrate', 'purchasing_purchaseorderdetail', 'purchasing_purchaseorderheader', 
                'production_billofmaterials', 'production_productinventory', 'person_businessentitycontact', 
                'production_productdescription', 'production_productmodelproductdescriptionculture', 
                'sales_store', 'sales_specialofferproduct', 'production_product', 'production_productproductphoto', 
                'purchasing_productvendor', 'production_productcosthistory', 'production_productlistpricehistory', 
                'humanresources_employeepayhistory', 'humanresources_employeedepartmenthistory', 
                'humanresources_employee', 'person_countryregion', 'person_stateprovince', 
                'sales_salespersonquotahistory', 'production_productmodel', 'sales_countryregioncurrency', 
                'sales_currency', 'purchasing_vendor', 'production_productphoto', 'production_unitmeasure', 
                'production_productsubcategory', 'production_productdocument', 'sales_salestaxrate', 
                'person_contacttype', 'sales_salesperson', 'sales_salesterritoryhistory', 'production_scrapreason', 
                'humanresources_department', 'sales_specialoffer', 'production_location', 'humanresources_jobcandidate', 
                'production_document', 'sales_salesreason', 'sales_salesterritory', 'production_culture', 
                'production_productmodelillustration', 'person_addresstype', 'production_illustration', 
                'purchasing_shipmethod', 'production_productreview', 'production_productcategory', 
                'humanresources_shift', 'sales_shoppingcartitem', 'person_phonenumbertype', 'awbuildversion', 
                'errorlog', 'databaselog'
              );
              
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO t_name, c_name;
            IF done THEN
                LEAVE read_loop;
            END IF;

            SET @sql = CONCAT(
                'INSERT INTO tmp_null_counts ',
                'SELECT \'', t_name, '\', \'', c_name, '\', COUNT(*) ',
                'FROM `', db_name, '`.`', t_name, '` WHERE `', c_name, '` IS NULL'
            );
            
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END LOOP;

        CLOSE cur;
    END;

    SELECT table_name AS TableName, column_name AS ColumnName, null_count AS NullCount 
    FROM tmp_null_counts 
    WHERE null_count > 0
    ORDER BY table_name, column_name;
    
    DROP TABLE IF EXISTS tmp_null_counts;
END$$

DELIMITER ;

-- Execute call string:
CALL GetExactNullCounts('adventureworks2025');




-- ============================= MS SQL SERVER =========================================

CREATE OR ALTER PROCEDURE GetExactNullCounts
    @db_name SYSNAME
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#tmp_null_counts') IS NOT NULL
        DROP TABLE #tmp_null_counts;

    CREATE TABLE #tmp_null_counts (
        TableName SYSNAME,
        ColumnName SYSNAME,
        NullCount BIGINT
    );

    DECLARE @t_name SYSNAME;
    DECLARE @c_name SYSNAME;
    DECLARE @sql NVARCHAR(MAX);

    DECLARE cur CURSOR FOR
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_CATALOG = @db_name
          AND IS_NULLABLE = 'YES'
          AND TABLE_NAME IN (
                'sales_salesorderdetail', 'production_transactionhistory', 'production_transactionhistoryarchive',
                'production_workorder', 'production_workorderrouting', 'sales_salesorderheader',
                'sales_salesorderheadersalesreason', 'person_personphone', 'person_emailaddress',
                'person_password', 'sales_customer', 'person_person', 'person_businessentityaddress',
                'person_businessentity', 'person_address', 'sales_personcreditcard', 'sales_creditcard',
                'sales_currencyrate', 'purchasing_purchaseorderdetail', 'purchasing_purchaseorderheader',
                'production_billofmaterials', 'production_productinventory', 'person_businessentitycontact',
                'production_productdescription', 'production_productmodelproductdescriptionculture',
                'sales_store', 'sales_specialofferproduct', 'production_product', 'production_productproductphoto',
                'purchasing_productvendor', 'production_productcosthistory', 'production_productlistpricehistory',
                'humanresources_employeepayhistory', 'humanresources_employeedepartmenthistory',
                'humanresources_employee', 'person_countryregion', 'person_stateprovince',
                'sales_salespersonquotahistory', 'production_productmodel', 'sales_countryregioncurrency',
                'sales_currency', 'purchasing_vendor', 'production_productphoto', 'production_unitmeasure',
                'production_productsubcategory', 'production_productdocument', 'sales_salestaxrate',
                'person_contacttype', 'sales_salesperson', 'sales_salesterritoryhistory',
                'production_scrapreason', 'humanresources_department', 'sales_specialoffer',
                'production_location', 'humanresources_jobcandidate', 'production_document',
                'sales_salesreason', 'sales_salesterritory', 'production_culture',
                'production_productmodelillustration', 'person_addresstype', 'production_illustration',
                'purchasing_shipmethod', 'production_productreview', 'production_productcategory',
                'humanresources_shift', 'sales_shoppingcartitem', 'person_phonenumbertype',
                'awbuildversion', 'errorlog', 'databaselog'
          );

    OPEN cur;

    FETCH NEXT FROM cur INTO @t_name, @c_name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = N'
            INSERT INTO #tmp_null_counts (TableName, ColumnName, NullCount)
            SELECT 
                @tbl,
                @col,
                COUNT(*)
            FROM ' + QUOTENAME(@db_name) + '.dbo.' + QUOTENAME(@t_name) + '
            WHERE ' + QUOTENAME(@c_name) + ' IS NULL;';

        EXEC sp_executesql 
            @sql,
            N'@tbl sysname, @col sysname',
            @tbl = @t_name,
            @col = @c_name;

        FETCH NEXT FROM cur INTO @t_name, @c_name;
    END;

    CLOSE cur;
    DEALLOCATE cur;

    SELECT *
    FROM #tmp_null_counts
    WHERE NullCount > 0
    ORDER BY TableName, ColumnName;

    DROP TABLE #tmp_null_counts;
END;
GO


EXEC GetExactNullCounts 'AdventureWorks2025';


