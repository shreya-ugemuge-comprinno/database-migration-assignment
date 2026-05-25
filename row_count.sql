
-- Microsoft SQL Server (T-SQL) : Schema-wise row counts

-- ============ SALES ==========================

SELECT 'Sales.SalesOrderDetail' AS table_name, COUNT(*) AS exact_row_count FROM Sales.SalesOrderDetail UNION ALL -- 121317
SELECT 'Sales.SalesOrderHeader', COUNT(*) FROM Sales.SalesOrderHeader UNION ALL -- 31465
SELECT 'Sales.SalesOrderHeaderSalesReason', COUNT(*) FROM Sales.SalesOrderHeaderSalesReason UNION ALL -- 27647
SELECT 'Sales.Customer', COUNT(*) FROM Sales.Customer UNION ALL -- 19820
SELECT 'Sales.PersonCreditCard', COUNT(*) FROM Sales.PersonCreditCard UNION ALL -- 19118
SELECT 'Sales.CreditCard', COUNT(*) FROM Sales.CreditCard UNION ALL -- 19118
SELECT 'Sales.CurrencyRate', COUNT(*) FROM Sales.CurrencyRate UNION ALL -- 13532
SELECT 'Sales.Store', COUNT(*) FROM Sales.Store UNION ALL -- 701
SELECT 'Sales.SpecialOfferProduct', COUNT(*) FROM Sales.SpecialOfferProduct UNION ALL -- 538
SELECT 'Sales.SalesPersonQuotaHistory', COUNT(*) FROM Sales.SalesPersonQuotaHistory UNION ALL -- 163
SELECT 'Sales.CountryRegionCurrency', COUNT(*) FROM Sales.CountryRegionCurrency UNION ALL -- 109
SELECT 'Sales.Currency', COUNT(*) FROM Sales.Currency UNION ALL -- 105
SELECT 'Sales.SalesTaxRate', COUNT(*) FROM Sales.SalesTaxRate UNION ALL -- 29
SELECT 'Sales.SalesPerson', COUNT(*) FROM Sales.SalesPerson UNION ALL -- 17
SELECT 'Sales.SalesTerritoryHistory', COUNT(*) FROM Sales.SalesTerritoryHistory UNION ALL -- 17
SELECT 'Sales.SpecialOffer', COUNT(*) FROM Sales.SpecialOffer UNION ALL -- 16
SELECT 'Sales.SalesReason', COUNT(*) FROM Sales.SalesReason UNION ALL -- 10
SELECT 'Sales.SalesTerritory', COUNT(*) FROM Sales.SalesTerritory UNION ALL -- 10
SELECT 'Sales.ShoppingCartItem', COUNT(*) FROM Sales.ShoppingCartItem UNION ALL -- 3


-- ========================= PRODUCTION =========================

SELECT 'Production.TransactionHistory', COUNT(*) FROM Production.TransactionHistory UNION ALL -- 113443
SELECT 'Production.TransactionHistoryArchive', COUNT(*) FROM Production.TransactionHistoryArchive UNION ALL -- 89253
SELECT 'Production.WorkOrder', COUNT(*) FROM Production.WorkOrder UNION ALL -- 89253
SELECT 'Production.WorkOrderRouting', COUNT(*) FROM Production.WorkOrderRouting UNION ALL -- 67131
SELECT 'Production.BillOfMaterials', COUNT(*) FROM Production.BillOfMaterials UNION ALL --  2679
SELECT 'Production.ProductInventory', COUNT(*) FROM Production.ProductInventory UNION ALL -- 1069
SELECT 'Production.ProductDescription', COUNT(*) FROM Production.ProductDescription UNION ALL -- 762
SELECT 'Production.ProductModelProductDescriptionCulture', COUNT(*) FROM Production.ProductModelProductDescriptionCulture UNION ALL -- 762
SELECT 'Production.Product', COUNT(*) FROM Production.Product UNION ALL -- 504--
SELECT 'Production.ProductProductPhoto', COUNT(*) FROM Production.ProductProductPhoto UNION ALL -- 504
SELECT 'Production.ProductCostHistory', COUNT(*) FROM Production.ProductCostHistory UNION ALL -- 395
SELECT 'Production.ProductListPriceHistory', COUNT(*) FROM Production.ProductListPriceHistory UNION ALL -- 395
SELECT 'Production.ProductModel', COUNT(*) FROM Production.ProductModel UNION ALL  -- 128
SELECT 'Production.ProductPhoto', COUNT(*) FROM Production.ProductPhoto UNION ALL  -- 101
SELECT 'Production.UnitMeasure', COUNT(*) FROM Production.UnitMeasure UNION ALL -- 38
SELECT 'Production.ProductSubcategory', COUNT(*) FROM Production.ProductSubcategory UNION ALL  -- 37
SELECT 'Production.ProductDocument', COUNT(*) FROM Production.ProductDocument UNION ALL -- 32
SELECT 'Production.ScrapReason', COUNT(*) FROM Production.ScrapReason UNION ALL  -- 16
SELECT 'Production.Location', COUNT(*) FROM Production.Location UNION ALL -- 14
SELECT 'Production.Document', COUNT(*) FROM Production.Document UNION ALL -- 12
SELECT 'Production.Culture', COUNT(*) FROM Production.Culture UNION ALL --  8
SELECT 'Production.ProductModelIllustration', COUNT(*) FROM Production.ProductModelIllustration UNION ALL -- 7
SELECT 'Production.Illustration', COUNT(*) FROM Production.Illustration UNION ALL -- 5
SELECT 'Production.ProductReview', COUNT(*) FROM Production.ProductReview UNION ALL -- 4
SELECT 'Production.ProductCategory', COUNT(*) FROM Production.ProductCategory UNION ALL -- 4

-- ========================= PERSON ========================= 

SELECT 'Person.PersonPhone', COUNT(*) FROM Person.PersonPhone UNION ALL -- 19972
SELECT 'Person.EmailAddress', COUNT(*) FROM Person.EmailAddress UNION ALL -- 19972
SELECT 'Person.Password', COUNT(*) FROM Person.Password UNION ALL -- 19972
SELECT 'Person.Person', COUNT(*) FROM Person.Person UNION ALL -- 19972
SELECT 'Person.BusinessEntityAddress', COUNT(*) FROM Person.BusinessEntityAddress UNION ALL -- 19614
SELECT 'Person.BusinessEntity', COUNT(*) FROM Person.BusinessEntity UNION ALL -- 20777
SELECT 'Person.Address', COUNT(*) FROM Person.Address UNION ALL -- 19614
SELECT 'Person.BusinessEntityContact', COUNT(*) FROM Person.BusinessEntityContact UNION ALL -- 909
SELECT 'Person.CountryRegion', COUNT(*) FROM Person.CountryRegion UNION ALL -- 238
SELECT 'Person.StateProvince', COUNT(*) FROM Person.StateProvince UNION ALL -- 181
SELECT 'Person.ContactType', COUNT(*) FROM Person.ContactType UNION ALL -- 20
SELECT 'Person.AddressType', COUNT(*) FROM Person.AddressType UNION ALL -- 6
SELECT 'Person.PhoneNumberType', COUNT(*) FROM Person.PhoneNumberType UNION ALL -- 3

-- ========================= PURCHASING ========================= 

SELECT 'Purchasing.PurchaseOrderDetail', COUNT(*) FROM Purchasing.PurchaseOrderDetail UNION ALL -- 8845
SELECT 'Purchasing.PurchaseOrderHeader', COUNT(*) FROM Purchasing.PurchaseOrderHeader UNION ALL -- 4012
SELECT 'Purchasing.ProductVendor', COUNT(*) FROM Purchasing.ProductVendor UNION ALL -- 460
SELECT 'Purchasing.Vendor', COUNT(*) FROM Purchasing.Vendor UNION ALL -- 104
SELECT 'Purchasing.ShipMethod', COUNT(*) FROM Purchasing.ShipMethod UNION ALL-- 5

-- ========================= HUMANRESOURCES ========================= 

SELECT 'HumanResources.EmployeePayHistory', COUNT(*) FROM HumanResources.EmployeePayHistory UNION ALL -- 316
SELECT 'HumanResources.EmployeeDepartmentHistory', COUNT(*) FROM HumanResources.EmployeeDepartmentHistory UNION ALL -- 296
SELECT 'HumanResources.Employee', COUNT(*) FROM HumanResources.Employee UNION ALL -- 290
SELECT 'HumanResources.Department', COUNT(*) FROM HumanResources.Department UNION ALL -- 16
SELECT 'HumanResources.JobCandidate', COUNT(*) FROM HumanResources.JobCandidate UNION ALL -- 13
SELECT 'HumanResources.Shift', COUNT(*) FROM HumanResources.Shift UNION ALL-- 3



-- ========================  MySQL ====================================


SELECT COUNT(*) AS count FROM humanresources_department;  -- 16
SELECT COUNT(*) AS count FROM humanresources_employee;  -- 290
SELECT COUNT(*) AS count FROM humanresources_employeedepartmenthistory;  -- 296
SELECT COUNT(*) AS count FROM humanresources_employeepayhistory;  -- 316
SELECT COUNT(*) AS count FROM humanresources_jobcandidate;  -- 13
SELECT COUNT(*) AS count FROM humanresources_shift;  -- 3
SELECT COUNT(*) AS count FROM person_address;  -- 19614
SELECT COUNT(*) AS count FROM person_addresstype;  -- 6
SELECT COUNT(*) AS count FROM person_businessentity;  -- 20777
SELECT COUNT(*) AS count FROM person_businessentityaddress;  -- 19614
SELECT COUNT(*) AS count FROM person_businessentitycontact;  -- 909
SELECT COUNT(*) AS count FROM person_contacttype;  -- 20
SELECT COUNT(*) AS count FROM person_countryregion;  -- 238
SELECT COUNT(*) AS count FROM person_emailaddress;  -- 19972
SELECT COUNT(*) AS count FROM person_password;  -- 19972
SELECT COUNT(*) AS count FROM person_person;  -- 19972
SELECT COUNT(*) AS count FROM person_personphone;  -- 19972
SELECT COUNT(*) AS count FROM person_phonenumbertype;  -- 3
SELECT COUNT(*) AS count FROM person_stateprovince;  -- 181
SELECT COUNT(*) AS count FROM production_billofmaterials;   -- 2679
SELECT COUNT(*) AS count FROM production_culture;  -- 8
SELECT COUNT(*) AS count FROM production_document;  -- 12
SELECT COUNT(*) AS count FROM production_illustration;   -- 5
SELECT COUNT(*) AS count FROM production_location;  -- 14
SELECT COUNT(*) AS count FROM production_product;  -- 504
SELECT COUNT(*) AS count FROM production_productcategory;  -- 4
SELECT COUNT(*) AS count FROM production_productcosthistory;  -- 395
SELECT COUNT(*) AS count FROM production_productdescription;  -- 762
SELECT COUNT(*) AS count FROM production_productdocument;  -- 32
SELECT COUNT(*) AS count FROM production_productinventory;  -- 1069
SELECT COUNT(*) AS count FROM production_productlistpricehistory;  -- 395
SELECT COUNT(*) AS count FROM production_productmodel;  -- 128
SELECT COUNT(*) AS count FROM production_productmodelillustration;  -- 7
SELECT COUNT(*) AS count FROM production_productmodelproductdescriptionculture;  -- 762
SELECT COUNT(*) AS count FROM production_productphoto;  -- 101
SELECT COUNT(*) AS count FROM production_productproductphoto;  -- 504
SELECT COUNT(*) AS count FROM production_productreview;  -- 4
SELECT COUNT(*) AS count FROM production_productsubcategory;  -- 37
SELECT COUNT(*) AS count FROM production_scrapreason;  -- 16
SELECT COUNT(*) AS count FROM production_transactionhistory;  -- 113443
SELECT COUNT(*) AS count FROM production_transactionhistoryarchive;  -- 89253
SELECT COUNT(*) AS count FROM production_unitmeasure;  -- 38
SELECT COUNT(*) AS count FROM production_workorder;  -- 72591
SELECT COUNT(*) AS count FROM production_workorderrouting;  -- 67131
SELECT COUNT(*) AS count FROM purchasing_productvendor;  -- 460
SELECT COUNT(*) AS count FROM purchasing_purchaseorderdetail;  -- 8845
SELECT COUNT(*) AS count FROM purchasing_purchaseorderheader;  -- 4012
SELECT COUNT(*) AS count FROM purchasing_shipmethod;  -- 5
SELECT COUNT(*) AS count FROM purchasing_vendor;  -- 104
SELECT COUNT(*) AS count FROM sales_countryregioncurrency;  -- 109
SELECT COUNT(*) AS count FROM sales_creditcard;  -- 19118
SELECT COUNT(*) AS count FROM sales_currency;  -- 105
SELECT COUNT(*) AS count FROM sales_currencyrate;  -- 13532
SELECT COUNT(*) AS count FROM sales_customer;  -- 19820
SELECT COUNT(*) AS count FROM sales_personcreditcard;  -- 19118
SELECT COUNT(*) AS count FROM sales_salesterritoryhistory;  -- 17
SELECT COUNT(*) AS count FROM sales_salesorderdetail;   -- 121317
SELECT COUNT(*) AS count FROM sales_salesorderheader;  -- 31465
SELECT COUNT(*) AS count FROM sales_salesorderheadersalesreason;  -- 27647
SELECT COUNT(*) AS count FROM sales_salesperson;  -- 17
SELECT COUNT(*) AS count FROM sales_salespersonquotahistory;  -- 163
SELECT COUNT(*) AS count FROM sales_salesreason;  -- 10
SELECT COUNT(*) AS count FROM sales_salestaxrate;  -- 29
SELECT COUNT(*) AS count FROM sales_salesterritory;  -- 10 
SELECT COUNT(*) AS count FROM sales_shopping_cart_item;  -- 3
SELECT COUNT(*) AS count FROM sales_specialoffer;  -- 16
SELECT COUNT(*) AS count FROM sales_specialofferproduct;   -- 538
SELECT COUNT(*) AS count FROM sales_store;  -- 701





-- ================== POSTGRES ============================

-- ========================= SALES ========================= 

SELECT 'Sales.SalesOrderDetail' AS table_name, COUNT(*) AS exact_row_count FROM Sales.SalesOrderDetail UNION ALL -- 121317
SELECT 'Sales.SalesOrderHeader', COUNT(*) FROM Sales.SalesOrderHeader UNION ALL  -- 31465
SELECT 'Sales.SalesOrderHeaderSalesReason', COUNT(*) FROM Sales.SalesOrderHeaderSalesReason UNION ALL -- 27647
SELECT 'Sales.Customer', COUNT(*) FROM Sales.Customer UNION ALL -- 19820
SELECT 'Sales.PersonCreditCard', COUNT(*) FROM Sales.PersonCreditCard UNION ALL -- 19118
SELECT 'Sales.CreditCard', COUNT(*) FROM Sales.CreditCard UNION ALL -- 19118
SELECT 'Sales.CurrencyRate', COUNT(*) FROM Sales.CurrencyRate UNION ALL -- 13532
SELECT 'Sales.Store', COUNT(*) FROM Sales.Store UNION ALL -- 701
SELECT 'Sales.SpecialOfferProduct', COUNT(*) FROM Sales.SpecialOfferProduct UNION ALL -- 538
SELECT 'Sales.SalesPersonQuotaHistory', COUNT(*) FROM Sales.SalesPersonQuotaHistory UNION ALL -- 163
SELECT 'Sales.CountryRegionCurrency', COUNT(*) FROM Sales.CountryRegionCurrency UNION ALL -- 109
SELECT 'Sales.Currency', COUNT(*) FROM Sales.Currency UNION ALL -- 105
SELECT 'Sales.SalesTaxRate', COUNT(*) FROM Sales.SalesTaxRate UNION ALL -- 29
SELECT 'Sales.SalesPerson', COUNT(*) FROM Sales.SalesPerson UNION ALL -- 17
SELECT 'Sales.SalesTerritoryHistory', COUNT(*) FROM Sales.SalesTerritoryHistory UNION ALL -- 17
SELECT 'Sales.SpecialOffer', COUNT(*) FROM Sales.SpecialOffer UNION ALL -- 16
SELECT 'Sales.SalesReason', COUNT(*) FROM Sales.SalesReason UNION ALL -- 10
SELECT 'Sales.SalesTerritory', COUNT(*) FROM Sales.SalesTerritory UNION ALL -- 10
SELECT 'Sales.ShoppingCartItem', COUNT(*) FROM Sales.ShoppingCartItem UNION ALL -- 3

-- ========================= PRODUCTION ========================= 

SELECT 'Production.TransactionHistory', COUNT(*) FROM Production.TransactionHistory UNION ALL -- 113443
SELECT 'Production.TransactionHistoryArchive', COUNT(*) FROM Production.TransactionHistoryArchive UNION ALL -- 89253
SELECT 'Production.WorkOrder', COUNT(*) FROM Production.WorkOrder UNION ALL -- 89253
SELECT 'Production.WorkOrderRouting', COUNT(*) FROM Production.WorkOrderRouting UNION ALL -- 67131
SELECT 'Production.BillOfMaterials', COUNT(*) FROM Production.BillOfMaterials UNION ALL -- 2679
SELECT 'Production.ProductInventory', COUNT(*) FROM Production.ProductInventory UNION ALL -- 1069
SELECT 'Production.ProductDescription', COUNT(*) FROM Production.ProductDescription UNION ALL -- 762
SELECT 'Production.ProductModelProductDescriptionCulture', COUNT(*) FROM Production.ProductModelProductDescriptionCulture UNION ALL -- 762
SELECT 'Production.Product', COUNT(*) FROM Production.Product UNION ALL -- 504--
SELECT 'Production.ProductProductPhoto', COUNT(*) FROM Production.ProductProductPhoto UNION ALL -- 504
SELECT 'Production.ProductCostHistory', COUNT(*) FROM Production.ProductCostHistory UNION ALL -- 395
SELECT 'Production.ProductListPriceHistory', COUNT(*) FROM Production.ProductListPriceHistory UNION ALL -- 395
SELECT 'Production.ProductModel', COUNT(*) FROM Production.ProductModel UNION ALL  -- 128
SELECT 'Production.ProductPhoto', COUNT(*) FROM Production.ProductPhoto UNION ALL  -- 101
SELECT 'Production.UnitMeasure', COUNT(*) FROM Production.UnitMeasure UNION ALL -- 38
SELECT 'Production.ProductSubcategory', COUNT(*) FROM Production.ProductSubcategory UNION ALL  -- 37
SELECT 'Production.ProductDocument', COUNT(*) FROM Production.ProductDocument UNION ALL -- 32
SELECT 'Production.ScrapReason', COUNT(*) FROM Production.ScrapReason UNION ALL  -- 16
SELECT 'Production.Location', COUNT(*) FROM Production.Location UNION ALL -- 14
SELECT 'Production.Document', COUNT(*) FROM Production.Document UNION ALL -- 12
SELECT 'Production.Culture', COUNT(*) FROM Production.Culture UNION ALL -- 8
SELECT 'Production.ProductModelIllustration', COUNT(*) FROM Production.ProductModelIllustration UNION ALL -- 7
SELECT 'Production.Illustration', COUNT(*) FROM Production.Illustration UNION ALL -- 5
SELECT 'Production.ProductReview', COUNT(*) FROM Production.ProductReview UNION ALL -- 4
SELECT 'Production.ProductCategory', COUNT(*) FROM Production.ProductCategory UNION ALL -- 4

-- ========================= PERSON ========================

SELECT 'Person.PersonPhone', COUNT(*) FROM Person.PersonPhone UNION ALL -- 19972
SELECT 'Person.EmailAddress', COUNT(*) FROM Person.EmailAddress UNION ALL -- 19972
SELECT 'Person.Password', COUNT(*) FROM Person.Password UNION ALL -- 19972
SELECT 'Person.Person', COUNT(*) FROM Person.Person UNION ALL -- 19972
SELECT 'Person.BusinessEntityAddress', COUNT(*) FROM Person.BusinessEntityAddress UNION ALL -- 19614
SELECT 'Person.BusinessEntity', COUNT(*) FROM Person.BusinessEntity UNION ALL -- 20777
SELECT 'Person.Address', COUNT(*) FROM Person.Address UNION ALL -- 19614
SELECT 'Person.BusinessEntityContact', COUNT(*) FROM Person.BusinessEntityContact UNION ALL -- 909
SELECT 'Person.CountryRegion', COUNT(*) FROM Person.CountryRegion UNION ALL -- 238
SELECT 'Person.StateProvince', COUNT(*) FROM Person.StateProvince UNION ALL -- 181
SELECT 'Person.ContactType', COUNT(*) FROM Person.ContactType UNION ALL -- 20
SELECT 'Person.AddressType', COUNT(*) FROM Person.AddressType UNION ALL -- 6
SELECT 'Person.PhoneNumberType', COUNT(*) FROM Person.PhoneNumberType UNION ALL -- 3

-- ========================= PURCHASING ========================= 

SELECT 'Purchasing.PurchaseOrderDetail', COUNT(*) FROM Purchasing.PurchaseOrderDetail UNION ALL -- 8845
SELECT 'Purchasing.PurchaseOrderHeader', COUNT(*) FROM Purchasing.PurchaseOrderHeader UNION ALL -- 4012
SELECT 'Purchasing.ProductVendor', COUNT(*) FROM Purchasing.ProductVendor UNION ALL -- 460
SELECT 'Purchasing.Vendor', COUNT(*) FROM Purchasing.Vendor UNION ALL -- 104
SELECT 'Purchasing.ShipMethod', COUNT(*) FROM Purchasing.ShipMethod UNION ALL-- 5

-- ========================= HUMANRESOURCES ========================= 

SELECT 'HumanResources.EmployeePayHistory', COUNT(*) FROM HumanResources.EmployeePayHistory UNION ALL -- 316
SELECT 'HumanResources.EmployeeDepartmentHistory', COUNT(*) FROM HumanResources.EmployeeDepartmentHistory UNION ALL -- 296
SELECT 'HumanResources.Employee', COUNT(*) FROM HumanResources.Employee UNION ALL -- 290
SELECT 'HumanResources.Department', COUNT(*) FROM HumanResources.Department UNION ALL -- 16
SELECT 'HumanResources.JobCandidate', COUNT(*) FROM HumanResources.JobCandidate UNION ALL -- 13
SELECT 'HumanResources.Shift', COUNT(*) FROM HumanResources.Shift;-- 3



