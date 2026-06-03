CREATE DATABASE AdventureWorks2025;
USE AdventureWorks2025;

CREATE TABLE Person_BusinessEntity (
    BusinessEntityID INT AUTO_INCREMENT PRIMARY KEY,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_AddressType (
    AddressTypeID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_ContactType (
    ContactTypeID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_CountryRegion (
    CountryRegionCode VARCHAR(3) PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_PhoneNumberType (
    PhoneNumberTypeID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_StateProvince (
    StateProvinceID INT AUTO_INCREMENT PRIMARY KEY,

    StateProvinceCode CHAR(3) NOT NULL,

    CountryRegionCode VARCHAR(3) NOT NULL,

    IsOnlyStateProvinceFlag BOOLEAN NOT NULL DEFAULT 1,

    Name VARCHAR(50) NOT NULL,

    TerritoryID INT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_Address (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,

    AddressLine1 VARCHAR(60) NOT NULL,

    AddressLine2 VARCHAR(60) NULL,

    City VARCHAR(30) NOT NULL,

    StateProvinceID INT NOT NULL,

    PostalCode VARCHAR(15) NOT NULL,

    SpatialLocation TEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_Person (
    BusinessEntityID INT PRIMARY KEY,

    PersonType CHAR(2) NOT NULL,

    NameStyle BOOLEAN NOT NULL DEFAULT 0,

    Title VARCHAR(8) NULL,

    FirstName VARCHAR(50) NOT NULL,

    MiddleName VARCHAR(50) NULL,

    LastName VARCHAR(50) NOT NULL,

    Suffix VARCHAR(10) NULL,

    EmailPromotion INT NOT NULL DEFAULT 0,

    AdditionalContactInfo TEXT NULL,

    Demographics TEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Person_EmailAddress (
    BusinessEntityID INT NOT NULL,

    EmailAddressID INT AUTO_INCREMENT,

    EmailAddress VARCHAR(50) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (EmailAddressID)
);

CREATE TABLE Person_PersonPhone (
    BusinessEntityID INT NOT NULL,

    PhoneNumber VARCHAR(25) NOT NULL,

    PhoneNumberTypeID INT NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        PhoneNumber,
        PhoneNumberTypeID
    )
);

CREATE TABLE Person_BusinessEntityAddress (
    BusinessEntityID INT NOT NULL,

    AddressID INT NOT NULL,

    AddressTypeID INT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        AddressID,
        AddressTypeID
    )
);

CREATE TABLE Person_BusinessEntityContact (
    BusinessEntityID INT NOT NULL,

    PersonID INT NOT NULL,

    ContactTypeID INT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        PersonID,
        ContactTypeID
    )
);

CREATE TABLE Person_Password (
    BusinessEntityID INT PRIMARY KEY,

    PasswordHash VARCHAR(128) NOT NULL,

    PasswordSalt VARCHAR(20) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE HumanResources_Department (
    DepartmentID SMALLINT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    GroupName VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE HumanResources_Shift (
    ShiftID TINYINT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    StartTime TIME NOT NULL,

    EndTime TIME NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE HumanResources_Employee (
    BusinessEntityID INT PRIMARY KEY,

    NationalIDNumber VARCHAR(15) NOT NULL,

    LoginID VARCHAR(256) NOT NULL,

    OrganizationNode VARCHAR(255) NULL,

    OrganizationLevel SMALLINT NULL,

    JobTitle VARCHAR(50) NOT NULL,

    BirthDate DATE NOT NULL,

    MaritalStatus CHAR(1) NOT NULL,

    Gender CHAR(1) NOT NULL,

    HireDate DATE NOT NULL,

    SalariedFlag BOOLEAN NOT NULL DEFAULT 1,

    VacationHours SMALLINT NOT NULL DEFAULT 0,

    SickLeaveHours SMALLINT NOT NULL DEFAULT 0,

    CurrentFlag BOOLEAN NOT NULL DEFAULT 1,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE HumanResources_JobCandidate (
    JobCandidateID INT AUTO_INCREMENT PRIMARY KEY,

    BusinessEntityID INT NULL,

    Resume LONGTEXT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE HumanResources_EmployeeDepartmentHistory (
    BusinessEntityID INT NOT NULL,

    DepartmentID SMALLINT NOT NULL,

    ShiftID TINYINT NOT NULL,

    StartDate DATE NOT NULL,

    EndDate DATE NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        DepartmentID,
        ShiftID,
        StartDate
    )
);

CREATE TABLE HumanResources_EmployeePayHistory (
    BusinessEntityID INT NOT NULL,

    RateChangeDate DATETIME NOT NULL,

    Rate DECIMAL(19,4) NOT NULL,

    PayFrequency TINYINT NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        RateChangeDate
    )
);

CREATE TABLE Production_UnitMeasure (
    UnitMeasureCode CHAR(3) PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductCategory (
    ProductCategoryID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductSubcategory (
    ProductSubcategoryID INT AUTO_INCREMENT PRIMARY KEY,

    ProductCategoryID INT NOT NULL,

    Name VARCHAR(50) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductModel (
    ProductModelID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    CatalogDescription LONGTEXT NULL,

    Instructions LONGTEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductDescription (
    ProductDescriptionID INT AUTO_INCREMENT PRIMARY KEY,

    Description LONGTEXT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_Culture (
    CultureID VARCHAR(6) PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductModelProductDescriptionCulture (
    ProductModelID INT NOT NULL,

    ProductDescriptionID INT NOT NULL,

    CultureID VARCHAR(6) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductModelID,
        ProductDescriptionID,
        CultureID
    )
);

CREATE TABLE Production_Location (
    LocationID SMALLINT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    CostRate DECIMAL(10,4) NOT NULL,

    Availability DECIMAL(8,2) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ProductNumber VARCHAR(25) NOT NULL,

    MakeFlag BOOLEAN NOT NULL DEFAULT 1,

    FinishedGoodsFlag BOOLEAN NOT NULL DEFAULT 1,

    Color VARCHAR(15) NULL,

    SafetyStockLevel SMALLINT NOT NULL,

    ReorderPoint SMALLINT NOT NULL,

    StandardCost DECIMAL(19,4) NOT NULL,

    ListPrice DECIMAL(19,4) NOT NULL,

    Size VARCHAR(5) NULL,

    SizeUnitMeasureCode CHAR(3) NULL,

    WeightUnitMeasureCode CHAR(3) NULL,

    Weight DECIMAL(8,2) NULL,

    DaysToManufacture INT NOT NULL,

    ProductLine CHAR(2) NULL,

    Class CHAR(2) NULL,

    Style CHAR(2) NULL,

    ProductSubcategoryID INT NULL,

    ProductModelID INT NULL,

    SellStartDate DATETIME NOT NULL,

    SellEndDate DATETIME NULL,

    DiscontinuedDate DATETIME NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductCostHistory (
    ProductID INT NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NULL,

    StandardCost DECIMAL(19,4) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        StartDate
    )
);

CREATE TABLE Production_ProductListPriceHistory (
    ProductID INT NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NULL,

    ListPrice DECIMAL(19,4) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        StartDate
    )
);

CREATE TABLE Production_BillOfMaterials (
    BillOfMaterialsID INT AUTO_INCREMENT PRIMARY KEY,

    ProductAssemblyID INT NULL,

    ComponentID INT NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NULL,

    UnitMeasureCode CHAR(3) NOT NULL,

    BOMLevel SMALLINT NOT NULL,

    PerAssemblyQty DECIMAL(8,2) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductInventory (
    ProductID INT NOT NULL,

    LocationID SMALLINT NOT NULL,

    Shelf VARCHAR(10) NOT NULL,

    Bin TINYINT NOT NULL,

    Quantity SMALLINT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        LocationID
    )
);

CREATE TABLE Production_ProductReview (
    ProductReviewID INT AUTO_INCREMENT PRIMARY KEY,

    ProductID INT NOT NULL,

    ReviewerName VARCHAR(50) NOT NULL,

    ReviewDate DATETIME NOT NULL,

    EmailAddress VARCHAR(50) NOT NULL,

    Rating INT NOT NULL,

    Comments LONGTEXT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductPhoto (
    ProductPhotoID INT AUTO_INCREMENT PRIMARY KEY,

    ThumbNailPhoto LONGBLOB NULL,

    ThumbnailPhotoFileName VARCHAR(50) NULL,

    LargePhoto LONGBLOB NULL,

    LargePhotoFileName VARCHAR(50) NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductProductPhoto (
    ProductID INT NOT NULL,

    ProductPhotoID INT NOT NULL,

    PrimaryFlag BOOLEAN NOT NULL DEFAULT 0,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        ProductPhotoID
    )
);

CREATE TABLE Production_TransactionHistory (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,

    ProductID INT NOT NULL,

    ReferenceOrderID INT NOT NULL,

    ReferenceOrderLineID INT NOT NULL,

    TransactionDate DATETIME NOT NULL,

    TransactionType CHAR(1) NOT NULL,

    Quantity INT NOT NULL,

    ActualCost DECIMAL(19,4) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_TransactionHistoryArchive (
    TransactionID INT PRIMARY KEY,

    ProductID INT NOT NULL,

    ReferenceOrderID INT NOT NULL,

    ReferenceOrderLineID INT NOT NULL,

    TransactionDate DATETIME NOT NULL,

    TransactionType CHAR(1) NOT NULL,

    Quantity INT NOT NULL,

    ActualCost DECIMAL(19,4) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ScrapReason (
    ScrapReasonID SMALLINT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_WorkOrder (
    WorkOrderID INT AUTO_INCREMENT PRIMARY KEY,

    ProductID INT NOT NULL,

    OrderQty INT NOT NULL,

    StockedQty INT GENERATED ALWAYS AS (
        OrderQty - ScrappedQty
    ) STORED,

    ScrappedQty SMALLINT NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NULL,

    DueDate DATETIME NOT NULL,

    ScrapReasonID SMALLINT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_WorkOrderRouting (
    WorkOrderID INT NOT NULL,

    ProductID INT NOT NULL,

    OperationSequence SMALLINT NOT NULL,

    LocationID SMALLINT NOT NULL,

    ScheduledStartDate DATETIME NOT NULL,

    ScheduledEndDate DATETIME NOT NULL,

    ActualStartDate DATETIME NULL,

    ActualEndDate DATETIME NULL,

    ActualResourceHrs DECIMAL(9,4) NULL,

    PlannedCost DECIMAL(19,4) NOT NULL,

    ActualCost DECIMAL(19,4) NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        WorkOrderID,
        ProductID,
        OperationSequence
    )
);

CREATE TABLE Production_Document (
    DocumentNode VARCHAR(255) PRIMARY KEY,

    DocumentLevel INT NULL,

    Title VARCHAR(50) NOT NULL,

    Owner INT NOT NULL,

    FolderFlag BOOLEAN NOT NULL DEFAULT 0,

    FileName VARCHAR(400) NOT NULL,

    FileExtension VARCHAR(8) NOT NULL,

    Revision CHAR(5) NOT NULL,

    ChangeNumber INT NOT NULL DEFAULT 0,

    Status TINYINT NOT NULL,

    DocumentSummary LONGTEXT NULL,

    Document LONGTEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductDocument (
    ProductID INT NOT NULL,

    DocumentNode VARCHAR(255) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        DocumentNode
    )
);

CREATE TABLE Production_Illustration (
    IllustrationID INT AUTO_INCREMENT PRIMARY KEY,

    Diagram LONGTEXT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Production_ProductModelIllustration (
    ProductModelID INT NOT NULL,

    IllustrationID INT NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductModelID,
        IllustrationID
    )
);

CREATE TABLE Purchasing_ShipMethod (
    ShipMethodID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ShipBase DECIMAL(19,4) NOT NULL,

    ShipRate DECIMAL(19,4) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Purchasing_Vendor (
    BusinessEntityID INT PRIMARY KEY,

    AccountNumber VARCHAR(15) NOT NULL,

    Name VARCHAR(50) NOT NULL,

    CreditRating TINYINT NOT NULL,

    PreferredVendorStatus BOOLEAN NOT NULL DEFAULT 1,

    ActiveFlag BOOLEAN NOT NULL DEFAULT 1,

    PurchasingWebServiceURL VARCHAR(1024) NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Purchasing_ProductVendor (
    ProductID INT NOT NULL,

    BusinessEntityID INT NOT NULL,

    AverageLeadTime INT NOT NULL,

    StandardPrice DECIMAL(19,4) NOT NULL,

    LastReceiptCost DECIMAL(19,4) NULL,

    LastReceiptDate DATETIME NULL,

    MinOrderQty INT NOT NULL,

    MaxOrderQty INT NOT NULL,

    OnOrderQty INT NULL,

    UnitMeasureCode CHAR(3) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        ProductID,
        BusinessEntityID
    )
);

CREATE TABLE Purchasing_PurchaseOrderHeader (
    PurchaseOrderID INT AUTO_INCREMENT PRIMARY KEY,

    RevisionNumber TINYINT NOT NULL DEFAULT 0,

    Status TINYINT NOT NULL DEFAULT 1,

    EmployeeID INT NOT NULL,

    VendorID INT NOT NULL,

    ShipMethodID INT NOT NULL,

    OrderDate DATETIME NOT NULL,

    ShipDate DATETIME NULL,

    SubTotal DECIMAL(19,4) NOT NULL DEFAULT 0,

    TaxAmt DECIMAL(19,4) NOT NULL DEFAULT 0,

    Freight DECIMAL(19,4) NOT NULL DEFAULT 0,

    TotalDue DECIMAL(19,4)
    GENERATED ALWAYS AS (
        SubTotal + TaxAmt + Freight
    ) STORED,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Purchasing_PurchaseOrderDetail (
    PurchaseOrderID INT NOT NULL,

    PurchaseOrderDetailID INT NOT NULL,

    DueDate DATETIME NOT NULL,

    OrderQty SMALLINT NOT NULL,

    ProductID INT NOT NULL,

    UnitPrice DECIMAL(19,4) NOT NULL,

    LineTotal DECIMAL(19,4)
    GENERATED ALWAYS AS (
        OrderQty * UnitPrice
    ) STORED,

    ReceivedQty DECIMAL(8,2) NOT NULL,

    RejectedQty DECIMAL(8,2) NOT NULL,

    StockedQty DECIMAL(9,2)
    GENERATED ALWAYS AS (
        ReceivedQty - RejectedQty
    ) STORED,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        PurchaseOrderID,
        PurchaseOrderDetailID
    )
);

CREATE TABLE Sales_SalesTerritory (
    TerritoryID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    CountryRegionCode VARCHAR(3) NOT NULL,

    `Group` VARCHAR(50) NOT NULL,

    SalesYTD DECIMAL(19,4) NOT NULL DEFAULT 0,

    SalesLastYear DECIMAL(19,4) NOT NULL DEFAULT 0,

    CostYTD DECIMAL(19,4) NOT NULL DEFAULT 0,

    CostLastYear DECIMAL(19,4) NOT NULL DEFAULT 0,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_Currency (
    CurrencyCode CHAR(3) PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_CountryRegionCurrency (
    CountryRegionCode VARCHAR(3) NOT NULL,

    CurrencyCode CHAR(3) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        CountryRegionCode,
        CurrencyCode
    )
);

CREATE TABLE Sales_CreditCard (
    CreditCardID INT AUTO_INCREMENT PRIMARY KEY,

    CardType VARCHAR(50) NOT NULL,

    CardNumber VARCHAR(25) NOT NULL,

    ExpMonth TINYINT NOT NULL,

    ExpYear SMALLINT NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SpecialOffer (
    SpecialOfferID INT AUTO_INCREMENT PRIMARY KEY,

    Description VARCHAR(255) NOT NULL,

    DiscountPct DECIMAL(10,4) NOT NULL DEFAULT 0,

    Type VARCHAR(50) NOT NULL,

    Category VARCHAR(50) NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NOT NULL,

    MinQty INT NOT NULL,

    MaxQty INT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SalesReason (
    SalesReasonID INT AUTO_INCREMENT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    ReasonType VARCHAR(50) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,

    PersonID INT NULL,

    StoreID INT NULL,

    TerritoryID INT NULL,

    AccountNumber VARCHAR(20) NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);
UPDATE Sales_Customer
SET AccountNumber = CONCAT('AW', LPAD(CustomerID, 6, '0'));
SET SQL_SAFE_UPDATES = 1;

CREATE TABLE Sales_PersonCreditCard (
    BusinessEntityID INT NOT NULL,

    CreditCardID INT NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        CreditCardID
    )
);

CREATE TABLE Sales_SpecialOfferProduct (
    SpecialOfferID INT NOT NULL,

    ProductID INT NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        SpecialOfferID,
        ProductID
    )
);

CREATE TABLE Sales_CurrencyRate (
    CurrencyRateID INT AUTO_INCREMENT PRIMARY KEY,

    CurrencyRateDate DATETIME NOT NULL,

    FromCurrencyCode CHAR(3) NOT NULL,

    ToCurrencyCode CHAR(3) NOT NULL,

    AverageRate DECIMAL(19,4) NOT NULL,

    EndOfDayRate DECIMAL(19,4) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_Store (
    BusinessEntityID INT PRIMARY KEY,

    Name VARCHAR(50) NOT NULL,

    SalesPersonID INT NULL,

    Demographics LONGTEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SalesPerson (
    BusinessEntityID INT PRIMARY KEY,

    TerritoryID INT NULL,

    SalesQuota DECIMAL(19,4) NULL,

    Bonus DECIMAL(19,4) NOT NULL DEFAULT 0,

    CommissionPct DECIMAL(10,4) NOT NULL DEFAULT 0,

    SalesYTD DECIMAL(19,4) NOT NULL DEFAULT 0,

    SalesLastYear DECIMAL(19,4) NOT NULL DEFAULT 0,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SalesPersonQuotaHistory (
    BusinessEntityID INT NOT NULL,

    QuotaDate DATETIME NOT NULL,

    SalesQuota DECIMAL(19,4) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        QuotaDate
    )
);

CREATE TABLE Sales_SalesTerritoryHistory (
    BusinessEntityID INT NOT NULL,

    TerritoryID INT NOT NULL,

    StartDate DATETIME NOT NULL,

    EndDate DATETIME NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        BusinessEntityID,
        TerritoryID,
        StartDate
    )
);

CREATE TABLE Sales_SalesOrderHeader (
    SalesOrderID INT AUTO_INCREMENT PRIMARY KEY,

    RevisionNumber TINYINT NOT NULL DEFAULT 0,

    OrderDate DATETIME NOT NULL,

    DueDate DATETIME NOT NULL,

    ShipDate DATETIME NULL,

    Status TINYINT NOT NULL DEFAULT 1,

    OnlineOrderFlag BOOLEAN NOT NULL DEFAULT 1,

    SalesOrderNumber VARCHAR(25) NULL,

    PurchaseOrderNumber VARCHAR(25) NULL,

    AccountNumber VARCHAR(20) NULL,

    CustomerID INT NOT NULL,

    SalesPersonID INT NULL,

    TerritoryID INT NULL,

    BillToAddressID INT NOT NULL,

    ShipToAddressID INT NOT NULL,

    ShipMethodID INT NOT NULL,

    CreditCardID INT NULL,

    CreditCardApprovalCode VARCHAR(15) NULL,

    CurrencyRateID INT NULL,

    SubTotal DECIMAL(19,4) NOT NULL DEFAULT 0,

    TaxAmt DECIMAL(19,4) NOT NULL DEFAULT 0,

    Freight DECIMAL(19,4) NOT NULL DEFAULT 0,

    TotalDue DECIMAL(19,4) NULL,

    Comment LONGTEXT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SalesOrderDetail (
    SalesOrderID INT NOT NULL,

    SalesOrderDetailID INT NOT NULL,

    CarrierTrackingNumber VARCHAR(25) NULL,

    OrderQty SMALLINT NOT NULL,

    ProductID INT NOT NULL,

    SpecialOfferID INT NOT NULL,

    UnitPrice DECIMAL(19,4) NOT NULL,

    UnitPriceDiscount DECIMAL(19,4) NOT NULL DEFAULT 0,

    LineTotal DECIMAL(19,4) NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        SalesOrderID,
        SalesOrderDetailID
    )
);

CREATE TABLE Sales_SalesOrderHeaderSalesReason (
    SalesOrderID INT NOT NULL,

    SalesReasonID INT NOT NULL,

    ModifiedDate DATETIME NOT NULL,

    PRIMARY KEY (
        SalesOrderID,
        SalesReasonID
    )
);

CREATE TABLE Sales_ShoppingCartItem (
    ShoppingCartItemID INT AUTO_INCREMENT PRIMARY KEY,

    ShoppingCartID VARCHAR(50) NOT NULL,

    Quantity INT NOT NULL DEFAULT 1,

    ProductID INT NOT NULL,

    DateCreated DATETIME NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

CREATE TABLE Sales_SalesTaxRate (
    SalesTaxRateID INT AUTO_INCREMENT PRIMARY KEY,

    StateProvinceID INT NOT NULL,

    TaxType TINYINT NOT NULL,

    TaxRate DECIMAL(10,4) NOT NULL,

    Name VARCHAR(50) NOT NULL,

    rowguid CHAR(36) NOT NULL,

    ModifiedDate DATETIME NOT NULL
);

ALTER TABLE Person_StateProvince
ADD CONSTRAINT FK_StateProvince_CountryRegion
FOREIGN KEY (CountryRegionCode)
REFERENCES Person_CountryRegion(CountryRegionCode);

ALTER TABLE Person_Address
ADD CONSTRAINT FK_Address_StateProvince
FOREIGN KEY (StateProvinceID)
REFERENCES Person_StateProvince(StateProvinceID);

ALTER TABLE Person_Person
ADD CONSTRAINT FK_Person_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Person_EmailAddress
ADD CONSTRAINT FK_EmailAddress_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Person_PersonPhone
ADD CONSTRAINT FK_PersonPhone_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Person_PersonPhone
ADD CONSTRAINT FK_PersonPhone_PhoneNumberType
FOREIGN KEY (PhoneNumberTypeID)
REFERENCES Person_PhoneNumberType(PhoneNumberTypeID);

ALTER TABLE Person_BusinessEntityAddress
ADD CONSTRAINT FK_BusinessEntityAddress_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Person_BusinessEntityAddress
ADD CONSTRAINT FK_BusinessEntityAddress_Address
FOREIGN KEY (AddressID)
REFERENCES Person_Address(AddressID);

ALTER TABLE Person_BusinessEntityAddress
ADD CONSTRAINT FK_BusinessEntityAddress_AddressType
FOREIGN KEY (AddressTypeID)
REFERENCES Person_AddressType(AddressTypeID);

ALTER TABLE Person_BusinessEntityContact
ADD CONSTRAINT FK_BusinessEntityContact_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Person_BusinessEntityContact
ADD CONSTRAINT FK_BusinessEntityContact_Person
FOREIGN KEY (PersonID)
REFERENCES Person_Person(BusinessEntityID);

ALTER TABLE Person_BusinessEntityContact
ADD CONSTRAINT FK_BusinessEntityContact_ContactType
FOREIGN KEY (ContactTypeID)
REFERENCES Person_ContactType(ContactTypeID);

ALTER TABLE Person_Password
ADD CONSTRAINT FK_Password_Person
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_Person(BusinessEntityID);

ALTER TABLE HumanResources_Employee
ADD CONSTRAINT FK_Employee_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE HumanResources_JobCandidate
ADD CONSTRAINT FK_JobCandidate_Employee
FOREIGN KEY (BusinessEntityID)
REFERENCES HumanResources_Employee(BusinessEntityID);

ALTER TABLE HumanResources_EmployeeDepartmentHistory
ADD CONSTRAINT FK_EmployeeDepartmentHistory_Employee
FOREIGN KEY (BusinessEntityID)
REFERENCES HumanResources_Employee(BusinessEntityID);

ALTER TABLE HumanResources_EmployeeDepartmentHistory
ADD CONSTRAINT FK_EmployeeDepartmentHistory_Department
FOREIGN KEY (DepartmentID)
REFERENCES HumanResources_Department(DepartmentID);

ALTER TABLE HumanResources_EmployeeDepartmentHistory
ADD CONSTRAINT FK_EmployeeDepartmentHistory_Shift
FOREIGN KEY (ShiftID)
REFERENCES HumanResources_Shift(ShiftID);

ALTER TABLE HumanResources_EmployeePayHistory
ADD CONSTRAINT FK_EmployeePayHistory_Employee
FOREIGN KEY (BusinessEntityID)
REFERENCES HumanResources_Employee(BusinessEntityID);

ALTER TABLE Production_ProductSubcategory
ADD CONSTRAINT FK_ProductSubcategory_ProductCategory
FOREIGN KEY (ProductCategoryID)
REFERENCES Production_ProductCategory(ProductCategoryID);

ALTER TABLE Production_ProductModelProductDescriptionCulture
ADD CONSTRAINT FK_PMPDC_ProductModel
FOREIGN KEY (ProductModelID)
REFERENCES Production_ProductModel(ProductModelID);

ALTER TABLE Production_ProductModelProductDescriptionCulture
ADD CONSTRAINT FK_PMPDC_ProductDescription
FOREIGN KEY (ProductDescriptionID)
REFERENCES Production_ProductDescription(ProductDescriptionID);

ALTER TABLE Production_ProductModelProductDescriptionCulture
ADD CONSTRAINT FK_PMPDC_Culture
FOREIGN KEY (CultureID)
REFERENCES Production_Culture(CultureID);

ALTER TABLE Production_Product
ADD CONSTRAINT FK_Product_ProductSubcategory
FOREIGN KEY (ProductSubcategoryID)
REFERENCES Production_ProductSubcategory(ProductSubcategoryID);

ALTER TABLE Production_Product
ADD CONSTRAINT FK_Product_ProductModel
FOREIGN KEY (ProductModelID)
REFERENCES Production_ProductModel(ProductModelID);

ALTER TABLE Production_Product
ADD CONSTRAINT FK_Product_SizeUnitMeasure
FOREIGN KEY (SizeUnitMeasureCode)
REFERENCES Production_UnitMeasure(UnitMeasureCode);

ALTER TABLE Production_Product
ADD CONSTRAINT FK_Product_WeightUnitMeasure
FOREIGN KEY (WeightUnitMeasureCode)
REFERENCES Production_UnitMeasure(UnitMeasureCode);

ALTER TABLE Production_ProductCostHistory
ADD CONSTRAINT FK_ProductCostHistory_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_ProductListPriceHistory
ADD CONSTRAINT FK_ProductListPriceHistory_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_BillOfMaterials
ADD CONSTRAINT FK_BillOfMaterials_ProductAssembly
FOREIGN KEY (ProductAssemblyID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_BillOfMaterials
ADD CONSTRAINT FK_BillOfMaterials_Component
FOREIGN KEY (ComponentID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_BillOfMaterials
ADD CONSTRAINT FK_BillOfMaterials_UnitMeasure
FOREIGN KEY (UnitMeasureCode)
REFERENCES Production_UnitMeasure(UnitMeasureCode);

ALTER TABLE Production_ProductInventory
ADD CONSTRAINT FK_ProductInventory_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_ProductInventory
ADD CONSTRAINT FK_ProductInventory_Location
FOREIGN KEY (LocationID)
REFERENCES Production_Location(LocationID);

ALTER TABLE Production_ProductReview
ADD CONSTRAINT FK_ProductReview_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_ProductProductPhoto
ADD CONSTRAINT FK_ProductProductPhoto_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_ProductProductPhoto
ADD CONSTRAINT FK_ProductProductPhoto_ProductPhoto
FOREIGN KEY (ProductPhotoID)
REFERENCES Production_ProductPhoto(ProductPhotoID);

ALTER TABLE Production_TransactionHistory
ADD CONSTRAINT FK_TransactionHistory_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_TransactionHistoryArchive
ADD CONSTRAINT FK_TransactionHistoryArchive_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_WorkOrder
ADD CONSTRAINT FK_WorkOrder_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_WorkOrder
ADD CONSTRAINT FK_WorkOrder_ScrapReason
FOREIGN KEY (ScrapReasonID)
REFERENCES Production_ScrapReason(ScrapReasonID);

ALTER TABLE Production_WorkOrderRouting
ADD CONSTRAINT FK_WorkOrderRouting_WorkOrder
FOREIGN KEY (WorkOrderID)
REFERENCES Production_WorkOrder(WorkOrderID);

ALTER TABLE Production_WorkOrderRouting
ADD CONSTRAINT FK_WorkOrderRouting_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_WorkOrderRouting
ADD CONSTRAINT FK_WorkOrderRouting_Location
FOREIGN KEY (LocationID)
REFERENCES Production_Location(LocationID);

ALTER TABLE Production_ProductDocument
ADD CONSTRAINT FK_ProductDocument_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Production_ProductDocument
ADD CONSTRAINT FK_ProductDocument_Document
FOREIGN KEY (DocumentNode)
REFERENCES Production_Document(DocumentNode);

ALTER TABLE Production_ProductModelIllustration
ADD CONSTRAINT FK_ProductModelIllustration_ProductModel
FOREIGN KEY (ProductModelID)
REFERENCES Production_ProductModel(ProductModelID);

ALTER TABLE Production_ProductModelIllustration
ADD CONSTRAINT FK_ProductModelIllustration_Illustration
FOREIGN KEY (IllustrationID)
REFERENCES Production_Illustration(IllustrationID);

ALTER TABLE Purchasing_Vendor
ADD CONSTRAINT FK_Vendor_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Purchasing_ProductVendor
ADD CONSTRAINT FK_ProductVendor_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Purchasing_ProductVendor
ADD CONSTRAINT FK_ProductVendor_Vendor
FOREIGN KEY (BusinessEntityID)
REFERENCES Purchasing_Vendor(BusinessEntityID);

ALTER TABLE Purchasing_ProductVendor
ADD CONSTRAINT FK_ProductVendor_UnitMeasure
FOREIGN KEY (UnitMeasureCode)
REFERENCES Production_UnitMeasure(UnitMeasureCode);

ALTER TABLE Purchasing_PurchaseOrderHeader
ADD CONSTRAINT FK_PurchaseOrderHeader_Employee
FOREIGN KEY (EmployeeID)
REFERENCES HumanResources_Employee(BusinessEntityID);

ALTER TABLE Purchasing_PurchaseOrderHeader
ADD CONSTRAINT FK_PurchaseOrderHeader_Vendor
FOREIGN KEY (VendorID)
REFERENCES Purchasing_Vendor(BusinessEntityID);

ALTER TABLE Purchasing_PurchaseOrderHeader
ADD CONSTRAINT FK_PurchaseOrderHeader_ShipMethod
FOREIGN KEY (ShipMethodID)
REFERENCES Purchasing_ShipMethod(ShipMethodID);

ALTER TABLE Purchasing_PurchaseOrderDetail
ADD CONSTRAINT FK_PurchaseOrderDetail_Header
FOREIGN KEY (PurchaseOrderID)
REFERENCES Purchasing_PurchaseOrderHeader(PurchaseOrderID);

ALTER TABLE Purchasing_PurchaseOrderDetail
ADD CONSTRAINT FK_PurchaseOrderDetail_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

--

ALTER TABLE Sales_CountryRegionCurrency
ADD CONSTRAINT FK_CountryRegionCurrency_CountryRegion
FOREIGN KEY (CountryRegionCode)
REFERENCES Person_CountryRegion(CountryRegionCode);

ALTER TABLE Sales_CountryRegionCurrency
ADD CONSTRAINT FK_CountryRegionCurrency_Currency
FOREIGN KEY (CurrencyCode)
REFERENCES Sales_Currency(CurrencyCode);

ALTER TABLE Sales_Customer
ADD CONSTRAINT FK_Customer_Person
FOREIGN KEY (PersonID)
REFERENCES Person_Person(BusinessEntityID);

ALTER TABLE Sales_Customer
ADD CONSTRAINT FK_Customer_Territory
FOREIGN KEY (TerritoryID)
REFERENCES Sales_SalesTerritory(TerritoryID);

ALTER TABLE Sales_PersonCreditCard
ADD CONSTRAINT FK_PersonCreditCard_Person
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_Person(BusinessEntityID);

ALTER TABLE Sales_PersonCreditCard
ADD CONSTRAINT FK_PersonCreditCard_CreditCard
FOREIGN KEY (CreditCardID)
REFERENCES Sales_CreditCard(CreditCardID);

ALTER TABLE Sales_SpecialOfferProduct
ADD CONSTRAINT FK_SpecialOfferProduct_SpecialOffer
FOREIGN KEY (SpecialOfferID)
REFERENCES Sales_SpecialOffer(SpecialOfferID);

ALTER TABLE Sales_SpecialOfferProduct
ADD CONSTRAINT FK_SpecialOfferProduct_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

ALTER TABLE Sales_CurrencyRate
ADD CONSTRAINT FK_CurrencyRate_FromCurrency
FOREIGN KEY (FromCurrencyCode)
REFERENCES Sales_Currency(CurrencyCode);

ALTER TABLE Sales_CurrencyRate
ADD CONSTRAINT FK_CurrencyRate_ToCurrency
FOREIGN KEY (ToCurrencyCode)
REFERENCES Sales_Currency(CurrencyCode);

ALTER TABLE Sales_Store
ADD CONSTRAINT FK_Store_BusinessEntity
FOREIGN KEY (BusinessEntityID)
REFERENCES Person_BusinessEntity(BusinessEntityID);

ALTER TABLE Sales_Store
ADD CONSTRAINT FK_Store_SalesPerson
FOREIGN KEY (SalesPersonID)
REFERENCES Sales_SalesPerson(BusinessEntityID);

ALTER TABLE Sales_SalesPerson
ADD CONSTRAINT FK_SalesPerson_Employee
FOREIGN KEY (BusinessEntityID)
REFERENCES HumanResources_Employee(BusinessEntityID);

ALTER TABLE Sales_SalesPerson
ADD CONSTRAINT FK_SalesPerson_Territory
FOREIGN KEY (TerritoryID)
REFERENCES Sales_SalesTerritory(TerritoryID);

--

-- 15. Sales_SalesPersonQuotaHistory → SalesPerson

ALTER TABLE Sales_SalesPersonQuotaHistory
ADD CONSTRAINT FK_SalesPersonQuotaHistory_SalesPerson
FOREIGN KEY (BusinessEntityID)
REFERENCES Sales_SalesPerson(BusinessEntityID);

-- 16. Sales_SalesTerritoryHistory → SalesPerson

ALTER TABLE Sales_SalesTerritoryHistory
ADD CONSTRAINT FK_SalesTerritoryHistory_SalesPerson
FOREIGN KEY (BusinessEntityID)
REFERENCES Sales_SalesPerson(BusinessEntityID);

-- 17. Sales_SalesTerritoryHistory → SalesTerritory

ALTER TABLE Sales_SalesTerritoryHistory
ADD CONSTRAINT FK_SalesTerritoryHistory_Territory
FOREIGN KEY (TerritoryID)
REFERENCES Sales_SalesTerritory(TerritoryID);

-- 18. Sales_SalesOrderHeader → Customer

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_Customer
FOREIGN KEY (CustomerID)
REFERENCES Sales_Customer(CustomerID);

-- 19. Sales_SalesOrderHeader → SalesPerson

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_SalesPerson
FOREIGN KEY (SalesPersonID)
REFERENCES Sales_SalesPerson(BusinessEntityID);

-- 20. Sales_SalesOrderHeader → Territory

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_Territory
FOREIGN KEY (TerritoryID)
REFERENCES Sales_SalesTerritory(TerritoryID);

-- 21. Sales_SalesOrderHeader → BillToAddress

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_BillToAddress
FOREIGN KEY (BillToAddressID)
REFERENCES Person_Address(AddressID);

-- 22. Sales_SalesOrderHeader → ShipToAddress

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_ShipToAddress
FOREIGN KEY (ShipToAddressID)
REFERENCES Person_Address(AddressID);

-- 23. Sales_SalesOrderHeader → ShipMethod

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_ShipMethod
FOREIGN KEY (ShipMethodID)
REFERENCES Purchasing_ShipMethod(ShipMethodID);

-- 24. Sales_SalesOrderHeader → CreditCard

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_CreditCard
FOREIGN KEY (CreditCardID)
REFERENCES Sales_CreditCard(CreditCardID);

-- 25. Sales_SalesOrderHeader → CurrencyRate

ALTER TABLE Sales_SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_CurrencyRate
FOREIGN KEY (CurrencyRateID)
REFERENCES Sales_CurrencyRate(CurrencyRateID);

-- 26. Sales_SalesOrderDetail → SalesOrderHeader

ALTER TABLE Sales_SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_Header
FOREIGN KEY (SalesOrderID)
REFERENCES Sales_SalesOrderHeader(SalesOrderID);

-- 27. Sales_SalesOrderDetail → Product

ALTER TABLE Sales_SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

-- 28. Sales_SalesOrderDetail → SpecialOfferProduct

ALTER TABLE Sales_SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_SpecialOfferProduct
FOREIGN KEY (SpecialOfferID, ProductID)
REFERENCES Sales_SpecialOfferProduct(SpecialOfferID, ProductID);

-- 29. Sales_SalesOrderHeaderSalesReason → SalesOrderHeader

ALTER TABLE Sales_SalesOrderHeaderSalesReason
ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_Header
FOREIGN KEY (SalesOrderID)
REFERENCES Sales_SalesOrderHeader(SalesOrderID);

-- 30. Sales_SalesOrderHeaderSalesReason → SalesReason

ALTER TABLE Sales_SalesOrderHeaderSalesReason
ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_Reason
FOREIGN KEY (SalesReasonID)
REFERENCES Sales_SalesReason(SalesReasonID);

-- 31. Sales_ShoppingCartItem → Product

ALTER TABLE Sales_ShoppingCartItem
ADD CONSTRAINT FK_ShoppingCartItem_Product
FOREIGN KEY (ProductID)
REFERENCES Production_Product(ProductID);

-- 32. Sales_SalesTaxRate → StateProvince

ALTER TABLE Sales_SalesTaxRate
ADD CONSTRAINT FK_SalesTaxRate_StateProvince
FOREIGN KEY (StateProvinceID)
REFERENCES Person_StateProvince(StateProvinceID);


SELECT table_name
FROM information_schema.tables t
WHERE table_schema = DATABASE()
AND table_type = 'BASE TABLE'
AND table_name NOT IN (
    SELECT DISTINCT table_name
    FROM information_schema.table_constraints
    WHERE constraint_type = 'PRIMARY KEY'
    AND table_schema = DATABASE()
);

SELECT
    SUBSTRING_INDEX(table_name, '_', 1) AS schema_name,
    COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = DATABASE()
GROUP BY schema_name
ORDER BY schema_name;

SET FOREIGN_KEY_CHECKS = 0;

SELECT * FROM Person_BusinessEntity;  SELECT COUNT(*) FROM Person_BusinessEntity;

SELECT * FROM Person_AddressType;

SELECT * FROM Person_ContactType;

SELECT * FROM Person_CountryRegion;

SELECT * FROM Person_StateProvince;  SELECT COUNT(*) FROM Person_StateProvince;

SELECT * FROM Person_Address; SELECT COUNT(*) FROM Person_Address;   TRUNCATE TABLE Person_Address;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.Address.csv'
INTO TABLE Person_Address
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_PhoneNumberType;

SELECT * FROM Person_Person;  SELECT COUNT(*) FROM Person_Person;   TRUNCATE TABLE Person_Person;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.Person.csv'
INTO TABLE Person_Person
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_EmailAddress;   TRUNCATE TABLE Person_EmailAddress;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.EmailAddress.csv'
INTO TABLE Person_EmailAddress
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_PersonPhone;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.PersonPhone.csv'
INTO TABLE Person_PersonPhone
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_BusinessEntityAddress;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.BusinessEntityAddress.csv'
INTO TABLE Person_BusinessEntityAddress
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_BusinessEntityContact;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.BusinessEntityContact.csv'
INTO TABLE Person_BusinessEntityContact
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Person_Password;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Person.Password.csv'
INTO TABLE Person_Password
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;



SELECT * FROM HumanResources_Department;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.Department.csv'
INTO TABLE HumanResources_Department
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM HumanResources_Shift;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.Shift.csv'
INTO TABLE HumanResources_Shift
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM HumanResources_Employee;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.Employee.csv'
INTO TABLE HumanResources_Employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM HumanResources_EmployeeDepartmentHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.EmployeeDepartmentHistory.csv'
INTO TABLE HumanResources_EmployeeDepartmentHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM HumanResources_EmployeePayHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.EmployeePayHistory.csv'
INTO TABLE HumanResources_EmployeePayHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM HumanResources_JobCandidate;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HumanResources.JobCandidate.csv'
INTO TABLE HumanResources_JobCandidate
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- ============================================
-- PRODUCTION
-- ============================================

SELECT * FROM Production_UnitMeasure;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.UnitMeasure.csv'
INTO TABLE Production_UnitMeasure
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_Culture;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.Culture.csv'
INTO TABLE Production_Culture
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_ProductCategory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductCategory.csv'
INTO TABLE Production_ProductCategory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductSubcategory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductSubCategory.csv'
INTO TABLE Production_ProductSubcategory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductModel;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductModel.csv'
INTO TABLE Production_ProductModel
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductDescription;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductDescription.csv'
INTO TABLE Production_ProductDescription
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductModelProductDescriptionCulture;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductModelProductDescriptionCulture.csv'
INTO TABLE Production_ProductModelProductDescriptionCulture
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductPhoto;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductPhoto.csv'
INTO TABLE Production_ProductPhoto
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_Illustration;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.Illustration.csv'
INTO TABLE Production_Illustration
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_Location;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.Location.csv'
INTO TABLE Production_Location
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ScrapReason;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ScrapReason.csv'
INTO TABLE Production_ScrapReason
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_Document;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.Document.csv'
INTO TABLE Production_Document
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_Product;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.Product.csv'
INTO TABLE Production_Product
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_BillOfMaterials;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.BillOfMaterials.csv'
INTO TABLE Production_BillOfMaterials
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_ProductCostHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductCostHistory.csv'
INTO TABLE Production_ProductCostHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductDocument;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductDocument.csv'
INTO TABLE Production_ProductDocument
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductInventory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductInventory;.csv'
INTO TABLE Production_ProductInventory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductListPriceHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductListPriceHistory.csv'
INTO TABLE Production_ProductListPriceHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductModelIllustration;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductModelIllustration.csv'
INTO TABLE Production_ProductModelIllustration
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_ProductProductPhoto;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductProductPhoto.csv'
INTO TABLE Production_ProductProductPhoto
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_ProductReview;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.ProductReview.csv'
INTO TABLE Production_ProductReview
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_TransactionHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.TransactionHistory.csv'
INTO TABLE Production_TransactionHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_TransactionHistoryArchive;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.TransactionHistoryArchive;.csv'
INTO TABLE Production_TransactionHistoryArchive
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Production_WorkOrder;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.WorkOrder.csv'
INTO TABLE Production_WorkOrder
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Production_WorkOrderRouting;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Production.WorkOrderRouting.csv'
INTO TABLE  Production_WorkOrderRouting
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;



SELECT * FROM Purchasing_ShipMethod;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Purchasing.ShipMethod.csv'
INTO TABLE Purchasing_ShipMethod
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Purchasing_Vendor;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Purchasing.Vendor.csv'
INTO TABLE Purchasing_Vendor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Purchasing_ProductVendor;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Purchasing.ProductVendor.csv'
INTO TABLE Purchasing_ProductVendor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Purchasing_PurchaseOrderHeader;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Purchasing.PurchaseOrderHeader.csv'
INTO TABLE Purchasing_PurchaseOrderHeader
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Purchasing_PurchaseOrderDetail;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Purchasing.PurchaseOrderDetail.csv'
INTO TABLE Purchasing_PurchaseOrderDetail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_Currency;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.Currency.csv'
INTO TABLE Sales_Currency
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_CreditCard; select count(*) from Sales_CreditCard;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.CreditCard.csv'
INTO TABLE Sales_CreditCard
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesReason;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesReason.csv'
INTO TABLE  Sales_SalesReason
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesTerritory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesTerritory.csv'
INTO TABLE  Sales_SalesTerritory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SpecialOffer;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SpecialOffer.csv'
INTO TABLE  Sales_SpecialOffer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_CountryRegionCurrency;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.CountryRegionCurrency.csv'
INTO TABLE  Sales_CountryRegionCurrency
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_Customer;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.Customer.csv'
INTO TABLE  Sales_Customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_CurrencyRate;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.CurrencyRate.csv'
INTO TABLE  Sales_CurrencyRate
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_PersonCreditCard;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.PersonCreditCard.csv'
INTO TABLE  Sales_PersonCreditCard
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesPerson;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesPerson.csv'
INTO TABLE  Sales_SalesPerson
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


SELECT * FROM Sales_Store;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.Store.csv'
INTO TABLE  Sales_Store
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesPersonQuotaHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesPersonQuotaHistory.csv'
INTO TABLE  Sales_SalesPersonQuotaHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesTerritoryHistory;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesTerritoryHistory.csv'
INTO TABLE  Sales_SalesTerritoryHistory
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SpecialOfferProduct;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SpecialOfferProduct.csv'
INTO TABLE  Sales_SpecialOfferProduct
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesTaxRate;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesTaxRate.csv'
INTO TABLE  Sales_SalesTaxRate
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_SalesOrderHeader;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesOrderHeader.csv'
INTO TABLE  Sales_SalesOrderHeader
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-------------------------------------


SELECT * FROM Sales_SalesOrderDetail;  TRUNCATE TABLE Sales_SalesOrderDetail;

ALTER TABLE Sales_SalesOrderDetail 
MODIFY COLUMN LineTotal DECIMAL(25,8);

DESCRIBE Sales_SalesOrderDetail;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesOrderDetail.csv'
INTO TABLE Sales_SalesOrderDetail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

--------------------------------------
SELECT * FROM Sales_SalesOrderHeaderSalesReason;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.SalesOrderHeaderSalesReason.csv'
INTO TABLE Sales_SalesOrderHeaderSalesReason
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM Sales_ShoppingCartItem;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales.ShoppingCartItem.csv'
INTO TABLE Sales_ShoppingCartItem
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

------------------------
SET SESSION group_concat_max_len = 1000000; 
-- This boosts the limit to 1 million characters

SELECT 
    GROUP_CONCAT(
        CONCAT('SELECT "', TABLE_NAME, '" AS table_name, COUNT(*) AS exact_row_count FROM `', TABLE_NAME, '`') 
        SEPARATOR ' UNION ALL '
    ) INTO @sql
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_SCHEMA = 'adventureworks2025' 
    AND TABLE_TYPE = 'BASE TABLE';
    
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    DATA_TYPE, 
    COLUMN_TYPE, -- Shows full detail like decimal(19,4)
    IS_NULLABLE,
    COLUMN_KEY -- Shows if it's a Primary or Foreign Key
FROM 
    information_schema.COLUMNS 
WHERE 
    TABLE_SCHEMA = 'adventureworks2025' 
ORDER BY 
    TABLE_NAME, ORDINAL_POSITION;
USE adventureworks2025;

SELECT COUNT(*) AS MySQLCount
FROM sales_salesorderdetail;


SELECT 'person_address', COUNT(*) FROM person_address
UNION ALL
SELECT 'person_businessentity', COUNT(*) FROM person_businessentity
UNION ALL
SELECT 'person_emailaddress', COUNT(*) FROM person_emailaddress
UNION ALL
SELECT 'person_password', COUNT(*) FROM person_password
UNION ALL
SELECT 'person_person', COUNT(*) FROM person_person
UNION ALL
SELECT 'person_personphone', COUNT(*) FROM person_personphone
UNION ALL
SELECT 'production_productphoto', COUNT(*) FROM production_productphoto
UNION ALL
SELECT 'production_transactionhistory', COUNT(*) FROM production_transactionhistory
UNION ALL
SELECT 'production_transactionhistoryarchive', COUNT(*) FROM production_transactionhistoryarchive
UNION ALL
SELECT 'production_workorder', COUNT(*) FROM production_workorder
UNION ALL
SELECT 'production_workorderrouting', COUNT(*) FROM production_workorderrouting
UNION ALL
SELECT 'purchasing_purchaseorderdetail', COUNT(*) FROM purchasing_purchaseorderdetail
UNION ALL
SELECT 'purchasing_purchaseorderheader', COUNT(*) FROM purchasing_purchaseorderheader
UNION ALL
SELECT 'sales_creditcard', COUNT(*) FROM sales_creditcard
UNION ALL
SELECT 'sales_currencyrate', COUNT(*) FROM sales_currencyrate
UNION ALL
SELECT 'sales_customer', COUNT(*) FROM sales_customer
UNION ALL
SELECT 'sales_personcreditcard', COUNT(*) FROM sales_personcreditcard
UNION ALL
SELECT 'sales_salesorderheader', COUNT(*) FROM sales_salesorderheader
UNION ALL
SELECT 'sales_salesorderheadersalesreason', COUNT(*) FROM sales_salesorderheadersalesreason
UNION ALL
SELECT 'sales_store', COUNT(*) FROM sales_store;


--- primary key
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'adventureworks2025'
AND CONSTRAINT_NAME = 'PRIMARY'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

--AUTO_INCREMENT vs IDENTITY values

SELECT 
    TABLE_NAME,
    AUTO_INCREMENT
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
AND AUTO_INCREMENT IS NOT NULL
ORDER BY TABLE_NAME;

SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;


SELECT 
    ROUTINE_TYPE,
    ROUTINE_SCHEMA,
    ROUTINE_NAME
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
ORDER BY ROUTINE_TYPE, ROUTINE_SCHEMA, ROUTINE_NAME;

------- procedure

DELIMITER $$

CREATE FUNCTION ufnLeadingZeros (
    p_Value INT
)
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    RETURN LPAD(CAST(p_Value AS CHAR), 8, '0');
END $$

DELIMITER ;
SELECT ufnLeadingZeros(123);



DELIMITER $$

CREATE FUNCTION ufnGetAccountingEndDate()
RETURNS DATETIME
DETERMINISTIC
BEGIN
    RETURN DATE_SUB(
        STR_TO_DATE('20040701', '%Y%m%d'),
        INTERVAL 2 MICROSECOND
    );
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnGetAccountingStartDate()
RETURNS DATETIME
DETERMINISTIC
BEGIN
    RETURN STR_TO_DATE('20030701', '%Y%m%d');
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnLeadingZeros(ValueInt INT)
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    RETURN LPAD(ValueInt, 8, '0');
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnGetDocumentStatusText(StatusValue TINYINT)
RETURNS VARCHAR(15)
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

DELIMITER $$

CREATE FUNCTION ufnGetPurchaseOrderStatusText(StatusValue TINYINT)
RETURNS VARCHAR(15)
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

DELIMITER $$

CREATE FUNCTION ufnGetSalesOrderStatusText(StatusValue TINYINT)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
    DECLARE ret VARCHAR(15);

    SET ret =
        CASE StatusValue
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

DELIMITER $$

CREATE FUNCTION ufnGetStock(ProductIDParam INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ret INT;

    SELECT SUM(p.Quantity)
    INTO ret
    FROM production_productinventory p
    WHERE p.ProductID = ProductIDParam
      AND p.LocationID = 6;

    IF ret IS NULL THEN
        SET ret = 0;
    END IF;

    RETURN ret;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnGetDocumentStatusText(StatusValue TINYINT)
RETURNS VARCHAR(16)
DETERMINISTIC
BEGIN
    DECLARE ret VARCHAR(16);

    SET ret =
        CASE StatusValue
            WHEN 1 THEN 'Pending approval'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Obsolete'
            ELSE '** Invalid **'
        END;

    RETURN ret;
END$$

DELIMITER ;


DELIMITER $$

CREATE FUNCTION ufnGetProductDealerPrice(
    ProductIDParam INT,
    OrderDateParam DATETIME
)
RETURNS DECIMAL(19,4)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE DealerPrice DECIMAL(19,4);
    DECLARE DealerDiscount DECIMAL(5,2);

    SET DealerDiscount = 0.60;

    SELECT plph.ListPrice * DealerDiscount
    INTO DealerPrice
    FROM production_product p
    INNER JOIN production_productlistpricehistory plph
        ON p.ProductID = plph.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN plph.StartDate
      AND COALESCE(
            plph.EndDate,
            STR_TO_DATE('99991231', '%Y%m%d')
      )
    LIMIT 1;

    RETURN DealerPrice;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnGetProductListPrice(
    ProductIDParam INT,
    OrderDateParam DATETIME
)
RETURNS DECIMAL(19,4)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE ListPrice DECIMAL(19,4);

    SELECT plph.ListPrice
    INTO ListPrice
    FROM production_product p
    INNER JOIN production_productlistpricehistory plph
        ON p.ProductID = plph.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN plph.StartDate
      AND COALESCE(
            plph.EndDate,
            STR_TO_DATE('99991231', '%Y%m%d')
      )
    LIMIT 1;

    RETURN ListPrice;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION ufnGetProductStandardCost(
    ProductIDParam INT,
    OrderDateParam DATETIME
)
RETURNS DECIMAL(19,4)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE StandardCost DECIMAL(19,4);

    SELECT pch.StandardCost
    INTO StandardCost
    FROM production_product p
    INNER JOIN production_productcosthistory pch
        ON p.ProductID = pch.ProductID
    WHERE p.ProductID = ProductIDParam
      AND OrderDateParam BETWEEN pch.StartDate
      AND COALESCE(
            pch.EndDate,
            STR_TO_DATE('99991231', '%Y%m%d')
      )
    LIMIT 1;

    RETURN StandardCost;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE uspGetContactInformation(IN PersonIDParam INT)
BEGIN

    -- Employee
    SELECT
        PersonIDParam AS PersonID,
        p.FirstName,
        p.LastName,
        e.JobTitle,
        'Employee' AS BusinessEntityType
    FROM humanresources_employee e
    INNER JOIN person_person p
        ON p.BusinessEntityID = e.BusinessEntityID
    WHERE e.BusinessEntityID = PersonIDParam

    UNION ALL

    -- Vendor Contact
    SELECT
        PersonIDParam AS PersonID,
        p.FirstName,
        p.LastName,
        ct.Name AS JobTitle,
        'Vendor Contact' AS BusinessEntityType
    FROM purchasing_vendor v
    INNER JOIN person_businessentitycontact bec
        ON bec.BusinessEntityID = v.BusinessEntityID
    INNER JOIN person_contacttype ct
        ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN person_person p
        ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = PersonIDParam

    UNION ALL

    -- Store Contact
    SELECT
        PersonIDParam AS PersonID,
        p.FirstName,
        p.LastName,
        ct.Name AS JobTitle,
        'Store Contact' AS BusinessEntityType
    FROM sales_store s
    INNER JOIN person_businessentitycontact bec
        ON bec.BusinessEntityID = s.BusinessEntityID
    INNER JOIN person_contacttype ct
        ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN person_person p
        ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = PersonIDParam

    UNION ALL

    -- Consumer
    SELECT
        PersonIDParam AS PersonID,
        p.FirstName,
        p.LastName,
        NULL AS JobTitle,
        'Consumer' AS BusinessEntityType
    FROM person_person p
    INNER JOIN sales_customer c
        ON c.PersonID = p.BusinessEntityID
    WHERE p.BusinessEntityID = PersonIDParam
      AND c.StoreID IS NULL;

END$$

DELIMITER ;

--

DELIMITER $$

CREATE PROCEDURE uspGetBillOfMaterials(
    IN StartProductIDParam INT,
    IN CheckDateParam DATETIME
)
BEGIN

    WITH RECURSIVE BOM_cte (
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        PerAssemblyQty,
        StandardCost,
        ListPrice,
        BOMLevel,
        RecursionLevel
    ) AS (

        -- Anchor query
        SELECT
            b.ProductAssemblyID,
            b.ComponentID,
            p.Name,
            b.PerAssemblyQty,
            p.StandardCost,
            p.ListPrice,
            b.BOMLevel,
            0
        FROM production_billofmaterials b
        INNER JOIN production_product p
            ON b.ComponentID = p.ProductID
        WHERE b.ProductAssemblyID = StartProductIDParam
          AND CheckDateParam >= b.StartDate
          AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)

        UNION ALL

        -- Recursive query
        SELECT
            b.ProductAssemblyID,
            b.ComponentID,
            p.Name,
            b.PerAssemblyQty,
            p.StandardCost,
            p.ListPrice,
            b.BOMLevel,
            cte.RecursionLevel + 1
        FROM BOM_cte cte
        INNER JOIN production_billofmaterials b
            ON b.ProductAssemblyID = cte.ComponentID
        INNER JOIN production_product p
            ON b.ComponentID = p.ProductID
        WHERE CheckDateParam >= b.StartDate
          AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)
          AND cte.RecursionLevel < 25
    )

    SELECT
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        SUM(PerAssemblyQty) AS TotalQuantity,
        StandardCost,
        ListPrice,
        BOMLevel,
        RecursionLevel
    FROM BOM_cte
    GROUP BY
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        BOMLevel,
        RecursionLevel,
        StandardCost,
        ListPrice
    ORDER BY
        BOMLevel,
        ProductAssemblyID,
        ComponentID;

END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE uspGetEmployeeManagers(
    IN BusinessEntityIDParam INT
)
BEGIN

    WITH RECURSIVE EMP_cte (
        BusinessEntityID,
        OrganizationNode,
        FirstName,
        LastName,
        JobTitle,
        RecursionLevel
    ) AS (

        -- Anchor member
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            e.JobTitle,
            0
        FROM humanresources_employee e
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam

        UNION ALL

        -- Recursive member
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            e.JobTitle,
            cte.RecursionLevel + 1
        FROM humanresources_employee e
        INNER JOIN EMP_cte cte
            ON e.OrganizationNode =
               SUBSTRING_INDEX(cte.OrganizationNode, '/', 
               LENGTH(cte.OrganizationNode) -
               LENGTH(REPLACE(cte.OrganizationNode, '/', '')))
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE cte.RecursionLevel < 25
    )

    SELECT
        cte.RecursionLevel,
        cte.BusinessEntityID,
        cte.FirstName,
        cte.LastName,
        cte.OrganizationNode,
        p.FirstName AS ManagerFirstName,
        p.LastName AS ManagerLastName
    FROM EMP_cte cte
    INNER JOIN humanresources_employee e
        ON e.OrganizationNode =
           SUBSTRING_INDEX(cte.OrganizationNode, '/',
           LENGTH(cte.OrganizationNode) -
           LENGTH(REPLACE(cte.OrganizationNode, '/', '')))
    INNER JOIN person_person p
        ON p.BusinessEntityID = e.BusinessEntityID
    ORDER BY
        cte.RecursionLevel,
        cte.OrganizationNode;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE uspGetManagerEmployees(
    IN BusinessEntityIDParam INT
)
BEGIN

    WITH RECURSIVE EMP_cte (
        BusinessEntityID,
        OrganizationNode,
        FirstName,
        LastName,
        RecursionLevel
    ) AS (

        -- Anchor query
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            0
        FROM humanresources_employee e
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam

        UNION ALL

        -- Recursive query
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            cte.RecursionLevel + 1
        FROM humanresources_employee e
        INNER JOIN EMP_cte cte
            ON SUBSTRING_INDEX(e.OrganizationNode, '/', -1) =
               SUBSTRING_INDEX(cte.OrganizationNode, '/', -1)
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE cte.RecursionLevel < 25
    )

    SELECT
        cte.RecursionLevel,
        cte.OrganizationNode,
        p.FirstName AS ManagerFirstName,
        p.LastName AS ManagerLastName,
        cte.BusinessEntityID,
        cte.FirstName,
        cte.LastName
    FROM EMP_cte cte
    INNER JOIN humanresources_employee e
        ON SUBSTRING_INDEX(cte.OrganizationNode, '/', -1) =
           SUBSTRING_INDEX(e.OrganizationNode, '/', -1)
    INNER JOIN person_person p
        ON p.BusinessEntityID = e.BusinessEntityID
    ORDER BY
        cte.RecursionLevel,
        cte.OrganizationNode;

END$$

DELIMITER ;

CALL uspGetManagerEmployees(1);

DELIMITER $$

CREATE PROCEDURE uspGetWhereUsedProductID(
    IN StartProductIDParam INT,
    IN CheckDateParam DATETIME
)
BEGIN

    WITH RECURSIVE BOM_cte (
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        PerAssemblyQty,
        StandardCost,
        ListPrice,
        BOMLevel,
        RecursionLevel
    ) AS (

        -- Anchor query
        SELECT
            b.ProductAssemblyID,
            b.ComponentID,
            p.Name,
            b.PerAssemblyQty,
            p.StandardCost,
            p.ListPrice,
            b.BOMLevel,
            0
        FROM production_billofmaterials b
        INNER JOIN production_product p
            ON b.ProductAssemblyID = p.ProductID
        WHERE b.ComponentID = StartProductIDParam
          AND CheckDateParam >= b.StartDate
          AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)

        UNION ALL

        -- Recursive query
        SELECT
            b.ProductAssemblyID,
            b.ComponentID,
            p.Name,
            b.PerAssemblyQty,
            p.StandardCost,
            p.ListPrice,
            b.BOMLevel,
            cte.RecursionLevel + 1
        FROM BOM_cte cte
        INNER JOIN production_billofmaterials b
            ON cte.ProductAssemblyID = b.ComponentID
        INNER JOIN production_product p
            ON b.ProductAssemblyID = p.ProductID
        WHERE CheckDateParam >= b.StartDate
          AND CheckDateParam <= COALESCE(b.EndDate, CheckDateParam)
          AND cte.RecursionLevel < 25
    )

    SELECT
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        SUM(PerAssemblyQty) AS TotalQuantity,
        StandardCost,
        ListPrice,
        BOMLevel,
        RecursionLevel
    FROM BOM_cte
    GROUP BY
        ProductAssemblyID,
        ComponentID,
        ComponentDesc,
        BOMLevel,
        RecursionLevel,
        StandardCost,
        ListPrice
    ORDER BY
        BOMLevel,
        ProductAssemblyID,
        ComponentID;

END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE uspLogError(
    OUT ErrorLogIDParam INT
)
BEGIN

    -- Default value
    SET ErrorLogIDParam = 0;

    INSERT INTO errorlog (
        UserName,
        ErrorNumber,
        ErrorSeverity,
        ErrorState,
        ErrorProcedure,
        ErrorLine,
        ErrorMessage
    )
    VALUES (
        CURRENT_USER(),
        NULL,
        NULL,
        NULL,
        'uspLogError',
        NULL,
        'Error logged from MySQL procedure'
    );

    SET ErrorLogIDParam = LAST_INSERT_ID();

END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE uspPrintError()
BEGIN

    SELECT
        'MySQL Error Information' AS Message,
        CURRENT_USER() AS CurrentUser,
        NOW() AS ErrorTime;

END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE uspSearchCandidateResumes(
    IN searchStringParam VARCHAR(1000),
    IN useInflectionalParam BOOLEAN,
    IN useThesaurusParam BOOLEAN,
    IN languageParam INT
)
BEGIN

    /*
      MySQL does not support:
      - FREETEXTTABLE
      - CONTAINSTABLE
      - SQL Server thesaurus/inflectional search

      So we approximate using FULLTEXT MATCH.
    */

    SELECT
        JobCandidateID,
        MATCH(Resume) AGAINST(searchStringParam IN NATURAL LANGUAGE MODE) AS RankScore
    FROM humanresources_jobcandidate
    WHERE MATCH(Resume) AGAINST(searchStringParam IN NATURAL LANGUAGE MODE);

END$$

DELIMITER ;

ALTER TABLE humanresources_jobcandidate
ADD FULLTEXT INDEX ft_resume (Resume);

CALL uspSearchCandidateResumes(
    'manager',
    0,
    0,
    0
);


DELIMITER $$

CREATE PROCEDURE uspUpdateEmployeeHireInfo(
    IN BusinessEntityIDParam INT,
    IN JobTitleParam VARCHAR(50),
    IN HireDateParam DATETIME,
    IN RateChangeDateParam DATETIME,
    IN RateParam DECIMAL(19,4),
    IN PayFrequencyParam TINYINT,
    IN CurrentFlagParam BOOLEAN
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE humanresources_employee
    SET
        JobTitle = JobTitleParam,
        HireDate = HireDateParam,
        CurrentFlag = CurrentFlagParam
    WHERE BusinessEntityID = BusinessEntityIDParam;

    INSERT INTO humanresources_employeepayhistory
    (
        BusinessEntityID,
        RateChangeDate,
        Rate,
        PayFrequency
    )
    VALUES
    (
        BusinessEntityIDParam,
        RateChangeDateParam,
        RateParam,
        PayFrequencyParam
    );

    COMMIT;

END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE uspUpdateEmployeePersonalInfo(
    IN BusinessEntityIDParam INT,
    IN NationalIDNumberParam VARCHAR(15),
    IN BirthDateParam DATETIME,
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
    SET
        NationalIDNumber = NationalIDNumberParam,
        BirthDate = BirthDateParam,
        MaritalStatus = MaritalStatusParam,
        Gender = GenderParam
    WHERE BusinessEntityID = BusinessEntityIDParam;

    COMMIT;

END$$

DELIMITER ;


SELECT
    ROUTINE_TYPE,
    ROUTINE_SCHEMA,
    ROUTINE_NAME,
    ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
ORDER BY
    ROUTINE_TYPE,
    ROUTINE_SCHEMA,
    ROUTINE_NAME;
    
CREATE VIEW humanresources_vemployeedepartment AS
SELECT
    e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    d.name AS department,
    d.groupname,
    edh.startdate
FROM humanresources_employee e
INNER JOIN person_person p
    ON p.businessentityid = e.businessentityid
INNER JOIN humanresources_employeedepartmenthistory edh
    ON e.businessentityid = edh.businessentityid
INNER JOIN humanresources_department d
    ON edh.departmentid = d.departmentid
WHERE edh.enddate IS NULL;

CREATE VIEW humanresources_vemployeedepartmenthistory AS
SELECT
    e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    s.name AS shift,
    d.name AS department,
    d.groupname,
    edh.startdate,
    edh.enddate
FROM humanresources_employee e
INNER JOIN person_person p
    ON p.businessentityid = e.businessentityid
INNER JOIN humanresources_employeedepartmenthistory edh
    ON e.businessentityid = edh.businessentityid
INNER JOIN humanresources_department d
    ON edh.departmentid = d.departmentid
INNER JOIN humanresources_shift s
    ON s.shiftid = edh.shiftid;
    
CREATE VIEW humanresources_vemployee AS
SELECT
    e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.additionalcontactinfo
FROM humanresources_employee e
INNER JOIN person_person p
    ON p.businessentityid = e.businessentityid
INNER JOIN person_businessentityaddress bea
    ON bea.businessentityid = e.businessentityid
INNER JOIN person_address a
    ON a.addressid = bea.addressid
INNER JOIN person_stateprovince sp
    ON sp.stateprovinceid = a.stateprovinceid
INNER JOIN person_countryregion cr
    ON cr.countryregioncode = sp.countryregioncode
LEFT OUTER JOIN person_personphone pp
    ON pp.businessentityid = p.businessentityid
LEFT OUTER JOIN person_phonenumbertype pnt
    ON pp.phonenumbertypeid = pnt.phonenumbertypeid
LEFT OUTER JOIN person_emailaddress ea
    ON p.businessentityid = ea.businessentityid;


CREATE VIEW person_vstateprovincecountryregion AS
SELECT
    sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
FROM person_stateprovince sp
INNER JOIN person_countryregion cr
    ON sp.countryregioncode = cr.countryregioncode;
    
CREATE VIEW production_vproductanddescription AS
SELECT
    p.productid,
    p.name,
    pm.name AS productmodel,
    pmx.cultureid,
    pd.description
FROM production_product p
INNER JOIN production_productmodel pm
    ON p.productmodelid = pm.productmodelid
INNER JOIN production_productmodelproductdescriptionculture pmx
    ON pm.productmodelid = pmx.productmodelid
INNER JOIN production_productdescription pd
    ON pmx.productdescriptionid = pd.productdescriptionid;


CREATE VIEW purchasing_vvendorwithaddresses AS
SELECT
    v.businessentityid,
    v.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
FROM purchasing_vendor v
INNER JOIN person_businessentityaddress bea
    ON bea.businessentityid = v.businessentityid
INNER JOIN person_address a
    ON a.addressid = bea.addressid
INNER JOIN person_stateprovince sp
    ON sp.stateprovinceid = a.stateprovinceid
INNER JOIN person_countryregion cr
    ON cr.countryregioncode = sp.countryregioncode
INNER JOIN person_addresstype at
    ON at.addresstypeid = bea.addresstypeid;
    
CREATE VIEW purchasing_vvendorwithcontacts AS
SELECT
    v.businessentityid,
    v.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
FROM purchasing_vendor v
INNER JOIN person_businessentitycontact bec
    ON bec.businessentityid = v.businessentityid
INNER JOIN person_contacttype ct
    ON ct.contacttypeid = bec.contacttypeid
INNER JOIN person_person p
    ON p.businessentityid = bec.personid
LEFT OUTER JOIN person_emailaddress ea
    ON ea.businessentityid = p.businessentityid
LEFT OUTER JOIN person_personphone pp
    ON pp.businessentityid = p.businessentityid
LEFT OUTER JOIN person_phonenumbertype pnt
    ON pnt.phonenumbertypeid = pp.phonenumbertypeid;
    
CREATE VIEW sales_vindividualcustomer AS
SELECT
    p.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.demographics
FROM person_person p
INNER JOIN person_businessentityaddress bea
    ON bea.businessentityid = p.businessentityid
INNER JOIN person_address a
    ON a.addressid = bea.addressid
INNER JOIN person_stateprovince sp
    ON sp.stateprovinceid = a.stateprovinceid
INNER JOIN person_countryregion cr
    ON cr.countryregioncode = sp.countryregioncode
INNER JOIN person_addresstype at
    ON at.addresstypeid = bea.addresstypeid
INNER JOIN sales_customer c
    ON c.personid = p.businessentityid
LEFT OUTER JOIN person_emailaddress ea
    ON ea.businessentityid = p.businessentityid
LEFT OUTER JOIN person_personphone pp
    ON pp.businessentityid = p.businessentityid
LEFT OUTER JOIN person_phonenumbertype pnt
    ON pnt.phonenumbertypeid = pp.phonenumbertypeid
WHERE c.storeid IS NULL;

CREATE VIEW sales_vsalesperson AS
SELECT
    s.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    st.name AS territoryname,
    st.`group` AS territorygroup,
    s.salesquota,
    s.salesytd,
    s.saleslastyear
FROM sales_salesperson s
INNER JOIN humanresources_employee e
    ON e.businessentityid = s.businessentityid
INNER JOIN person_person p
    ON p.businessentityid = s.businessentityid
INNER JOIN person_businessentityaddress bea
    ON bea.businessentityid = s.businessentityid
INNER JOIN person_address a
    ON a.addressid = bea.addressid
INNER JOIN person_stateprovince sp
    ON sp.stateprovinceid = a.stateprovinceid
INNER JOIN person_countryregion cr
    ON cr.countryregioncode = sp.countryregioncode
LEFT OUTER JOIN sales_salesterritory st
    ON st.territoryid = s.territoryid
LEFT OUTER JOIN person_emailaddress ea
    ON ea.businessentityid = p.businessentityid
LEFT OUTER JOIN person_personphone pp
    ON pp.businessentityid = p.businessentityid
LEFT OUTER JOIN person_phonenumbertype pnt
    ON pnt.phonenumbertypeid = pp.phonenumbertypeid;
    

CREATE VIEW sales_vstorewithaddresses AS
SELECT
    s.businessentityid,
    s.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
FROM sales_store s
INNER JOIN person_businessentityaddress bea
    ON bea.businessentityid = s.businessentityid
INNER JOIN person_address a
    ON a.addressid = bea.addressid
INNER JOIN person_stateprovince sp
    ON sp.stateprovinceid = a.stateprovinceid
INNER JOIN person_countryregion cr
    ON cr.countryregioncode = sp.countryregioncode
INNER JOIN person_addresstype at
    ON at.addresstypeid = bea.addresstypeid;
    
CREATE VIEW sales_vstorewithcontacts AS
SELECT
    s.businessentityid,
    s.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
FROM sales_store s
INNER JOIN person_businessentitycontact bec
    ON bec.businessentityid = s.businessentityid
INNER JOIN person_contacttype ct
    ON ct.contacttypeid = bec.contacttypeid
INNER JOIN person_person p
    ON p.businessentityid = bec.personid
LEFT OUTER JOIN person_emailaddress ea
    ON ea.businessentityid = p.businessentityid
LEFT OUTER JOIN person_personphone pp
    ON pp.businessentityid = p.businessentityid
LEFT OUTER JOIN person_phonenumbertype pnt
    ON pnt.phonenumbertypeid = pp.phonenumbertypeid;
    
    

CREATE VIEW sales_vsalespersonsalesbyfiscalyears AS
SELECT
    soh.salespersonid,

    CONCAT(
        p.firstname,
        ' ',
        COALESCE(p.middlename, ''),
        ' ',
        p.lastname
    ) AS fullname,

    e.jobtitle,

    st.name AS salesterritory,

    SUM(
        CASE
            WHEN YEAR(DATE_ADD(soh.orderdate, INTERVAL 6 MONTH)) = 2002
            THEN soh.subtotal
            ELSE 0
        END
    ) AS `2002`,

    SUM(
        CASE
            WHEN YEAR(DATE_ADD(soh.orderdate, INTERVAL 6 MONTH)) = 2003
            THEN soh.subtotal
            ELSE 0
        END
    ) AS `2003`,

    SUM(
        CASE
            WHEN YEAR(DATE_ADD(soh.orderdate, INTERVAL 6 MONTH)) = 2004
            THEN soh.subtotal
            ELSE 0
        END
    ) AS `2004`

FROM sales_salesperson sp

INNER JOIN sales_salesorderheader soh
    ON sp.businessentityid = soh.salespersonid

INNER JOIN sales_salesterritory st
    ON sp.territoryid = st.territoryid

INNER JOIN humanresources_employee e
    ON soh.salespersonid = e.businessentityid

INNER JOIN person_person p
    ON p.businessentityid = sp.businessentityid

GROUP BY
    soh.salespersonid,
    fullname,
    e.jobtitle,
    st.name;
    
    
CREATE VIEW sales_vstorewithdemographics AS
SELECT
    s.businessentityid,
    s.name,

    ExtractValue(s.demographics, '/StoreSurvey/AnnualSales') AS annualsales,

    ExtractValue(s.demographics, '/StoreSurvey/AnnualRevenue') AS annualrevenue,

    ExtractValue(s.demographics, '/StoreSurvey/BankName') AS bankname,

    ExtractValue(s.demographics, '/StoreSurvey/BusinessType') AS businesstype,

    ExtractValue(s.demographics, '/StoreSurvey/YearOpened') AS yearopened,

    ExtractValue(s.demographics, '/StoreSurvey/Specialty') AS specialty,

    ExtractValue(s.demographics, '/StoreSurvey/SquareFeet') AS squarefeet,

    ExtractValue(s.demographics, '/StoreSurvey/Brands') AS brands,

    ExtractValue(s.demographics, '/StoreSurvey/Internet') AS internet,

    ExtractValue(s.demographics, '/StoreSurvey/NumberEmployees') AS numberemployees
FROM sales_store s;

CREATE VIEW sales_vpersondemographics AS
SELECT
    p.businessentityid,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/TotalPurchaseYTD'
    ) AS totalpurchaseytd,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/DateFirstPurchase'
    ) AS datefirstpurchase,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/BirthDate'
    ) AS birthdate,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/MaritalStatus'
    ) AS maritalstatus,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/YearlyIncome'
    ) AS yearlyincome,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/Gender'
    ) AS gender,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/TotalChildren'
    ) AS totalchildren,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/NumberChildrenAtHome'
    ) AS numberchildrenathome,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/Education'
    ) AS education,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/Occupation'
    ) AS occupation,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/HomeOwnerFlag'
    ) AS homeownerflag,

    ExtractValue(
        p.demographics,
        '/IndividualSurvey/NumberCarsOwned'
    ) AS numbercarsowned

FROM person_person p
WHERE p.demographics IS NOT NULL;


CREATE VIEW production_vproductmodelcatalogdescription AS
SELECT
    productmodelid,
    name,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Summary'
    ) AS summary,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Manufacturer/Name'
    ) AS manufacturer,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Manufacturer/Copyright'
    ) AS copyright,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Manufacturer/ProductURL'
    ) AS producturl,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/Warranty/WarrantyPeriod'
    ) AS warrantyperiod,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/Warranty/Description'
    ) AS warrantydescription,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/Maintenance/NoOfYears'
    ) AS noofyears,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/Maintenance/Description'
    ) AS maintenancedescription,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/wheel'
    ) AS wheel,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/saddle'
    ) AS saddle,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/pedal'
    ) AS pedal,

    ExtractValue(
        catalogdescription,
        '/ProductDescription/Features/BikeFrame'
    ) AS bikeframe

FROM production_productmodel;


CREATE VIEW production_vproductmodelinstructions AS
SELECT
    productmodelid,
    name,

    ExtractValue(
        instructions,
        '/root'
    ) AS instructions_text,

    rowguid,
    modifieddate

FROM production_productmodel
WHERE instructions IS NOT NULL;


SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT COUNT(*) FROM humanresources_vemployee;

SELECT COUNT(*) FROM sales_vsalesperson;

SELECT COUNT(*) FROM sales_vstorewithdemographics;

SELECT COUNT(*) FROM production_vproductmodelcatalogdescription;


DELIMITER $$

CREATE PROCEDURE humanresources_uspupdateemployeepersonalinfo (
    IN p_businessentityid INT,
    IN p_nationalidnumber VARCHAR(15),
    IN p_birthdate DATETIME,
    IN p_maritalstatus CHAR(1),
    IN p_gender CHAR(1)
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE humanresources_employee
    SET
        nationalidnumber = p_nationalidnumber,
        birthdate = p_birthdate,
        maritalstatus = p_maritalstatus,
        gender = p_gender
    WHERE businessentityid = p_businessentityid;

    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE humanresources_uspupdateemployeelogin (
    IN p_businessentityid INT,
    IN p_organizationnode VARCHAR(255),
    IN p_loginid VARCHAR(256),
    IN p_jobtitle VARCHAR(50),
    IN p_hiredate DATETIME,
    IN p_currentflag TINYINT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE humanresources_employee
    SET
        organizationnode = p_organizationnode,
        loginid = p_loginid,
        jobtitle = p_jobtitle,
        hiredate = p_hiredate,
        currentflag = p_currentflag
    WHERE businessentityid = p_businessentityid;

    COMMIT;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE humanresources_uspupdateemployeehireinfo (
    IN p_businessentityid INT,
    IN p_jobtitle VARCHAR(50),
    IN p_hiredate DATETIME,
    IN p_ratechangedate DATETIME,
    IN p_rate DECIMAL(19,4),
    IN p_payfrequency TINYINT,
    IN p_currentflag TINYINT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE humanresources_employee
    SET
        jobtitle = p_jobtitle,
        hiredate = p_hiredate,
        currentflag = p_currentflag
    WHERE businessentityid = p_businessentityid;

    INSERT INTO humanresources_employeepayhistory
    (
        businessentityid,
        ratechangedate,
        rate,
        payfrequency
    )
    VALUES
    (
        p_businessentityid,
        p_ratechangedate,
        p_rate,
        p_payfrequency
    );

    COMMIT;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE dbo_uspgetbillofmaterials (
    IN p_startproductid INT,
    IN p_checkdate DATETIME
)
BEGIN

    WITH RECURSIVE bom_cte AS
    (
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name AS componentdesc,
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            0 AS recursionlevel
        FROM production_billofmaterials b
        INNER JOIN production_product p
            ON b.componentid = p.productid
        WHERE b.productassemblyid = p_startproductid
            AND p_checkdate >= b.startdate
            AND p_checkdate <= IFNULL(b.enddate, p_checkdate)

        UNION ALL

        SELECT
            b.productassemblyid,
            b.componentid,
            p.name AS componentdesc,
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            cte.recursionlevel + 1
        FROM bom_cte cte
        INNER JOIN production_billofmaterials b
            ON b.productassemblyid = cte.componentid
        INNER JOIN production_product p
            ON b.componentid = p.productid
        WHERE p_checkdate >= b.startdate
            AND p_checkdate <= IFNULL(b.enddate, p_checkdate)
    )

    SELECT
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        SUM(b.perassemblyqty) AS totalquantity,
        b.standardcost,
        b.listprice,
        b.bomlevel,
        b.recursionlevel
    FROM bom_cte b
    GROUP BY
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        b.standardcost,
        b.listprice,
        b.bomlevel,
        b.recursionlevel
    ORDER BY
        b.bomlevel,
        b.productassemblyid,
        b.componentid;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE dbo_uspgetwhereusedproductid (
    IN p_startproductid INT,
    IN p_checkdate DATETIME
)
BEGIN

    WITH RECURSIVE bom_cte AS
    (
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name AS componentdesc,
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            0 AS recursionlevel
        FROM production_billofmaterials b
        INNER JOIN production_product p
            ON b.productassemblyid = p.productid
        WHERE b.componentid = p_startproductid
            AND p_checkdate >= b.startdate
            AND p_checkdate <= IFNULL(b.enddate, p_checkdate)

        UNION ALL

        SELECT
            b.productassemblyid,
            b.componentid,
            p.name AS componentdesc,
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            cte.recursionlevel + 1
        FROM bom_cte cte
        INNER JOIN production_billofmaterials b
            ON cte.productassemblyid = b.componentid
        INNER JOIN production_product p
            ON b.productassemblyid = p.productid
        WHERE p_checkdate >= b.startdate
            AND p_checkdate <= IFNULL(b.enddate, p_checkdate)
    )

    SELECT
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        SUM(b.perassemblyqty) AS totalquantity,
        b.standardcost,
        b.listprice,
        b.bomlevel,
        b.recursionlevel
    FROM bom_cte b
    GROUP BY
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        b.standardcost,
        b.listprice,
        b.bomlevel,
        b.recursionlevel
    ORDER BY
        b.bomlevel,
        b.productassemblyid,
        b.componentid;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE dbo_uspprinterror ()
BEGIN

    GET DIAGNOSTICS CONDITION 1
        @p1 = MYSQL_ERRNO,
        @p2 = RETURNED_SQLSTATE,
        @p3 = MESSAGE_TEXT;

    SELECT
        @p1 AS error_number,
        @p2 AS sql_state,
        @p3 AS error_message;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE dbo_usplogerror (
    OUT p_errorlogid INT
)
BEGIN

    DECLARE v_errno INT;
    DECLARE v_sqlstate VARCHAR(10);
    DECLARE v_message TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        GET DIAGNOSTICS CONDITION 1
            v_errno = MYSQL_ERRNO,
            v_sqlstate = RETURNED_SQLSTATE,
            v_message = MESSAGE_TEXT;

        INSERT INTO dbo_errorlog
        (
            username,
            errornumber,
            errorstate,
            errormessage,
            errordate
        )
        VALUES
        (
            CURRENT_USER(),
            v_errno,
            v_sqlstate,
            v_message,
            NOW()
        );

        SET p_errorlogid = LAST_INSERT_ID();

    END;

    SET p_errorlogid = 0;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE dbo_uspgetemployeemanagers (
    IN p_businessentityid INT
)
BEGIN

    WITH RECURSIVE emp_cte AS
    (
        SELECT
            e.businessentityid,
            e.organizationnode,
            p.firstname,
            p.lastname,
            e.jobtitle,
            0 AS recursionlevel
        FROM humanresources_employee e
        INNER JOIN person_person p
            ON p.businessentityid = e.businessentityid
        WHERE e.businessentityid = p_businessentityid

        UNION ALL

        SELECT
            e.businessentityid,
            e.organizationnode,
            p.firstname,
            p.lastname,
            e.jobtitle,
            cte.recursionlevel + 1
        FROM humanresources_employee e
        INNER JOIN emp_cte cte
            ON e.organizationnode =
               SUBSTRING_INDEX(cte.organizationnode, '/', 
               LENGTH(cte.organizationnode)
               - LENGTH(REPLACE(cte.organizationnode, '/', '')) - 1)
        INNER JOIN person_person p
            ON p.businessentityid = e.businessentityid
    )

    SELECT
        cte.recursionlevel,
        cte.businessentityid,
        cte.firstname,
        cte.lastname,
        cte.organizationnode,
        p.firstname AS managerfirstname,
        p.lastname AS managerlastname
    FROM emp_cte cte
    INNER JOIN humanresources_employee e
        ON e.organizationnode =
           SUBSTRING_INDEX(cte.organizationnode, '/',
           LENGTH(cte.organizationnode)
           - LENGTH(REPLACE(cte.organizationnode, '/', '')) - 1)
    INNER JOIN person_person p
        ON p.businessentityid = e.businessentityid
    ORDER BY
        cte.recursionlevel,
        cte.organizationnode;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE humanresources_uspupdateemployeepersonalinfo (
    IN p_businessentityid INT,
    IN p_nationalidnumber VARCHAR(15),
    IN p_birthdate DATETIME,
    IN p_maritalstatus CHAR(1),
    IN p_gender CHAR(1)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        CALL dbo_usplogerror();
    END;

    UPDATE humanresources_employee
    SET nationalidnumber = p_nationalidnumber,
        birthdate = p_birthdate,
        maritalstatus = p_maritalstatus,
        gender = p_gender
    WHERE businessentityid = p_businessentityid;

END$$

DELIMITER ;



-- ============================================
-- 1. humanresources_vjobcandidate
-- ============================================
CREATE VIEW humanresources_vjobcandidate AS
SELECT
    jc.jobcandidateid,
    jc.businessentityid,

    ExtractValue(jc.resume, '/Resume/Name/Name.Prefix') AS name_prefix,
    ExtractValue(jc.resume, '/Resume/Name/Name.First') AS name_first,
    ExtractValue(jc.resume, '/Resume/Name/Name.Middle') AS name_middle,
    ExtractValue(jc.resume, '/Resume/Name/Name.Last') AS name_last,
    ExtractValue(jc.resume, '/Resume/Name/Name.Suffix') AS name_suffix,

    ExtractValue(jc.resume, '/Resume/Skills') AS skills,

    ExtractValue(jc.resume, '/Resume/Address/Addr.Type') AS addr_type,
    ExtractValue(jc.resume, '/Resume/Address/Addr.Location/Location/Loc.CountryRegion') AS addr_countryregion,
    ExtractValue(jc.resume, '/Resume/Address/Addr.Location/Location/Loc.State') AS addr_state,
    ExtractValue(jc.resume, '/Resume/Address/Addr.Location/Location/Loc.City') AS addr_city,
    ExtractValue(jc.resume, '/Resume/Address/Addr.PostalCode') AS addr_postalcode,

    ExtractValue(jc.resume, '/Resume/EMail') AS email,
    ExtractValue(jc.resume, '/Resume/WebSite') AS website,

    jc.modifieddate

FROM humanresources_jobcandidate jc;


-- ============================================
-- 2. humanresources_vjobcandidateeducation
-- ============================================
CREATE VIEW humanresources_vjobcandidateeducation AS
SELECT
    jc.jobcandidateid,

    ExtractValue(jc.resume, '/Resume/Education/Edu.Level') AS edu_level,
    ExtractValue(jc.resume, '/Resume/Education/Edu.StartDate') AS edu_startdate,
    ExtractValue(jc.resume, '/Resume/Education/Edu.EndDate') AS edu_enddate,
    ExtractValue(jc.resume, '/Resume/Education/Edu.Degree') AS edu_degree,
    ExtractValue(jc.resume, '/Resume/Education/Edu.Major') AS edu_major,
    ExtractValue(jc.resume, '/Resume/Education/Edu.Minor') AS edu_minor,
    ExtractValue(jc.resume, '/Resume/Education/Edu.GPA') AS edu_gpa,
    ExtractValue(jc.resume, '/Resume/Education/Edu.GPAScale') AS edu_gpascale,
    ExtractValue(jc.resume, '/Resume/Education/Edu.School') AS edu_school,

    ExtractValue(jc.resume, '/Resume/Education/Edu.Location/Location/Loc.CountryRegion') AS edu_countryregion,
    ExtractValue(jc.resume, '/Resume/Education/Edu.Location/Location/Loc.State') AS edu_state,
    ExtractValue(jc.resume, '/Resume/Education/Edu.Location/Location/Loc.City') AS edu_city

FROM humanresources_jobcandidate jc;


-- ============================================
-- 3. humanresources_vjobcandidateemployment
-- ============================================
CREATE VIEW humanresources_vjobcandidateemployment AS
SELECT
    jc.jobcandidateid,

    ExtractValue(jc.resume, '/Resume/Employment/Emp.StartDate') AS emp_startdate,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.EndDate') AS emp_enddate,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.OrgName') AS emp_orgname,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.JobTitle') AS emp_jobtitle,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.Responsibility') AS emp_responsibility,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.FunctionCategory') AS emp_functioncategory,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.IndustryCategory') AS emp_industrycategory,

    ExtractValue(jc.resume, '/Resume/Employment/Emp.Location/Location/Loc.CountryRegion') AS emp_countryregion,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.Location/Location/Loc.State') AS emp_state,
    ExtractValue(jc.resume, '/Resume/Employment/Emp.Location/Location/Loc.City') AS emp_city

FROM humanresources_jobcandidate jc;


-- ============================================
-- 4. person_vadditionalcontactinfo
-- ============================================
CREATE VIEW person_vadditionalcontactinfo AS
SELECT
    businessentityid,
    firstname,
    middlename,
    lastname,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/telephoneNumber/number'
    ) AS telephonenumber,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/telephoneNumber/SpecialInstructions'
    ) AS telephonespecialinstructions,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/homePostalAddress/Street'
    ) AS street,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/homePostalAddress/City'
    ) AS city,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/homePostalAddress/StateProvince'
    ) AS stateprovince,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/homePostalAddress/PostalCode'
    ) AS postalcode,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/homePostalAddress/CountryRegion'
    ) AS countryregion,

    ExtractValue(additionalcontactinfo,
        '/AdditionalContactInfo/eMail/eMailAddress'
    ) AS emailaddress,

    rowguid,
    modifieddate

FROM person_person;



USE AdventureWorks2025;

ALTER TABLE humanresources_jobcandidate
ADD FULLTEXT(resume);

DELIMITER $$

CREATE PROCEDURE dbo_uspsearchcandidateresumes (
    IN p_searchstring VARCHAR(1000),
    IN p_useinflectional BOOLEAN,
    IN p_usethesaurus BOOLEAN,
    IN p_language INT
)
BEGIN

    /*
      SQL Server FREETEXTTABLE / CONTAINSTABLE
      migrated using MySQL FULLTEXT search.
    */

    SELECT 
        jobcandidateid,
        MATCH(resume) AGAINST(p_searchstring IN NATURAL LANGUAGE MODE) AS relevance_rank
    FROM humanresources_jobcandidate
    WHERE MATCH(resume) AGAINST(p_searchstring IN NATURAL LANGUAGE MODE);

END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE humanresources_uspupdateemployeehireinfo (
    IN p_businessentityid INT,
    IN p_jobtitle VARCHAR(50),
    IN p_hiredate DATETIME,
    IN p_ratechangedate DATETIME,
    IN p_rate DECIMAL(19,4),
    IN p_payfrequency TINYINT,
    IN p_currentflag BOOLEAN
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        CALL dbo_usplogerror();
    END;

    START TRANSACTION;

    UPDATE humanresources_employee
    SET jobtitle = p_jobtitle,
        hiredate = p_hiredate,
        currentflag = p_currentflag
    WHERE businessentityid = p_businessentityid;

    INSERT INTO humanresources_employeepayhistory
    (
        businessentityid,
        ratechangedate,
        rate,
        payfrequency
    )
    VALUES
    (
        p_businessentityid,
        p_ratechangedate,
        p_rate,
        p_payfrequency
    );

    COMMIT;

END $$

DELIMITER ;

SHOW PROCEDURE STATUS 
WHERE Db = 'adventureworks2025'
AND Name = 'humanresources_uspupdateemployeehireinfo';


DELIMITER $$

CREATE PROCEDURE dbo_uspsearchcandidateresumes (
    IN p_searchstring VARCHAR(1000),
    IN p_useinflectional BOOLEAN,
    IN p_usethesaurus BOOLEAN,
    IN p_language INT
)
BEGIN

    /*
      MySQL replacement for SQL Server Full-Text Search.
      Using MATCH() AGAINST() instead of:
      - FREETEXTTABLE
      - CONTAINSTABLE
      - FORMSOF
    */

    SELECT
        jobcandidateid,
        MATCH(resume) AGAINST(p_searchstring IN NATURAL LANGUAGE MODE) AS relevance_rank
    FROM humanresources_jobcandidate
    WHERE MATCH(resume) AGAINST(p_searchstring IN NATURAL LANGUAGE MODE);

END $$

DELIMITER ;


SELECT 
    ROUTINE_SCHEMA,
    ROUTINE_NAME
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE'
AND routine_schema = 'adventureworks2025';



DROP PROCEDURE IF EXISTS dbo_uspgetbillofmaterials;
DROP PROCEDURE IF EXISTS dbo_uspgetemployeemanagers;
DROP PROCEDURE IF EXISTS dbo_uspgetwhereusedproductid;
DROP PROCEDURE IF EXISTS dbo_usplogerror;
DROP PROCEDURE IF EXISTS dbo_uspprinterror;
DROP PROCEDURE IF EXISTS dbo_uspsearchcandidateresumes;
DROP PROCEDURE IF EXISTS humanresources_uspupdateemployeehireinfo;
DROP PROCEDURE IF EXISTS humanresources_uspupdateemployeelogin;
DROP PROCEDURE IF EXISTS humanresources_uspupdateemployeepersonalinfo;

DROP PROCEDURE IF EXISTS uspGetContactInformation;


SELECT 
    ROUTINE_SCHEMA,
    ROUTINE_NAME
FROM information_schema.routines
WHERE routine_type = 'PROCEDURE'
AND routine_schema = 'adventureworks2025'
ORDER BY routine_name;

SELECT COUNT(*) AS total_views
FROM information_schema.views
WHERE table_schema = DATABASE();


SELECT 
    routine_name
FROM information_schema.routines
WHERE routine_type = 'FUNCTION'
AND routine_schema = DATABASE()
ORDER BY routine_name;

DELIMITER $$

CREATE PROCEDURE ufnGetContactInformation(IN p_PersonID INT)
BEGIN

    -- Employee
    SELECT 
        p_PersonID AS PersonID,
        p.FirstName,
        p.LastName,
        e.JobTitle,
        'Employee' AS BusinessEntityType
    FROM HumanResources_Employee e
    INNER JOIN Person_Person p
        ON p.BusinessEntityID = e.BusinessEntityID
    WHERE e.BusinessEntityID = p_PersonID

    UNION ALL

    -- Vendor Contact
    SELECT
        p_PersonID AS PersonID,
        p.FirstName,
        p.LastName,
        ct.Name AS JobTitle,
        'Vendor Contact' AS BusinessEntityType
    FROM Purchasing_Vendor v
    INNER JOIN Person_BusinessEntityContact bec
        ON bec.BusinessEntityID = v.BusinessEntityID
    INNER JOIN Person_ContactType ct
        ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN Person_Person p
        ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = p_PersonID

    UNION ALL

    -- Store Contact
    SELECT
        p_PersonID AS PersonID,
        p.FirstName,
        p.LastName,
        ct.Name AS JobTitle,
        'Store Contact' AS BusinessEntityType
    FROM Sales_Store s
    INNER JOIN Person_BusinessEntityContact bec
        ON bec.BusinessEntityID = s.BusinessEntityID
    INNER JOIN Person_ContactType ct
        ON ct.ContactTypeID = bec.ContactTypeID
    INNER JOIN Person_Person p
        ON p.BusinessEntityID = bec.PersonID
    WHERE bec.PersonID = p_PersonID

    UNION ALL

    -- Consumer
    SELECT
        p_PersonID AS PersonID,
        p.FirstName,
        p.LastName,
        NULL AS JobTitle,
        'Consumer' AS BusinessEntityType
    FROM Person_Person p
    INNER JOIN Sales_Customer c
        ON c.PersonID = p.BusinessEntityID
    WHERE p.BusinessEntityID = p_PersonID
      AND c.StoreID IS NULL;

END $$

DELIMITER ;


SELECT trigger_name
FROM information_schema.triggers
WHERE trigger_schema = DATABASE()
ORDER BY trigger_name;

DELIMITER $$

CREATE TRIGGER dEmployee
BEFORE DELETE ON HumanResources_Employee
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Employees cannot be deleted. They can only be marked as not current.';
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER dVendor
BEFORE DELETE ON Purchasing_Vendor
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Vendors cannot be deleted. They can only be marked as not active.';
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER iPurchaseOrderDetail
AFTER INSERT ON Purchasing_PurchaseOrderDetail
FOR EACH ROW
BEGIN

    INSERT INTO Production_TransactionHistory
    (ProductID, ReferenceOrderID, ReferenceOrderLineID,
     TransactionType, TransactionDate, Quantity, ActualCost)
    VALUES
    (NEW.ProductID, NEW.PurchaseOrderID, NEW.PurchaseOrderDetailID,
     'P', NOW(), NEW.OrderQty, NEW.UnitPrice);

    UPDATE Purchasing_PurchaseOrderHeader
    SET SubTotal =
        (SELECT SUM(LineTotal)
         FROM Purchasing_PurchaseOrderDetail
         WHERE PurchaseOrderID = NEW.PurchaseOrderID)
    WHERE PurchaseOrderID = NEW.PurchaseOrderID;

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER uPurchaseOrderDetail
AFTER UPDATE ON Purchasing_PurchaseOrderDetail
FOR EACH ROW
BEGIN

    IF (NEW.ProductID <> OLD.ProductID
        OR NEW.OrderQty <> OLD.OrderQty
        OR NEW.UnitPrice <> OLD.UnitPrice) THEN

        INSERT INTO Production_TransactionHistory
        (ProductID, ReferenceOrderID, ReferenceOrderLineID,
         TransactionType, TransactionDate, Quantity, ActualCost)
        VALUES
        (NEW.ProductID, NEW.PurchaseOrderID, NEW.PurchaseOrderDetailID,
         'P', NOW(), NEW.OrderQty, NEW.UnitPrice);

        UPDATE Purchasing_PurchaseOrderHeader
        SET SubTotal =
            (SELECT SUM(LineTotal)
             FROM Purchasing_PurchaseOrderDetail
             WHERE PurchaseOrderID = NEW.PurchaseOrderID)
        WHERE PurchaseOrderID = NEW.PurchaseOrderID;

        UPDATE Purchasing_PurchaseOrderDetail
        SET ModifiedDate = NOW()
        WHERE PurchaseOrderDetailID = NEW.PurchaseOrderDetailID;

    END IF;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER uPurchaseOrderHeader
AFTER UPDATE ON Purchasing_PurchaseOrderHeader
FOR EACH ROW
BEGIN

    IF NEW.Status = OLD.Status THEN
        UPDATE Purchasing_PurchaseOrderHeader
        SET RevisionNumber = RevisionNumber + 1
        WHERE PurchaseOrderID = NEW.PurchaseOrderID;
    END IF;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER iWorkOrder
AFTER INSERT ON Production_WorkOrder
FOR EACH ROW
BEGIN

    INSERT INTO Production_TransactionHistory
    (ProductID, ReferenceOrderID, TransactionType,
     TransactionDate, Quantity, ActualCost)
    VALUES
    (NEW.ProductID, NEW.WorkOrderID, 'W', NOW(), NEW.OrderQty, 0);

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER uWorkOrder
AFTER UPDATE ON Production_WorkOrder
FOR EACH ROW
BEGIN

    IF NEW.ProductID <> OLD.ProductID
       OR NEW.OrderQty <> OLD.OrderQty THEN

        INSERT INTO Production_TransactionHistory
        (ProductID, ReferenceOrderID, TransactionType,
         TransactionDate, Quantity)
        VALUES
        (NEW.ProductID, NEW.WorkOrderID, 'W', NOW(), NEW.OrderQty);

    END IF;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER iuPerson
AFTER INSERT ON Person_Person
FOR EACH ROW
BEGIN

    IF NEW.Demographics IS NULL THEN
        SET NEW.Demographics =
        '<IndividualSurvey><TotalPurchaseYTD>0.00</TotalPurchaseYTD></IndividualSurvey>';
    END IF;

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER iSalesOrderDetail
AFTER INSERT ON Sales_SalesOrderDetail
FOR EACH ROW
BEGIN

    INSERT INTO Production_TransactionHistory
    VALUES (NEW.ProductID, NEW.SalesOrderID, NEW.SalesOrderDetailID,
            'S', NOW(), NEW.OrderQty, NEW.UnitPrice);

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER uWorkOrder
AFTER UPDATE ON Production_WorkOrder
FOR EACH ROW
BEGIN

    IF NEW.ProductID <> OLD.ProductID
       OR NEW.OrderQty <> OLD.OrderQty THEN

        INSERT INTO Production_TransactionHistory
        (ProductID, ReferenceOrderID, TransactionType,
         TransactionDate, Quantity)
        VALUES
        (NEW.ProductID, NEW.WorkOrderID, 'W', NOW(), NEW.OrderQty);

    END IF;

END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER iuPerson
BEFORE INSERT ON Person_Person
FOR EACH ROW
BEGIN

    IF NEW.Demographics IS NULL THEN
        SET NEW.Demographics =
        '<IndividualSurvey><TotalPurchaseYTD>0.00</TotalPurchaseYTD></IndividualSurvey>';
    END IF;

END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER uSalesOrderDetail
AFTER UPDATE ON Sales_SalesOrderDetail
FOR EACH ROW
BEGIN
    -- simplified logic version
    UPDATE Sales_SalesOrderHeader
    SET SubTotal =
        (SELECT SUM(LineTotal)
         FROM Sales_SalesOrderDetail
         WHERE SalesOrderID = NEW.SalesOrderID)
    WHERE SalesOrderID = NEW.SalesOrderID;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER dSalesOrderDetail
AFTER DELETE ON Sales_SalesOrderDetail
FOR EACH ROW
BEGIN

    UPDATE Sales_SalesOrderHeader
    SET SubTotal =
        (SELECT SUM(LineTotal)
         FROM Sales_SalesOrderDetail
         WHERE SalesOrderID = OLD.SalesOrderID)
    WHERE SalesOrderID = OLD.SalesOrderID;

END$$

DELIMITER ;
DELIMITER $$
---------------------------


DROP TRIGGER IF EXISTS uSalesOrderHeader;

DELIMITER $$

CREATE TRIGGER uSalesOrderHeader
BEFORE UPDATE ON sales_salesorderheader
FOR EACH ROW
BEGIN

    -- Match SQL Server: increment only if Status NOT changed
    IF NEW.Status = OLD.Status THEN
        SET NEW.RevisionNumber = OLD.RevisionNumber + 1;
    END IF;

    -- Update SalesYTD when subtotal changes
    IF NEW.SubTotal <> OLD.SubTotal THEN

        UPDATE sales_salesperson sp
        SET SalesYTD =
        (
            SELECT IFNULL(SUM(soh.SubTotal),0)
            FROM sales_salesorderheader soh
            WHERE sp.BusinessEntityID = soh.SalesPersonID
              AND soh.Status = 5
              AND soh.OrderDate BETWEEN
                    ufnGetAccountingStartDate()
                    AND
                    ufnGetAccountingEndDate()
        )
        WHERE sp.BusinessEntityID = NEW.SalesPersonID;

        UPDATE sales_salesterritory st
        SET SalesYTD =
        (
            SELECT IFNULL(SUM(soh.SubTotal),0)
            FROM sales_salesorderheader soh
            WHERE st.TerritoryID = soh.TerritoryID
              AND soh.Status = 5
              AND soh.OrderDate BETWEEN
                    ufnGetAccountingStartDate()
                    AND
                    ufnGetAccountingEndDate()
        )
        WHERE st.TerritoryID = NEW.TerritoryID;

    END IF;

END$$

DELIMITER ;
---------------------------
SELECT
    (SELECT COUNT(*) 
        FROM information_schema.tables
        WHERE table_schema = DATABASE()
        AND table_type='BASE TABLE') AS tables_count,

    (SELECT COUNT(*)
        FROM information_schema.views
        WHERE table_schema = DATABASE()) AS views_count,

    (SELECT COUNT(*)
        FROM information_schema.routines
        WHERE routine_schema = DATABASE()
        AND routine_type='PROCEDURE') AS procedures_count,

    (SELECT COUNT(*)
        FROM information_schema.routines
        WHERE routine_schema = DATABASE()
        AND routine_type='FUNCTION') AS functions_count,

    (SELECT COUNT(*)
        FROM information_schema.triggers
        WHERE trigger_schema = DATABASE()) AS triggers_count;
        
        
        SELECT 
    trigger_name,
    action_timing,
    event_manipulation,
    event_object_table
FROM information_schema.triggers
WHERE trigger_schema = DATABASE()
ORDER BY event_object_table, event_manipulation;

SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = DATABASE()
AND routine_type = 'FUNCTION'
ORDER BY routine_name;

SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = DATABASE()
AND routine_type = 'PROCEDURE'
ORDER BY routine_name;


SELECT 
    table_name,
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.key_column_usage
WHERE referenced_table_name IS NOT NULL
AND table_schema = DATABASE()
ORDER BY table_name;

SELECT ufnLeadingZeros(123);
SHOW CREATE FUNCTION ufnGetAccountingEndDate;
SELECT ufnGetAccountingEndDate() AS AccountingEndDate;
SELECT ufnGetAccountingStartDate() AS AccountingStartDate;
SHOW CREATE FUNCTION ufnGetDocumentStatusText;
SHOW CREATE FUNCTION ufnGetDocumentStatusText;
SELECT 
    ufnGetDocumentStatusText(1) AS Status1,
    ufnGetDocumentStatusText(2) AS Status2,
    ufnGetDocumentStatusText(3) AS Status3;
    
SHOW CREATE FUNCTION ufnGetDocumentStatusText;
DELIMITER $$

CREATE FUNCTION ufnGetDocumentStatusText(StatusValue TINYINT)
RETURNS VARCHAR(25)
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
SELECT 
    ufnGetProductListPrice(680, '2011-06-01') AS ListPrice;
SHOW CREATE FUNCTION ufnGetProductStandardCost;
SELECT 
    ufnGetProductDealerPrice(707, '2024-01-01') AS DealerPrice;
SELECT 
    ufnGetProductListPrice(680, '2023-06-01') AS ListPrice;    

SELECT 
    ufnGetProductStandardCost(680, '2023-06-01') AS StandardCost;

SELECT 
    ufnGetProductStandardCost(707, '2022-06-01') AS Cost_2022,
    ufnGetProductStandardCost(707, '2023-06-01') AS Cost_2023,
    ufnGetProductStandardCost(707, '2025-01-01') AS Cost_2025;
    
SELECT 
    ProductID,
    StartDate,
    EndDate,
    StandardCost
FROM production_productcosthistory
WHERE ProductID = 707;

SELECT 
    ufnGetPurchaseOrderStatusText(1) AS Status1,
    ufnGetPurchaseOrderStatusText(2) AS Status2,
    ufnGetPurchaseOrderStatusText(3) AS Status3,
    ufnGetPurchaseOrderStatusText(4) AS Status4;
    
SELECT 
    ufnGetSalesOrderStatusText(1) AS Status1,
    ufnGetSalesOrderStatusText(2) AS Status2,
    ufnGetSalesOrderStatusText(3) AS Status3,
    ufnGetSalesOrderStatusText(4) AS Status4,
    ufnGetSalesOrderStatusText(5) AS Status5,
    ufnGetSalesOrderStatusText(6) AS Status6;
 SELECT ProductID
FROM production_productinventory
LIMIT 10;   

SELECT 
    ufnGetStock(317) AS CurrentStock;
    
SELECT SUM(Quantity) AS ManualStock
FROM production_productinventory
WHERE ProductID = 317
AND LocationID = 6;

SHOW CREATE FUNCTION ufnGetStock;

SHOW CREATE FUNCTION ufnLeadingZeros;

SELECT 
    ufnLeadingZeros(1) AS Test1,
    ufnLeadingZeros(25) AS Test2,
    ufnLeadingZeros(12345) AS Test3;
    
SHOW CREATE PROCEDURE uspGetBillOfMaterials;
SELECT DISTINCT ProductAssemblyID
FROM production_billofmaterials
WHERE ProductAssemblyID IS NOT NULL
LIMIT 10;

CALL uspGetBillOfMaterials(330, '2024-01-01');

SELECT BusinessEntityID
FROM humanresources_employee
LIMIT 10;
CALL uspGetEmployeeManagers(12);

SELECT BusinessEntityID
FROM humanresources_employee
WHERE OrganizationLevel > 1
LIMIT 10;

SHOW CREATE PROCEDURE uspGetEmployeeManagers;

DROP PROCEDURE IF EXISTS uspGetEmployeeManagers;

DELIMITER $$

CREATE PROCEDURE uspGetEmployeeManagers(
    IN BusinessEntityIDParam INT
)
BEGIN

    WITH RECURSIVE EMP_cte (
        BusinessEntityID,
        OrganizationNode,
        FirstName,
        LastName,
        JobTitle,
        RecursionLevel
    ) AS (

        -- Anchor member
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            e.JobTitle,
            0
        FROM humanresources_employee e
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam

        UNION ALL

        -- Recursive member
        SELECT
            mgr.BusinessEntityID,
            mgr.OrganizationNode,
            pp.FirstName,
            pp.LastName,
            mgr.JobTitle,
            cte.RecursionLevel + 1
        FROM EMP_cte cte
        INNER JOIN humanresources_employee mgr
            ON mgr.OrganizationNode =
               LEFT(
                    cte.OrganizationNode,
                    LENGTH(cte.OrganizationNode)
                    - LOCATE(
                        '/',
                        REVERSE(
                            LEFT(
                                cte.OrganizationNode,
                                LENGTH(cte.OrganizationNode) - 1
                            )
                        )
                    )
               )
        INNER JOIN person_person pp
            ON pp.BusinessEntityID = mgr.BusinessEntityID
        WHERE cte.RecursionLevel < 25
          AND cte.OrganizationNode IS NOT NULL
          AND cte.OrganizationNode <> '/'
    )

    SELECT
        RecursionLevel,
        BusinessEntityID,
        FirstName,
        LastName,
        OrganizationNode,
        JobTitle
    FROM EMP_cte
    ORDER BY RecursionLevel;

END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS uspGetManagerEmployees;

DELIMITER $$

CREATE PROCEDURE uspGetManagerEmployees(
    IN BusinessEntityIDParam INT
)
BEGIN

    WITH RECURSIVE EMP_cte (
        BusinessEntityID,
        OrganizationNode,
        FirstName,
        LastName,
        JobTitle,
        RecursionLevel
    ) AS (

        -- Anchor member
        SELECT
            e.BusinessEntityID,
            e.OrganizationNode,
            p.FirstName,
            p.LastName,
            e.JobTitle,
            0
        FROM humanresources_employee e
        INNER JOIN person_person p
            ON p.BusinessEntityID = e.BusinessEntityID
        WHERE e.BusinessEntityID = BusinessEntityIDParam

        UNION ALL

        -- Recursive member
        SELECT
            child.BusinessEntityID,
            child.OrganizationNode,
            pp.FirstName,
            pp.LastName,
            child.JobTitle,
            cte.RecursionLevel + 1
        FROM humanresources_employee child
        INNER JOIN EMP_cte cte
            ON child.OrganizationNode LIKE
               CONCAT(cte.OrganizationNode, '%')
           AND child.OrganizationNode <> cte.OrganizationNode
        INNER JOIN person_person pp
            ON pp.BusinessEntityID = child.BusinessEntityID
        WHERE cte.RecursionLevel < 25
    )

    SELECT
        RecursionLevel,
        OrganizationNode,
        BusinessEntityID,
        FirstName,
        LastName,
        JobTitle
    FROM EMP_cte
    ORDER BY
        RecursionLevel,
        OrganizationNode;

END$$

DELIMITER ;
SELECT BusinessEntityID, OrganizationNode
FROM humanresources_employee
WHERE OrganizationNode IS NOT NULL
LIMIT 10;
CALL uspGetManagerEmployees(2);

SELECT DISTINCT ComponentID
FROM production_billofmaterials
LIMIT 10;
CALL uspGetWhereUsedProductID(320, '2024-01-01');

SHOW CREATE PROCEDURE uspSearchCandidateResumes;
CALL uspSearchCandidateResumes(
    'SQL',
    TRUE,
    FALSE,
    1033
);
SHOW CREATE PROCEDURE uspUpdateEmployeeHireInfo;

CALL uspUpdateEmployeeHireInfo(
    1,
    'Senior Developer',
    '2024-01-01',
    '2024-01-01',
    55.5000,
    2,
    TRUE
);

SHOW CREATE PROCEDURE uspUpdateEmployeeLogin;



SHOW TRIGGERS;




-- =========================================================
-- DROP OLD TRIGGERS
-- =========================================================

DROP TRIGGER IF EXISTS iu_person_trigger;
DROP TRIGGER IF EXISTS usalesorderdetail;


-- =========================================================
-- iuPerson equivalent
-- SQL Server:
-- AFTER INSERT, UPDATE
-- Simplified XML handling for MySQL
-- =========================================================

DELIMITER $$

CREATE TRIGGER iu_person_trigger
BEFORE INSERT ON person_person
FOR EACH ROW
BEGIN

    IF NEW.Demographics IS NULL THEN

        SET NEW.Demographics =
        '<IndividualSurvey>
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD>
        </IndividualSurvey>';

    ELSEIF NEW.Demographics NOT LIKE '%<TotalPurchaseYTD>%' THEN

        SET NEW.Demographics =
        REPLACE(
            NEW.Demographics,
            '</IndividualSurvey>',
            '<TotalPurchaseYTD>0.00</TotalPurchaseYTD></IndividualSurvey>'
        );

    END IF;

END$$

DELIMITER ;


-- =========================================================
-- BEFORE UPDATE version
-- because MySQL requires separate trigger
-- =========================================================

DELIMITER $$

CREATE TRIGGER uu_person_trigger
BEFORE UPDATE ON person_person
FOR EACH ROW
BEGIN

    IF NEW.Demographics IS NULL THEN

        SET NEW.Demographics =
        '<IndividualSurvey>
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD>
        </IndividualSurvey>';

    ELSEIF NEW.Demographics NOT LIKE '%<TotalPurchaseYTD>%' THEN

        SET NEW.Demographics =
        REPLACE(
            NEW.Demographics,
            '</IndividualSurvey>',
            '<TotalPurchaseYTD>0.00</TotalPurchaseYTD></IndividualSurvey>'
        );

    END IF;

END$$

DELIMITER ;


-- =========================================================
-- Improved uSalesOrderDetail
-- closer to SQL Server behavior
-- =========================================================

DELIMITER $$

CREATE TRIGGER usalesorderdetail
AFTER UPDATE ON sales_salesorderdetail
FOR EACH ROW
BEGIN

    -- =====================================================
    -- Insert TransactionHistory
    -- =====================================================

    IF (
        NEW.ProductID <> OLD.ProductID
        OR NEW.OrderQty <> OLD.OrderQty
        OR NEW.UnitPrice <> OLD.UnitPrice
        OR NEW.UnitPriceDiscount <> OLD.UnitPriceDiscount
    ) THEN

        INSERT INTO production_transactionhistory
        (
            ProductID,
            ReferenceOrderID,
            ReferenceOrderLineID,
            TransactionType,
            TransactionDate,
            Quantity,
            ActualCost
        )
        VALUES
        (
            NEW.ProductID,
            NEW.SalesOrderID,
            NEW.SalesOrderDetailID,
            'S',
            NOW(),
            NEW.OrderQty,
            NEW.UnitPrice
        );

    END IF;


    -- =====================================================
    -- Update SalesOrderHeader subtotal
    -- =====================================================

    UPDATE sales_salesorderheader
    SET SubTotal =
    (
        SELECT IFNULL(SUM(LineTotal),0)
        FROM sales_salesorderdetail
        WHERE SalesOrderID = NEW.SalesOrderID
    )
    WHERE SalesOrderID = NEW.SalesOrderID;


    -- =====================================================
    -- Update Person Demographics TotalPurchaseYTD
    -- Simplified replacement for SQL Server XML modify()
    -- =====================================================

    UPDATE person_person p
    JOIN sales_customer c
        ON p.BusinessEntityID = c.PersonID
    JOIN sales_salesorderheader soh
        ON c.CustomerID = soh.CustomerID
    SET p.Demographics =
        REPLACE(
            p.Demographics,
            '<TotalPurchaseYTD>0.00</TotalPurchaseYTD>',
            CONCAT(
                '<TotalPurchaseYTD>',
                CAST(NEW.LineTotal AS CHAR),
                '</TotalPurchaseYTD>'
            )
        )
    WHERE soh.SalesOrderID = NEW.SalesOrderID;

END$$

DELIMITER ;


show triggers;

CREATE TABLE AWBuildVersion (
    SystemInformationID TINYINT PRIMARY KEY,
    DatabaseVersion VARCHAR(25),
    VersionDate DATETIME,
    ModifiedDate DATETIME
);

CREATE TABLE ErrorLog (
    ErrorLogID INT PRIMARY KEY AUTO_INCREMENT,
    ErrorTime DATETIME,
    UserName VARCHAR(128),
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    ErrorProcedure VARCHAR(126),
    ErrorLine INT,
    ErrorMessage TEXT
);

CREATE TABLE DatabaseLog (
    DatabaseLogID INT PRIMARY KEY AUTO_INCREMENT,
    PostTime DATETIME,
    DatabaseUser VARCHAR(128),
    Event VARCHAR(128),
    SchemaName VARCHAR(128),
    ObjectName VARCHAR(128),
    ObjectType VARCHAR(128),
    TSQL TEXT,
    XmlEvent TEXT
);

ALTER TABLE AWBuildVersion
ADD CONSTRAINT PK_AWBuildVersion_SystemInformationID
PRIMARY KEY (SystemInformationID);

ALTER TABLE DatabaseLog
ADD CONSTRAINT PK_DatabaseLog_DatabaseLogID
PRIMARY KEY (DatabaseLogID);

ALTER TABLE ErrorLog
ADD CONSTRAINT PK_ErrorLog_ErrorLogID
PRIMARY KEY (ErrorLogID);




--- unique constraints

SELECT 
    TABLE_SCHEMA AS SchemaName,
    TABLE_NAME AS TableName,
    CONSTRAINT_NAME AS ConstraintName,
    CONSTRAINT_TYPE AS ConstraintType
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_SCHEMA = 'adventureworks2025' 
    AND CONSTRAINT_TYPE IN ('UNIQUE', 'CHECK')
ORDER BY 
    TableName, ConstraintType;


USE `adventureworks2025`;

-- ==========================================
-- HUMAN RESOURCES SCHEMA
-- ==========================================
ALTER TABLE `humanresources_employee`
    ADD CONSTRAINT `ck_employee_birthdate` CHECK (`BirthDate` <= (CURRENT_DATE - INTERVAL 18 YEAR)),
    ADD CONSTRAINT `ck_employee_gender` CHECK (UPPER(`Gender`) IN ('F', 'M')),
    ADD CONSTRAINT `ck_employee_hiredate` CHECK (`HireDate` >= '1996-07-01' AND `HireDate` <= (CURRENT_DATE + INTERVAL 1 DAY)),
    ADD CONSTRAINT `ck_employee_maritalstatus` CHECK (UPPER(`MaritalStatus`) IN ('S', 'M')),
    ADD CONSTRAINT `ck_employee_sickleavehours` CHECK (`SickLeaveHours` >= 0 AND `SickLeaveHours` <= 120),
    ADD CONSTRAINT `ck_employee_vacationhours` CHECK (`VacationHours` >= -40 AND `VacationHours` <= 240);
-- ---------------------------------------------------
-- ---------------------------------------------------    
    USE `adventureworks2025`;

-- Clean up any failed attempts first
ALTER TABLE `humanresources_employee` 
    DROP CONSTRAINT  `ck_employee_birthdate`,
    DROP CONSTRAINT  `ck_employee_hiredate`;

-- Apply the corrected deterministic constraints
ALTER TABLE `humanresources_employee`
    -- Anchors the birth window to allow historical records while blocking impossibly young entries
    ADD CONSTRAINT `ck_employee_birthdate` CHECK (`BirthDate` >= '1930-01-01' AND `BirthDate` <= '2008-12-31'),
    
    -- Anchors the hire date timeline to match the dataset's maximum historical logging frame
    ADD CONSTRAINT `ck_employee_hiredate` CHECK (`HireDate` >= '1996-07-01' AND `HireDate` <= '2015-12-31'),
    
    ADD CONSTRAINT `ck_employee_gender` CHECK (UPPER(`Gender`) IN ('F', 'M')),
    ADD CONSTRAINT `ck_employee_maritalstatus` CHECK (UPPER(`MaritalStatus`) IN ('S', 'M')),
    ADD CONSTRAINT `ck_employee_sickleavehours` CHECK (`SickLeaveHours` >= 0 AND `SickLeaveHours` <= 120),
    ADD CONSTRAINT `ck_employee_vacationhours` CHECK (`VacationHours` >= -40 AND `VacationHours` <= 240);

    
    
-- --------------------------------------------------
-- --------------------------------------------------
ALTER TABLE `humanresources_employeedepartmenthistory`
    ADD CONSTRAINT `ck_employeedepartmenthistory_enddate` CHECK (`EndDate` >= `StartDate` OR `EndDate` IS NULL);

ALTER TABLE `humanresources_employeepayhistory`
    ADD CONSTRAINT `ck_employeepayhistory_payfrequency` CHECK (`PayFrequency` IN (1, 2)),
    ADD CONSTRAINT `ck_employeepayhistory_rate` CHECK (`Rate` >= 6.50 AND `Rate` <= 200.00);

-- ==========================================
-- PERSON SCHEMA
-- ==========================================
ALTER TABLE `person_person`
    ADD CONSTRAINT `ck_person_emailpromotion` CHECK (`EmailPromotion` >= 0 AND `EmailPromotion` <= 2),
    ADD CONSTRAINT `ck_person_persontype` CHECK (`PersonType` IS NULL OR UPPER(`PersonType`) IN ('GC', 'SP', 'EM', 'IN', 'VC', 'SC'));

-- ==========================================
-- PRODUCTION SCHEMA
-- ==========================================
ALTER TABLE `production_document`
    ADD CONSTRAINT `uq_document_rowguid` UNIQUE (`rowguid`),
    ADD CONSTRAINT `ck_document_status` CHECK (`Status` >= 1 AND `Status` <= 3);

ALTER TABLE `production_billofmaterials`
    ADD CONSTRAINT `ck_billofmaterials_bomlevel` CHECK ((`ProductAssemblyID` IS NULL AND `BOMLevel` = 0 AND `PerAssemblyQty` = 1.00) OR (`ProductAssemblyID` IS NOT NULL AND `BOMLevel` >= 1)),
    ADD CONSTRAINT `ck_billofmaterials_enddate` CHECK (`EndDate` > `StartDate` OR `EndDate` IS NULL),
    ADD CONSTRAINT `ck_billofmaterials_perassemblyqty` CHECK (`PerAssemblyQty` >= 1.00),
    ADD CONSTRAINT `ck_billofmaterials_productassemblyid` CHECK (`ProductAssemblyID` <> `ComponentID`);

ALTER TABLE `production_location`
    ADD CONSTRAINT `ck_location_availability` CHECK (`Availability` >= 0.00),
    ADD CONSTRAINT `ck_location_costrate` CHECK (`CostRate` >= 0.00);

ALTER TABLE `production_product`
    ADD CONSTRAINT `ck_product_class` CHECK (UPPER(`Class`) IN ('H', 'M', 'L') OR `Class` IS NULL),
    ADD CONSTRAINT `ck_product_daystomanufacture` CHECK (`DaysToManufacture` >= 0),
    ADD CONSTRAINT `ck_product_listprice` CHECK (`ListPrice` >= 0.00),
    ADD CONSTRAINT `ck_product_productline` CHECK (UPPER(`ProductLine`) IN ('R', 'M', 'T', 'S') OR `ProductLine` IS NULL),
    ADD CONSTRAINT `ck_product_reorderpoint` CHECK (`ReorderPoint` > 0),
    ADD CONSTRAINT `ck_product_safetystocklevel` CHECK (`SafetyStockLevel` > 0),
    ADD CONSTRAINT `ck_product_sellenddate` CHECK (`SellEndDate` >= `SellStartDate` OR `SellEndDate` IS NULL),
    ADD CONSTRAINT `ck_product_standardcost` CHECK (`StandardCost` >= 0.00),
    ADD CONSTRAINT `ck_product_style` CHECK (UPPER(`Style`) IN ('U', 'M', 'W') OR `Style` IS NULL),
    ADD CONSTRAINT `ck_product_weight` CHECK (`Weight` > 0.00);

ALTER TABLE `production_productinventory`
    ADD CONSTRAINT `ck_productinventory_bin` CHECK (`Bin` >= 0 AND `Bin` <= 100),
    -- Replaced T-SQL bracket LIKE syntax with a native MySQL Regular Expression (REGEXP)
    ADD CONSTRAINT `ck_productinventory_shelf` CHECK (`Shelf` REGEXP '^[A-Za-z]$' OR `Shelf` = 'N/A');

ALTER TABLE `production_transactionhistory`
    ADD CONSTRAINT `ck_transactionhistory_transactiontype` CHECK (UPPER(`TransactionType`) IN ('P', 'S', 'W'));

ALTER TABLE `production_workorder`
    ADD CONSTRAINT `ck_workorder_enddate` CHECK (`EndDate` >= `StartDate` OR `EndDate` IS NULL),
    ADD CONSTRAINT `ck_workorder_orderqty` CHECK (`OrderQty` > 0),
    ADD CONSTRAINT `ck_workorder_scrappedqty` CHECK (`ScrappedQty` >= 0);

-- ==========================================
-- PURCHASING SCHEMA
-- ==========================================
ALTER TABLE `purchasing_purchaseorderdetail`
    ADD CONSTRAINT `ck_purchaseorderdetail_orderqty` CHECK (`OrderQty` > 0),
    ADD CONSTRAINT `ck_purchaseorderdetail_unitprice` CHECK (`UnitPrice` >= 0.00);

ALTER TABLE `purchasing_purchaseorderheader`
    ADD CONSTRAINT `ck_purchaseorderheader_freight` CHECK (`Freight` >= 0.00),
    ADD CONSTRAINT `ck_purchaseorderheader_status` CHECK (`Status` >= 1 AND `Status` <= 4),
    ADD CONSTRAINT `ck_purchaseorderheader_subtotal` CHECK (`SubTotal` >= 0.00);

-- ==========================================
-- SALES SCHEMA
-- ==========================================
ALTER TABLE `sales_salesorderdetail`
    ADD CONSTRAINT `ck_salesorderdetail_orderqty` CHECK (`OrderQty` > 0),
    ADD CONSTRAINT `ck_salesorderdetail_unitprice` CHECK (`UnitPrice` >= 0.00),
    ADD CONSTRAINT `ck_salesorderdetail_unitpricediscount` CHECK (`UnitPriceDiscount` >= 0.00);

ALTER TABLE `sales_salesorderheader`
    ADD CONSTRAINT `ck_salesorderheader_duedate` CHECK (`DueDate` >= `OrderDate`),
    ADD CONSTRAINT `ck_salesorderheader_freight` CHECK (`Freight` >= 0.00),
    ADD CONSTRAINT `ck_salesorderheader_status` CHECK (`Status` >= 0 AND `Status` <= 8),
    ADD CONSTRAINT `ck_salesorderheader_subtotal` CHECK (`SubTotal` >= 0.00);
    


