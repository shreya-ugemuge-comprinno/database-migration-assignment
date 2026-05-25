-- ========================= REFERENTIAL INTEGRITY ========================== --

-- ============================= MY SQL ===============================--

DROP PROCEDURE IF EXISTS VerifyReferentialIntegrity;

DELIMITER $$

CREATE PROCEDURE VerifyReferentialIntegrity(IN db_name VARCHAR(255))
BEGIN
    DROP TABLE IF EXISTS tmp_orphan_counts;
    CREATE TEMPORARY TABLE tmp_orphan_counts (
        constraint_name VARCHAR(255),
        child_table VARCHAR(255),
        child_columns TEXT,
        parent_table VARCHAR(255),
        parent_columns TEXT,
        orphan_count BIGINT
    );

    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE c_name VARCHAR(255);
        DECLARE ch_table VARCHAR(255);
        DECLARE pr_table VARCHAR(255);
        DECLARE join_expr TEXT;
        DECLARE null_check_expr TEXT;
        
        -- Safely combines composite foreign keys into a single dynamic execution pass
        DECLARE cur CURSOR FOR 
            SELECT 
                CONSTRAINT_NAME, 
                TABLE_NAME, 
                REFERENCED_TABLE_NAME,
                GROUP_CONCAT(CONCAT('c.`', COLUMN_NAME, '` = p.`', REFERENCED_COLUMN_NAME, '`') SEPARATOR ' AND ') AS join_conditions,
                GROUP_CONCAT(CONCAT('p.`', REFERENCED_COLUMN_NAME, '` IS NULL') SEPARATOR ' AND ') AS null_checks
            FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
            WHERE TABLE_SCHEMA = db_name 
              AND REFERENCED_TABLE_NAME IS NOT NULL
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
            GROUP BY CONSTRAINT_NAME, TABLE_NAME, REFERENCED_TABLE_NAME;
              
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        OPEN cur;

        read_loop: LOOP
            FETCH cur INTO c_name, ch_table, pr_table, join_expr, null_check_expr;
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- Dynamically queries orphans across child and parent table layouts
            SET @sql = CONCAT(
                'INSERT INTO tmp_orphan_counts ',
                'SELECT \'', c_name, '\', \'', ch_table, '\', \'', join_expr, '\', \'', pr_table, '\', \'', null_check_expr, '\', COUNT(*) ',
                'FROM `', db_name, '`.`', ch_table, '` c ',
                'LEFT JOIN `', db_name, '`.`', pr_table, '` p ON ', join_expr, ' ',
                'WHERE ', null_check_expr
            );
            
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END LOOP;

        CLOSE cur;
    END;

    -- Adjusted condition to >= 0 so you see confirmation logs for successfully passed tables
    SELECT constraint_name AS ConstraintName, 
           child_table AS ChildTable, 
           parent_table AS ParentTable, 
           orphan_count AS OrphanCount 
    FROM tmp_orphan_counts 
    WHERE orphan_count >= 0
    ORDER BY child_table;
    
    DROP TABLE IF EXISTS tmp_orphan_counts;
END$$

DELIMITER ;

CALL VerifyReferentialIntegrity('adventureworks2025');



-- ============================ POSTGRES SQL =============================== --



DO $$ 
DECLARE 
    r RECORD;
    sql_query TEXT;
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS tmp_orphan_counts (
        constraint_name TEXT,
        child_table TEXT,
        parent_table TEXT,
        orphan_count BIGINT
    ) ON COMMIT DROP;

    FOR r IN 
        SELECT 
            tc.constraint_name,
            tc.table_schema || '.' || tc.table_name AS child_table,
            ccu.table_schema || '.' || ccu.table_name AS parent_table,
            -- Formats composite structural joins correctly for Postgres execution
            string_agg('c."' || kcu.column_name || '" = p."' || ccu.column_name || '"', ' AND ') AS join_expr,
            string_agg('p."' || ccu.column_name || '" IS NULL', ' AND ') AS null_expr
        FROM information_schema.table_constraints tc
        JOIN information_schema.key_column_usage kcu 
          ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
        JOIN information_schema.constraint_column_usage ccu 
          ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema
        WHERE tc.constraint_type = 'FOREIGN KEY'
          AND replace(lower(tc.table_schema || '_' || tc.table_name), 'public_', '') IN (
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
        GROUP BY tc.constraint_name, tc.table_schema, tc.table_name, ccu.table_schema, ccu.table_name
    LOOP
        sql_query := 'INSERT INTO tmp_orphan_counts ' ||
                     'SELECT ' || quote_literal(r.constraint_name) || ', ' || quote_literal(r.child_table) || ', ' || quote_literal(r.parent_table) || ', COUNT(*) ' ||
                     'FROM ' || r.child_table || ' c LEFT JOIN ' || r.parent_table || ' p ON ' || r.join_expr || ' ' ||
                     'WHERE ' || r.null_expr || ';';
        EXECUTE sql_query;
    END LOOP;
END $$;

SELECT constraint_name AS ConstraintName, child_table AS ChildTable, parent_table AS ParentTable, orphan_count AS OrphanCount 
FROM tmp_orphan_counts 
WHERE orphan_count >= 0
ORDER BY child_table;

DROP PROCEDURE IF EXISTS verifyreferentialintegrity(varchar);


-- ============================= MS SERVER  ============================= --

CREATE OR ALTER PROCEDURE VerifyReferentialIntegrity
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('tempdb..#tmp_orphan_counts') IS NOT NULL
        DROP TABLE #tmp_orphan_counts;

    CREATE TABLE #tmp_orphan_counts (
        constraint_name VARCHAR(255),
        child_table VARCHAR(255),
        parent_table VARCHAR(255),
        orphan_count BIGINT
    );

    DECLARE @fk_name VARCHAR(255), @child_tbl VARCHAR(255), @parent_tbl VARCHAR(255);
    DECLARE @join_expr NVARCHAR(MAX), @null_expr NVARCHAR(MAX), @sql NVARCHAR(MAX);

    DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
        SELECT 
            fk.name AS constraint_name,
            '[' + OBJECT_SCHEMA_NAME(fk.parent_object_id) + '].[' + OBJECT_NAME(fk.parent_object_id) + ']' AS child_table,
            '[' + OBJECT_SCHEMA_NAME(fk.referenced_object_id) + '].[' + OBJECT_NAME(fk.referenced_object_id) + ']' AS parent_table,
            STRING_AGG('c.[' + cp.name + '] = p.[' + rc.name + ']', ' AND ') AS join_expr,
            STRING_AGG('p.[' + rc.name + '] IS NULL', ' AND ') AS null_expr
        FROM sys.foreign_keys fk
        INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
        INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
        INNER JOIN sys.columns rc ON fkc.referenced_object_id = rc.object_id AND fkc.referenced_column_id = rc.column_id
        WHERE CONCAT(OBJECT_SCHEMA_NAME(fk.parent_object_id), '_', OBJECT_NAME(fk.parent_object_id)) IN (
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
        )
        GROUP BY fk.name, fk.parent_object_id, fk.referenced_object_id;

    OPEN cur;
    FETCH NEXT FROM cur INTO @fk_name, @child_tbl, @parent_tbl, @join_expr, @null_expr;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = 'INSERT INTO #tmp_orphan_counts ' +
                   'SELECT ''' + @fk_name + ''', ''' + @child_tbl + ''', ''' + @parent_tbl + ''', COUNT(*) ' +
                   'FROM ' + @child_tbl + ' c LEFT JOIN ' + @parent_tbl + ' p ON ' + @join_expr + ' ' +
                   'WHERE ' + @null_expr;
        EXEC sp_executesql @sql;
        FETCH NEXT FROM cur INTO @fk_name, @child_tbl, @parent_tbl, @join_expr, @null_expr;
    END;

    CLOSE cur;
    DEALLOCATE cur;

    SELECT constraint_name AS ConstraintName, child_table AS ChildTable, parent_table AS ParentTable, orphan_count AS OrphanCount 
    FROM #tmp_orphan_counts 
    WHERE orphan_count >= 0
    ORDER BY child_table;

    DROP TABLE #tmp_orphan_counts;
END;
GO

EXEC VerifyReferentialIntegrity;

DROP PROCEDURE IF EXISTS VerifyReferentialIntegrity;