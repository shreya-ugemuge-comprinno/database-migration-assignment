-- ----------------------------------------------------------
-- Index
-- ----------------------------------------------------------




-- -----------------------------------------------------
-- View: humanresources_vemployee
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vemployee`;
CREATE VIEW `humanresources_vemployee` AS 
SELECT 
    `e`.`BusinessEntityID` AS `businessentityid`,
    `p`.`Title` AS `title`,
    `p`.`FirstName` AS `firstname`,
    `p`.`MiddleName` AS `middlename`,
    `p`.`LastName` AS `lastname`,
    `p`.`Suffix` AS `suffix`,
    `e`.`JobTitle` AS `jobtitle`,
    `pp`.`PhoneNumber` AS `phonenumber`,
    `pnt`.`Name` AS `phonenumbertype`,
    `ea`.`EmailAddress` AS `emailaddress`,
    `p`.`EmailPromotion` AS `emailpromotion`,
    `a`.`AddressLine1` AS `addressline1`,
    `a`.`AddressLine2` AS `addressline2`,
    `a`.`City` AS `city`,
    `sp`.`Name` AS `stateprovincename`,
    `a`.`PostalCode` AS `postalcode`,
    `cr`.`Name` AS `countryregionname`,
    `p`.`AdditionalContactInfo` AS `additionalcontactinfo` 
FROM ((((((((`adventureworks2025`.`humanresources_employee` `e` 
JOIN `adventureworks2025`.`person_person` `p` ON((`p`.`BusinessEntityID` = `e`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`person_businessentityaddress` `bea` ON((`bea`.`BusinessEntityID` = `e`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`person_address` `a` ON((`a`.`AddressID` = `bea`.`AddressID`))) 
JOIN `adventureworks2025`.`person_stateprovince` `sp` ON((`sp`.`StateProvinceID` = `a`.`StateProvinceID`))) 
JOIN `adventureworks2025`.`person_countryregion` `cr` ON((`cr`.`CountryRegionCode` = `sp`.`CountryRegionCode`))) 
LEFT JOIN `adventureworks2025`.`person_personphone` `pp` ON((`pp`.`BusinessEntityID` = `p`.`BusinessEntityID`))) 
LEFT JOIN `adventureworks2025`.`person_phonenumbertype` `pnt` ON((`pp`.`PhoneNumberTypeID` = `pnt`.`PhoneNumberTypeID`))) 
LEFT JOIN `adventureworks2025`.`person_emailaddress` `ea` ON((`p`.`BusinessEntityID` = `ea`.`BusinessEntityID`)));

-- -----------------------------------------------------
-- View: humanresources_vemployeedepartment
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vemployeedepartment`;
CREATE VIEW `humanresources_vemployeedepartment` AS 
SELECT 
    `e`.`BusinessEntityID` AS `businessentityid`,
    `p`.`Title` AS `title`,
    `p`.`FirstName` AS `firstname`,
    `p`.`MiddleName` AS `middlename`,
    `p`.`LastName` AS `lastname`,
    `p`.`Suffix` AS `suffix`,
    `e`.`JobTitle` AS `jobtitle`,
    `d`.`Name` AS `department`,
    `d`.`GroupName` AS `groupname`,
    `edh`.`StartDate` AS `startdate` 
FROM (((`adventureworks2025`.`humanresources_employee` `e` 
JOIN `adventureworks2025`.`person_person` `p` ON((`p`.`BusinessEntityID` = `e`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`humanresources_employeedepartmenthistory` `edh` ON((`e`.`BusinessEntityID` = `edh`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`humanresources_department` `d` ON((`edh`.`DepartmentID` = `d`.`DepartmentID`))) 
WHERE (`edh`.`EndDate` IS NULL);

-- -----------------------------------------------------
-- View: humanresources_vemployeedepartmenthistory
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vemployeedepartmenthistory`;
CREATE VIEW `humanresources_vemployeedepartmenthistory` AS 
SELECT 
    `e`.`BusinessEntityID` AS `businessentityid`,
    `p`.`Title` AS `title`,
    `p`.`FirstName` AS `firstname`,
    `p`.`MiddleName` AS `middlename`,
    `p`.`LastName` AS `lastname`,
    `p`.`Suffix` AS `suffix`,
    `s`.`Name` AS `shift`,
    `d`.`Name` AS `department`,
    `d`.`GroupName` AS `groupname`,
    `edh`.`StartDate` AS `startdate`,
    `edh`.`EndDate` AS `enddate` 
FROM ((((`adventureworks2025`.`humanresources_employee` `e` 
JOIN `adventureworks2025`.`person_person` `p` ON((`p`.`BusinessEntityID` = `e`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`humanresources_employeedepartmenthistory` `edh` ON((`e`.`BusinessEntityID` = `edh`.`BusinessEntityID`))) 
JOIN `adventureworks2025`.`humanresources_department` `d` ON((`edh`.`DepartmentID` = `d`.`DepartmentID`))) 
JOIN `adventureworks2025`.`humanresources_shift` `s` ON((`s`.`ShiftID` = `edh`.`ShiftID`)));

-- -----------------------------------------------------
-- View: humanresources_vjobcandidate
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vjobcandidate`;
CREATE VIEW `humanresources_vjobcandidate` AS 
SELECT 
    `jc`.`JobCandidateID` AS `jobcandidateid`,
    `jc`.`BusinessEntityID` AS `businessentityid`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Name/Name.Prefix') AS `name_prefix`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Name/Name.First') AS `name_first`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Name/Name.Middle') AS `name_middle`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Name/Name.Last') AS `name_last`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Name/Name.Suffix') AS `name_suffix`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Skills') AS `skills`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Address/Addr.Type') AS `addr_type`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Address/Addr.Location/Location/Loc.CountryRegion') AS `addr_countryregion`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Address/Addr.Location/Location/Loc.State') AS `addr_state`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Address/Addr.Location/Location/Loc.City') AS `addr_city`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Address/Addr.PostalCode') AS `addr_postalcode`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/EMail') AS `email`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/WebSite') AS `website`,
    `jc`.`ModifiedDate` AS `modifieddate` 
FROM `adventureworks2025`.`humanresources_jobcandidate` `jc`;

-- -----------------------------------------------------
-- View: humanresources_vjobcandidateeducation
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vjobcandidateeducation`;
CREATE VIEW `humanresources_vjobcandidateeducation` AS 
SELECT 
    `jc`.`JobCandidateID` AS `jobcandidateid`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Level') AS `edu_level`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.StartDate') AS `edu_startdate`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.EndDate') AS `edu_enddate`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Degree') AS `edu_degree`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Major') AS `edu_major`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Minor') AS `edu_minor`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.GPA') AS `edu_gpa`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.GPAScale') AS `edu_gpascale`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.School') AS `edu_school`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Location/Location/Loc.CountryRegion') AS `edu_countryregion`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Location/Location/Loc.State') AS `edu_state`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Education/Edu.Location/Location/Loc.City') AS `edu_city` 
FROM `adventureworks2025`.`humanresources_jobcandidate` `jc`;

-- -----------------------------------------------------
-- View: humanresources_vjobcandidateemployment
-- -----------------------------------------------------
DROP VIEW IF EXISTS `humanresources_vjobcandidateemployment`;
CREATE VIEW `humanresources_vjobcandidateemployment` AS 
SELECT 
    `jc`.`JobCandidateID` AS `jobcandidateid`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.StartDate') AS `emp_startdate`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.EndDate') AS `emp_enddate`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.OrgName') AS `emp_orgname`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.JobTitle') AS `emp_jobtitle`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.Responsibility') AS `emp_responsibility`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.FunctionCategory') AS `emp_functioncategory`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.IndustryCategory') AS `emp_industrycategory`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.Location/Location/Loc.CountryRegion') AS `emp_countryregion`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.Location/Location/Loc.State') AS `emp_state`,
    EXTRACTVALUE(`jc`.`Resume`,'/Resume/Employment/Emp.Location/Location/Loc.City') AS `emp_city` 
FROM `adventureworks2025`.`humanresources_jobcandidate` `jc`;

-- -------------------------------------------------------------
--FUNCTION AND PROCEDURE
-- ---------------------------------------------------------------

--FUNCTION ufnGetAccountingStartDate

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetAccountingStartDate`$$
CREATE FUNCTION `ufnGetAccountingStartDate`() 
RETURNS DATE
DETERMINISTIC
BEGIN
    RETURN STR_TO_DATE('20030701', '%Y%m%d');
END$$

DELIMITER ;


--FUNCTION ufnGetAccountingEndDate

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetAccountingEndDate`$$
CREATE FUNCTION `ufnGetAccountingEndDate`() 
RETURNS DATETIME(6)
DETERMINISTIC
BEGIN
    RETURN DATE_SUB(STR_TO_DATE('20040701', '%Y%m%d'), INTERVAL 2 MICROSECOND);
END$$

DELIMITER ;


--FUNCTION ufnGetDocumentStatusText

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetDocumentStatusText`$$
CREATE FUNCTION `ufnGetDocumentStatusText`(StatusValue TINYINT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN (
        CASE StatusValue
            WHEN 1 THEN 'Pending approval'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Obsolete'
            ELSE '** Invalid **'
        END
    );
END$$

DELIMITER ;


--FUNCTION ufnGetPurchaseOrderStatusText

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetPurchaseOrderStatusText`$$
CREATE FUNCTION `ufnGetPurchaseOrderStatusText`(StatusValue TINYINT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN (
        CASE StatusValue
            WHEN 1 THEN 'Pending'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Rejected'
            WHEN 4 THEN 'Complete'
            ELSE '** Invalid **'
        END
    );
END$$

DELIMITER ;


--FUNCTION ufnGetSalesOrderStatusText

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetSalesOrderStatusText`$$
CREATE FUNCTION `ufnGetSalesOrderStatusText`(StatusValue TINYINT) 
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
    DECLARE ret VARCHAR(15);
    SET ret = CASE StatusValue
        WHEN 1 THEN 'In process'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Backordered'
        WHEN 4 THEN 'Rejected'
        WHEN 5 THEN 'Shipped'
        WHEN 6 THEN 'Cancelled'
        ELSE '** Invalid **'
    END;
    RETURN ret;
END$$

DELIMITER ;


--FUNCTION ufnLeadingZeros

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnLeadingZeros`$$
CREATE FUNCTION `ufnLeadingZeros`(p_Value INT) 
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    RETURN LPAD(CAST(p_Value AS CHAR), 8, '0');
END$$

DELIMITER ;


--FUNCTION ufnGetStock

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetStock`$$
CREATE FUNCTION `ufnGetStock`(ProductIDParam INT) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE ret INT;
    SELECT SUM(p.Quantity) INTO ret
    FROM production_productinventory p
    WHERE p.ProductID = ProductIDParam AND p.LocationID = 6;

    IF ret IS NULL THEN
        SET ret = 0;
    END IF;
    RETURN ret;
END$$

DELIMITER ;


--FUNCTION ufnGetProductStandardCost

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetProductStandardCost`$$
CREATE FUNCTION `ufnGetProductStandardCost`(ProductIDParam INT, OrderDateParam DATETIME) 
RETURNS DECIMAL(19,4)
READS SQL DATA
BEGIN
    DECLARE StandardCost DECIMAL(19,4);
    SELECT pch.StandardCost INTO StandardCost
    FROM production_product p
    INNER JOIN production_productcosthistory pch ON p.ProductID = pch.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN pch.StartDate AND COALESCE(pch.EndDate, STR_TO_DATE('99991231', '%Y%m%d'))
    LIMIT 1;
    RETURN StandardCost;
END$$

DELIMITER ;


--FUNCTION ufnGetProductListPrice

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetProductListPrice`$$
CREATE FUNCTION `ufnGetProductListPrice`(ProductIDParam INT, OrderDateParam DATETIME) 
RETURNS DECIMAL(19,4)
READS SQL DATA
BEGIN
    DECLARE ListPrice DECIMAL(19,4);
    SELECT plph.ListPrice INTO ListPrice
    FROM production_product p
    INNER JOIN production_productlistpricehistory plph ON p.ProductID = plph.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN plph.StartDate AND COALESCE(plph.EndDate, STR_TO_DATE('99991231', '%Y%m%d'))
    LIMIT 1;
    RETURN ListPrice;
END$$

DELIMITER ;


--FUNCTION ufnGetProductDealerPrice

DELIMITER $$

DROP FUNCTION IF EXISTS `ufnGetProductDealerPrice`$$
CREATE FUNCTION `ufnGetProductDealerPrice`(ProductIDParam INT, OrderDateParam DATETIME) 
RETURNS DECIMAL(19,4)
READS SQL DATA
BEGIN
    DECLARE DealerPrice DECIMAL(19,4);
    DECLARE DealerDiscount DECIMAL(5,2);
    SET DealerDiscount = 0.60;

    SELECT plph.ListPrice * DealerDiscount INTO DealerPrice
    FROM production_product p
    INNER JOIN production_productlistpricehistory plph ON p.ProductID = plph.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN plph.StartDate AND COALESCE(plph.EndDate, STR_TO_DATE('99991231', '%Y%m%d'))
    LIMIT 1;
    RETURN DealerPrice;
END$$

DELIMITER ;


--PROCEDURE ufnGetContactInformation

USE `adventureworks2025`;
DELIMITER $$

DROP PROCEDURE IF EXISTS `ufnGetContactInformation`$$
CREATE PROCEDURE `ufnGetContactInformation`(IN p_PersonID INT)
BEGIN
    -- Employee
    SELECT 
        p_PersonID AS PersonID, p.FirstName, p.LastName, e.JobTitle, 'Employee' AS BusinessEntityType
    FROM HumanResources_Employee e
    INNER JOIN Person_Person p ON p.BusinessEntityID = e.BusinessEntityID
    WHERE e.BusinessEntityID = p_PersonID
    UNION ALL
    -- Vendor Contact
    SELECT
        p_PersonID AS PersonID, p.FirstName, p.LastName, ct.Name AS JobTitle, 'Vendor Contact' AS BusinessEntityType
    FROM Purchasing_Vendor v
    INNER JOIN Person_BusinessEntityContact bec ON bec.BusinessEntityID = v.BusinessEntityID
    INNER JOIN Person_ContactType ct ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN Person_Person p ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = p_PersonID
    UNION ALL
    -- Store Contact
    SELECT
        p_PersonID AS PersonID, p.FirstName, p.LastName, ct.Name AS JobTitle, 'Store Contact' AS BusinessEntityType
    FROM Sales_Store s
    INNER JOIN Person_BusinessEntityContact bec ON bec.BusinessEntityID = s.BusinessEntityID
    INNER JOIN Person_ContactType ct ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN Person_Person p ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = p_PersonID
    UNION ALL
    -- Consumer
    SELECT
        p_PersonID AS PersonID, p.FirstName, p.LastName, NULL AS JobTitle, 'Consumer' AS BusinessEntityType
    FROM Person_Person p
    INNER JOIN Sales_Customer c ON c.PersonID = p.BusinessEntityID
    WHERE p.BusinessEntityID = p_PersonID AND c.StoreID IS NULL;
END$$

DELIMITER ;


--PROCEDURE uspLogError

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspLogError`$$
CREATE PROCEDURE `uspLogError`(OUT ErrorLogIDParam INT)
BEGIN
    SET ErrorLogIDParam = 0;
    INSERT INTO errorlog (
        UserName, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage
    )
    VALUES (
        CURRENT_USER(), NULL, NULL, NULL, 'uspLogError', NULL, 'Error logged from MySQL procedure'
    );
    SET ErrorLogIDParam = LAST_INSERT_ID();
END$$

DELIMITER ;


--PROCEDURE uspPrintError

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspPrintError`$$
CREATE PROCEDURE `uspPrintError`()
BEGIN
    SELECT 'MySQL Error Information' AS Message, CURRENT_USER() AS CurrentUser, NOW() AS ErrorTime;
END$$

DELIMITER ;


--PROCEDURE uspSearchCandidateResumes

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspSearchCandidateResumes`$$
CREATE PROCEDURE `uspSearchCandidateResumes`(IN searchStringParam VARCHAR(255))
BEGIN
    SELECT JobCandidateID, MATCH(Resume) AGAINST(searchStringParam IN NATURAL LANGUAGE MODE) AS RankScore
    FROM humanresources_jobcandidate
    WHERE MATCH(Resume) AGAINST(searchStringParam IN NATURAL LANGUAGE MODE);
END$$

DELIMITER ;


--PROCEDURE uspUpdateEmployeeHireInfo

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspUpdateEmployeeHireInfo`$$
CREATE PROCEDURE `uspUpdateEmployeeHireInfo`(
    IN BusinessEntityIDParam INT,
    IN JobTitleParam VARCHAR(50),
    IN HireDateParam DATE,
    IN RateChangeDateParam DATETIME,
    IN RateParam DECIMAL(19,4),
    IN PayFrequencyParam TINYINT,
    IN CurrentFlagParam TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE humanresources_employee
        SET JobTitle = JobTitleParam, HireDate = HireDateParam, CurrentFlag = CurrentFlagParam
        WHERE BusinessEntityID = BusinessEntityIDParam;

        INSERT INTO humanresources_employeepayhistory (BusinessEntityID, RateChangeDate, Rate, PayFrequency)
        VALUES (BusinessEntityIDParam, RateChangeDateParam, RateParam, PayFrequencyParam);
    COMMIT;
END$$

DELIMITER ;


--PROCEDURE uspUpdateEmployeeLogin

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspUpdateEmployeeLogin`$$
CREATE PROCEDURE `uspUpdateEmployeeLogin`(
    IN BusinessEntityIDParam INT,
    IN OrganizationNodeParam VARCHAR(255),
    IN LoginIDParam VARCHAR(256),
    IN JobTitleParam VARCHAR(50),
    IN HireDateParam DATE,
    IN CurrentFlagParam TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE humanresources_employee
        SET OrganizationNode = OrganizationNodeParam, LoginID = LoginIDParam, JobTitle = JobTitleParam, HireDate = HireDateParam, CurrentFlag = CurrentFlagParam
        WHERE BusinessEntityID = BusinessEntityIDParam;
    COMMIT;
END$$

DELIMITER ;


--PROCEDURE uspUpdateEmployeePersonalInfo

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspUpdateEmployeePersonalInfo`$$
CREATE PROCEDURE `uspUpdateEmployeePersonalInfo`(
    IN BusinessEntityIDParam INT,
    IN NationalIDNumberParam VARCHAR(15),
    IN BirthDateParam DATE,
    IN MaritalStatusParam CHAR(1),
    IN GenderParam CHAR(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE humanresources_employee
        SET NationalIDNumber = NationalIDNumberParam, BirthDate = BirthDateParam, MaritalStatus = MaritalStatusParam, Gender = GenderParam
        WHERE BusinessEntityID = BusinessEntityIDParam;
    COMMIT;
END$$

DELIMITER ;


--PROCEDURE uspGetBillOfMaterials

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspGetBillOfMaterials`$$
CREATE PROCEDURE `uspGetBillOfMaterials`(IN StartProductIDParam INT, IN CheckDateParam DATETIME)
BEGIN
    WITH RECURSIVE BOM_cte (ProductAssemblyID, ComponentID, ComponentDesc, PerAssemblyQty, StandardCost, ListPrice, BOMLevel, RecursionLevel) AS (
        SELECT b.ProductAssemblyID, b.ComponentID, p.Name, b.PerAssemblyQty, p.StandardCost, p.ListPrice, b.BOMLevel, 0
        FROM production_billofmaterials b
        INNER JOIN production_product p ON b.ComponentID = p.ProductID
        WHERE b.ProductAssemblyID = StartProductIDParam
          AND CheckDateParam >= b.StartDate AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)
        UNION ALL
        SELECT b.ProductAssemblyID, b.ComponentID, p.Name, b.PerAssemblyQty, p.StandardCost, p.ListPrice, b.BOMLevel, cte.RecursionLevel + 1
        FROM BOM_cte cte
        INNER JOIN production_billofmaterials b ON b.ProductAssemblyID = cte.ComponentID
        INNER JOIN production_product p ON b.ComponentID = p.ProductID
        WHERE CheckDateParam >= b.StartDate AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam) AND cte.RecursionLevel < 25
    )
    SELECT ProductAssemblyID, ComponentID, ComponentDesc, SUM(PerAssemblyQty) AS TotalQuantity, StandardCost, ListPrice, BOMLevel, RecursionLevel
    FROM BOM_cte
    GROUP BY ProductAssemblyID, ComponentID, ComponentDesc, BOMLevel, RecursionLevel, StandardCost, ListPrice
    ORDER BY BOMLevel, ProductAssemblyID, ComponentID;
END$$

DELIMITER ;


--PROCEDURE uspGetEmployeeManagers

USE `adventureworks2025`;
DELIMITER $$

DROP PROCEDURE IF EXISTS `uspGetEmployeeManagers`$$
CREATE PROCEDURE `uspGetEmployeeManagers`(IN BusinessEntityIDParam INT)
BEGIN
    WITH RECURSIVE EMP_cte (BusinessEntityID, OrganizationNode, FirstName, LastName, JobTitle, RecursionLevel) AS (
        SELECT e.BusinessEntityID, e.OrganizationNode, p.FirstName, p.LastName, e.JobTitle, 0
        FROM humanresources_employee e
        INNER JOIN person_person p ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam
        UNION ALL
        SELECT mgr.BusinessEntityID, mgr.OrganizationNode, pp.FirstName, pp.LastName, mgr.JobTitle, cte.RecursionLevel + 1
        FROM EMP_cte cte
        INNER JOIN humanresources_employee mgr ON mgr.OrganizationNode = LEFT(cte.OrganizationNode, LENGTH(cte.OrganizationNode) - LOCATE('/', REVERSE(LEFT(cte.OrganizationNode, LENGTH(cte.OrganizationNode) - 1))))
        INNER JOIN person_person pp ON pp.BusinessEntityID = mgr.BusinessEntityID
        WHERE cte.RecursionLevel < 25 AND cte.OrganizationNode IS NOT NULL AND cte.OrganizationNode <> '/'
    )
    SELECT RecursionLevel, BusinessEntityID, FirstName, LastName, OrganizationNode, JobTitle
    FROM EMP_cte
    ORDER BY RecursionLevel;
END$$

DELIMITER ;


--PROCEDURE uspGetManagerEmployees

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspGetManagerEmployees`$$
CREATE PROCEDURE `uspGetManagerEmployees`(IN BusinessEntityIDParam INT)
BEGIN
    WITH RECURSIVE EMP_cte (BusinessEntityID, OrganizationNode, FirstName, LastName, JobTitle, RecursionLevel) AS (
        SELECT e.BusinessEntityID, e.OrganizationNode, p.FirstName, p.LastName, e.JobTitle, 0
        FROM humanresources_employee e
        INNER JOIN person_person p ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam
        UNION ALL
        SELECT child.BusinessEntityID, child.OrganizationNode, pp.FirstName, pp.LastName, child.JobTitle, cte.RecursionLevel + 1
        FROM humanresources_employee child
        INNER JOIN EMP_cte cte ON child.OrganizationNode LIKE CONCAT(cte.OrganizationNode, '%') AND child.OrganizationNode <> cte.OrganizationNode
        INNER JOIN person_person pp ON pp.BusinessEntityID = child.BusinessEntityID
        WHERE cte.RecursionLevel < 25
    )
    SELECT RecursionLevel, OrganizationNode, BusinessEntityID, FirstName, LastName, JobTitle
    FROM EMP_cte
    ORDER BY RecursionLevel, OrganizationNode;
END$$

DELIMITER ;


--PROCEDURE uspGetWhereUsedProductID

DELIMITER $$

DROP PROCEDURE IF EXISTS `uspGetWhereUsedProductID`$$
CREATE PROCEDURE `uspGetWhereUsedProductID`(IN StartProductIDParam INT, IN CheckDateParam DATETIME)
BEGIN

    WITH RECURSIVE BOM_cte (ProductAssemblyID, ComponentID, ComponentDesc, PerAssemblyQty, StandardCost, ListPrice, BOMLevel, RecursionLevel) AS (
        SELECT b.ProductAssemblyID, b.ComponentID, p.Name, b.PerAssemblyQty, p.StandardCost, p.ListPrice, b.BOMLevel, 0
        FROM production_billofmaterials b
        INNER JOIN production_product p ON b.ProductAssemblyID = p.ProductID
        WHERE b.ComponentID = StartProductIDParam
          AND CheckDateParam >= b.StartDate AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)
        UNION ALL
        SELECT b.ProductAssemblyID, b.ComponentID, p.Name, b.PerAssemblyQty, p.StandardCost, p.ListPrice, b.BOMLevel, cte.RecursionLevel + 1
        FROM BOM_cte cte
        INNER JOIN production_billofmaterials b ON cte.ProductAssemblyID = b.ComponentID
        INNER JOIN production_product p ON b.ProductAssemblyID = p.ProductID
        WHERE CheckDateParam >= b.StartDate AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam) AND cte.RecursionLevel < 25
    )
    SELECT ProductAssemblyID, ComponentID, ComponentDesc, SUM(PerAssemblyQty) AS TotalQuantity, StandardCost, ListPrice, BOMLevel, RecursionLevel
    FROM BOM_cte
    GROUP BY ProductAssemblyID, ComponentID, ComponentDesc, BOMLevel, RecursionLevel, StandardCost, ListPrice
    ORDER BY BOMLevel, ProductAssemblyID, ComponentID;
END$$

DELIMITER ;