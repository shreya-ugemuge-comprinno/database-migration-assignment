-- ================== SUM AGGREGATION ============================

-- ==================== MY SQL ===============================


DELIMITER $$

CREATE PROCEDURE GetCompleteVerificationMatrix(IN db_name VARCHAR(255))
BEGIN
    DROP TABLE IF EXISTS tmp_verification_matrix;
    CREATE TEMPORARY TABLE tmp_verification_matrix (
        TableName VARCHAR(255),
        ColumnName VARCHAR(255),
        ColumnSum DECIMAL(38, 4)
    );

    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE t_name VARCHAR(255);
        DECLARE c_name VARCHAR(255);
        
        DECLARE cur CURSOR FOR 
            SELECT TABLE_NAME, COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = db_name 
              AND DATA_TYPE IN ('int', 'bigint', 'smallint', 'tinyint', 'mediumint', 'decimal', 'numeric', 'float', 'double', 'real')
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
                'INSERT INTO tmp_verification_matrix ',
                'SELECT \'', t_name, '\', \'', c_name, '\', ',
                'COALESCE(SUM(CAST(`', c_name, '` AS DECIMAL(38,4))), 0) ',
                'FROM `', db_name, '`.`', t_name, '`'
            );
            
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END LOOP;

        CLOSE cur;
    END;

    SELECT TableName, ColumnName, ColumnSum 
    FROM tmp_verification_matrix 
    ORDER BY TableName, ColumnName;
    
    DROP TABLE IF EXISTS tmp_verification_matrix;
END$$

DELIMITER ;


CALL GetCompleteVerificationMatrix('adventureworks2025');

DROP PROCEDURE IF EXISTS GetCompleteVerificationMatrix;



-- ================================ POSTGRES SQL ==========================================





DO $$
DECLARE
    r RECORD;
    v_sql TEXT;
BEGIN
    -- 1. Create temporary table explicitly
    CREATE TEMP TABLE IF NOT EXISTS pg_verification_matrix (
        table_name TEXT,
        column_name TEXT,
        column_sum NUMERIC(38,4)
    );

    -- Clear any old data if the table already existed in your current session
    TRUNCATE TABLE pg_verification_matrix;

    FOR r IN 
        SELECT c.table_schema, c.table_name, c.column_name -- FIXED: Added c. prefix here
        FROM information_schema.columns c
        JOIN information_schema.tables t ON c.table_name = t.table_name AND c.table_schema = t.table_schema
        WHERE t.table_type = 'BASE TABLE'
          AND c.data_type IN ('integer', 'bigint', 'smallint', 'numeric', 'real', 'double precision', 'money')
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
        v_sql := format('INSERT INTO pg_verification_matrix SELECT %L, %L, COALESCE(SUM(CAST(%I AS NUMERIC(38,4))), 0) FROM %I.%I', 
                        r.table_name, r.column_name, r.column_name, r.table_schema, r.table_name);
        EXECUTE v_sql;
    END LOOP;
END $$;

-- 2. Display results ordered identically to MS SQL
SELECT table_name AS TableName, column_name AS ColumnName, column_sum AS ColumnSum 
FROM pg_verification_matrix 
ORDER BY table_name, column_name;

-- 3. Clean up and drop the table immediately after reading the results
DROP TABLE IF EXISTS pg_verification_matrix;




-- ================================== MS SQL ===========================================




CREATE OR ALTER PROCEDURE GetCompleteVerificationMatrix
    @db_name SYSNAME
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#tmp_verification_matrix') IS NOT NULL
        DROP TABLE #tmp_verification_matrix;

    CREATE TABLE #tmp_verification_matrix (
        TableName SYSNAME,
        ColumnName SYSNAME,
        ColumnSum DECIMAL(38, 4)
    );

    DECLARE @t_name SYSNAME;
    DECLARE @c_name SYSNAME;
    DECLARE @sql NVARCHAR(MAX);

    DECLARE cur CURSOR FOR
        SELECT TABLE_NAME, COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_CATALOG = @db_name
          AND DATA_TYPE IN ('int','bigint','smallint','tinyint','decimal','numeric','float','real')
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
            INSERT INTO #tmp_verification_matrix (TableName, ColumnName, ColumnSum)
            SELECT 
                ''' + @t_name + ''',
                ''' + @c_name + ''',
                COALESCE(SUM(CAST(' + QUOTENAME(@c_name) + ' AS DECIMAL(38,4))), 0)
            FROM ' + QUOTENAME(@db_name) + '.dbo.' + QUOTENAME(@t_name) + ';';

        EXEC sp_executesql @sql;

        FETCH NEXT FROM cur INTO @t_name, @c_name;
    END;

    CLOSE cur;
    DEALLOCATE cur;

    SELECT *
    FROM #tmp_verification_matrix
    ORDER BY TableName, ColumnName;

    
END;
GO


EXEC GetCompleteVerificationMatrix 'AdventureWorks2025';

DROP TABLE #tmp_verification_matrix;



