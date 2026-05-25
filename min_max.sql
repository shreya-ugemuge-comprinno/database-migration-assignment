-- =========================== MAX/MIN VALUE ============================= --

-- ================================= MY SQL ============================== --

DROP PROCEDURE IF EXISTS VerifyDataExtremes;

DELIMITER $$

CREATE PROCEDURE VerifyDataExtremes(IN db_name VARCHAR(255))
BEGIN
    -- 1. Create a temporary table to store the results
    DROP TABLE IF EXISTS tmp_data_extremes;
    CREATE TEMPORARY TABLE tmp_data_extremes (
        TableName VARCHAR(255),
        ColumnName VARCHAR(255),
        DataType VARCHAR(50),
        MinValueText VARCHAR(100),
        MaxValueText VARCHAR(100)
    );

    -- 2. Define cursor to loop through numeric and date columns
    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE t_name VARCHAR(255);
        DECLARE c_name VARCHAR(255);
        DECLARE d_type VARCHAR(50);
        
        DECLARE cur CURSOR FOR 
            SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = db_name 
              AND DATA_TYPE IN ('int', 'bigint', 'smallint', 'tinyint', 'mediumint', 'decimal', 'numeric', 'float', 'double', 'real', 'date', 'datetime', 'timestamp')
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
            FETCH cur INTO t_name, c_name, d_type;
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- 3. Dynamic query to fetch boundaries safely handling NULLs
            SET @sql = CONCAT(
                'INSERT INTO tmp_data_extremes ',
                'SELECT \'', t_name, '\', \'', c_name, '\', \'', d_type, '\', ',
                'COALESCE(CAST(MIN(`', c_name, '`) AS CHAR), \'NULL\'), ',
                'COALESCE(CAST(MAX(`', c_name, '`) AS CHAR), \'NULL\') ',
                'FROM `', db_name, '`.`', t_name, '`'
            );
            
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END LOOP;

        CLOSE cur;
    END;

    -- 4. Display sorted results matching previous ledgers
    SELECT TableName, ColumnName, DataType, MinValueText, MaxValueText 
    FROM tmp_data_extremes 
    ORDER BY TableName, ColumnName;
    
    DROP TABLE IF EXISTS tmp_data_extremes;
END$$

DELIMITER ;

CALL VerifyDataExtremes('adventureworks2025');



SELECT 
    tc.TABLE_SCHEMA,
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
    AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
    AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.CONSTRAINT_TYPE = 'UNIQUE'
AND tc.TABLE_SCHEMA = 'adventureworks2025'
ORDER BY tc.TABLE_NAME;


-- =========================== POSTGRES SQL ================================ --


DO $$ 
DECLARE 
    r RECORD;
    sql_query TEXT;
BEGIN
    -- 1. Create a temporary table to store the boundary evaluations
    CREATE TEMP TABLE IF NOT EXISTS tmp_data_extremes (
        TableName TEXT,
        ColumnName TEXT,
        DataType TEXT,
        MinValueText TEXT,
        MaxValueText TEXT
    ) ON COMMIT DROP;

    -- 2. Loop through tracking columns that map to the flattened name array
    FOR r IN 
        SELECT 
            c.table_schema,
            c.table_name,
            c.column_name,
            c.data_type
        FROM information_schema.columns c
        WHERE c.data_type IN ('integer', 'bigint', 'smallint', 'numeric', 'double precision', 'real', 'date', 'timestamp without time zone', 'timestamp with time zone')
          AND replace(lower(c.table_schema || '_' || c.table_name), 'public_', '') IN (
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
        -- 3. Construct and execute dynamic text extraction 
        sql_query := 'INSERT INTO tmp_data_extremes ' ||
                     'SELECT ' || quote_literal(r.table_schema || '.' || r.table_name) || ', ' || 
                                  quote_literal(r.column_name) || ', ' || 
                                  quote_literal(r.data_type) || ', ' ||
                     'COALESCE(MIN("' || r.column_name || '")::text, ''NULL''), ' ||
                     'COALESCE(MAX("' || r.column_name || '")::text, ''NULL'') ' ||
                     'FROM "' || r.table_schema || '"."' || r.table_name || '";';
                     
        EXECUTE sql_query;
    END LOOP;
END $$;

-- 4. Display sorted metrics
SELECT TableName, ColumnName, DataType, MinValueText, MaxValueText 
FROM tmp_data_extremes 
ORDER BY TableName, ColumnName;


DROP PROCEDURE IF EXISTS verifydataextremes(varchar);


-- ================================== MS SERVER =================================


CREATE OR ALTER PROCEDURE VerifyDataExtremes
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Create a temporary table to log metadata thresholds
    IF OBJECT_ID('tempdb..#tmp_data_extremes') IS NOT NULL
        DROP TABLE #tmp_data_extremes;

    CREATE TABLE #tmp_data_extremes (
        TableName VARCHAR(255),
        ColumnName VARCHAR(255),
        DataType VARCHAR(50),
        MinValueText VARCHAR(100),
        MaxValueText VARCHAR(100)
    );

    DECLARE @schema_name VARCHAR(128);
    DECLARE @table_name VARCHAR(128);
    DECLARE @column_name VARCHAR(128);
    DECLARE @data_type VARCHAR(50);
    DECLARE @sql NVARCHAR(MAX);

    -- 2. Define Cursor focusing on numeric, decimal, and date-oriented categories
    DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
        SELECT 
            s.name AS schema_name,
            t.name AS table_name,
            c.name AS column_name,
            tp.name AS data_type
        FROM sys.columns c
        INNER JOIN sys.tables t ON c.object_id = t.object_id
        INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
        INNER JOIN sys.types tp ON c.user_type_id = tp.user_type_id
        WHERE tp.name IN ('int', 'bigint', 'smallint', 'tinyint', 'decimal', 'numeric', 'float', 'real', 'date', 'datetime', 'datetime2', 'smalldatetime')
          AND CONCAT(s.name, '_', t.name) IN (
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
                'humanresources_shift', 'sales_shoppingcartitem', 'person_phonenumbertype', 
                'dbo_awbuildversion', 'dbo_errorlog', 'dbo_databaselog'
          );

    OPEN cur;
    FETCH NEXT FROM cur INTO @schema_name, @table_name, @column_name, @data_type;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 3. Execute text extraction boundaries dynamically across schemas
        SET @sql = '
            INSERT INTO #tmp_data_extremes
            SELECT ''' + @schema_name + '.' + @table_name + ''', ''' + @column_name + ''', ''' + @data_type + ''', 
                   COALESCE(CAST(MIN([' + @column_name + ']) AS VARCHAR(100)), ''NULL''), 
                   COALESCE(CAST(MAX([' + @column_name + ']) AS VARCHAR(100)), ''NULL'')
            FROM [' + @schema_name + '].[' + @table_name + ']';

        EXEC sp_executesql @sql;

        FETCH NEXT FROM cur INTO @schema_name, @table_name, @column_name, @data_type;
    END;

    CLOSE cur;
    DEALLOCATE cur;

    -- 4. Print clean audit summary
    SELECT TableName, ColumnName, DataType, MinValueText, MaxValueText 
    FROM #tmp_data_extremes 
    ORDER BY TableName, ColumnName;

    DROP TABLE #tmp_data_extremes;
END;
GO

-- To run it in your target database:
EXEC VerifyDataExtremes;

DROP PROCEDURE IF EXISTS VerifyDataExtremes;

