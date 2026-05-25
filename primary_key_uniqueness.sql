-- ====================== PRIMERY KEY UNIQUENESS ==================================

-- ======================= MY SQL ====================================


DROP PROCEDURE IF EXISTS VerifyPrimaryKeyUniqueness;

DELIMITER $$

CREATE PROCEDURE VerifyPrimaryKeyUniqueness(IN db_name VARCHAR(255))
BEGIN
    DROP TABLE IF EXISTS tmp_pk_counts;
    CREATE TEMPORARY TABLE tmp_pk_counts (
        table_name VARCHAR(255),
        total_rows BIGINT,
        distinct_pk_rows BIGINT,
        duplicate_count BIGINT
    );

    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE t_name VARCHAR(255);
        DECLARE pk_expr TEXT;
        
        DECLARE cur CURSOR FOR 
            SELECT 
                TABLE_NAME,
                GROUP_CONCAT(CONCAT('COALESCE(`', COLUMN_NAME, '`, '''')') SEPARATOR ', ') AS pk_columns
            FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
            WHERE TABLE_SCHEMA = db_name 
              AND CONSTRAINT_NAME = 'PRIMARY'
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
              )
            GROUP BY TABLE_NAME;
              
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO t_name, pk_expr;
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- Note: MySQL COUNT(DISTINCT col1, col2) natively supports multiple column combinations
            SET @sql = CONCAT(
                'INSERT INTO tmp_pk_counts ',
                'SELECT \'', t_name, '\', COUNT(*), COUNT(DISTINCT ', pk_expr, '), ',
                'COUNT(*) - COUNT(DISTINCT ', pk_expr, ') ',
                'FROM `', db_name, '`.`', t_name, '`'
            );
            
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END LOOP;

        CLOSE cur;
    END;

    SELECT table_name AS TableName, total_rows AS TotalRows, distinct_pk_rows AS DistinctPkRows, duplicate_count AS DuplicateCount 
    FROM tmp_pk_counts 
    ORDER BY table_name;
    
    DROP TABLE IF EXISTS tmp_pk_counts;
END$$

DELIMITER ;

CALL VerifyPrimaryKeyUniqueness('adventureworks2025');


-- ========================== POSTGRESSQL =====================================


CREATE OR REPLACE FUNCTION verify_primary_key_uniqueness(p_schema text)
RETURNS TABLE (
    tablename text,
    total_rows bigint,
    distinct_pk_rows bigint,
    duplicate_count bigint
)
LANGUAGE plpgsql
AS $$
DECLARE
    r RECORD;
    pk_cols text;
    sql text;
BEGIN
    FOR r IN
        SELECT
            tc.table_name,
            string_agg(
                format('COALESCE(%I::text, '''')', kcu.column_name),
                ' || ''|'' || '
                ORDER BY kcu.ordinal_position
            ) AS pk_expr
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu
          ON tc.constraint_name = kcu.constraint_name
         AND tc.table_schema = kcu.table_schema
        WHERE tc.constraint_type = 'PRIMARY KEY'
          AND tc.table_schema = p_schema
        GROUP BY tc.table_name
    LOOP

        sql := format(
            'SELECT %L,
                    COUNT(*) AS total_rows,
                    COUNT(DISTINCT %s) AS distinct_pk_rows,
                    COUNT(*) - COUNT(DISTINCT %s) AS duplicate_count
             FROM %I.%I',
            r.table_name,
            r.pk_expr,
            r.pk_expr,
            p_schema,
            r.table_name
        );

        RETURN QUERY EXECUTE sql;
    END LOOP;
END;
$$;


SELECT * FROM verify_primary_key_uniqueness('sales');

-- ======================== MS SERVER ==================================


CREATE OR ALTER PROCEDURE VerifyPrimaryKeyUniqueness
    @db_name SYSNAME
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#tmp_pk_counts') IS NOT NULL
        DROP TABLE #tmp_pk_counts;

    CREATE TABLE #tmp_pk_counts (
        TableName SYSNAME,
        TotalRows BIGINT,
        DistinctPkRows BIGINT,
        DuplicateCount BIGINT
    );

    DECLARE @t_name SYSNAME;
    DECLARE @pk_expr NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);

    DECLARE cur CURSOR FOR
        SELECT
            tc.TABLE_NAME,
            STRING_AGG(
                'COALESCE(CAST(' + QUOTENAME(kcu.COLUMN_NAME) + ' AS NVARCHAR(4000)), '''')',
                ' + ''|'' + '
            ) WITHIN GROUP (ORDER BY kcu.ORDINAL_POSITION) AS pk_expr
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
        JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
          ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
         AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
        WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
          AND tc.TABLE_CATALOG = @db_name
        GROUP BY tc.TABLE_NAME;

    OPEN cur;

    FETCH NEXT FROM cur INTO @t_name, @pk_expr;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = N'
            INSERT INTO #tmp_pk_counts (TableName, TotalRows, DistinctPkRows, DuplicateCount)
            SELECT
                @tbl,
                COUNT(*),
                COUNT(DISTINCT ' + @pk_expr + '),
                COUNT(*) - COUNT(DISTINCT ' + @pk_expr + ')
            FROM ' + QUOTENAME(@db_name) + '.dbo.' + QUOTENAME(@t_name) + ';';

        EXEC sp_executesql
            @sql,
            N'@tbl sysname',
            @tbl = @t_name;

        FETCH NEXT FROM cur INTO @t_name, @pk_expr;
    END;

    CLOSE cur;
    DEALLOCATE cur;

    SELECT *
    FROM #tmp_pk_counts
    ORDER BY TableName;

    DROP TABLE #tmp_pk_counts;
END;
GO



EXEC VerifyPrimaryKeyUniqueness 'AdventureWorks2025';

