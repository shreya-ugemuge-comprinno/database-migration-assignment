CREATE SCHEMA person;
CREATE SCHEMA humanresources;
CREATE SCHEMA production;
CREATE SCHEMA purchasing;
CREATE SCHEMA sales;

--Person

CREATE TABLE person.businessentity (
    businessentityid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.addresstype (
    addresstypeid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.contacttype (
    contacttypeid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.countryregion (
    countryregioncode VARCHAR(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.phonenumbertype (
    phonenumbertypeid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.person (
    businessentityid INTEGER PRIMARY KEY,
    persontype CHAR(2) NOT NULL,
    namestyle BOOLEAN NOT NULL DEFAULT FALSE,
    title VARCHAR(8),
    firstname VARCHAR(50) NOT NULL,
    middlename VARCHAR(50),
    lastname VARCHAR(50) NOT NULL,
    suffix VARCHAR(10),
    emailpromotion INTEGER NOT NULL,
    additionalcontactinfo XML,
    demographics XML,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE person.password (
    businessentityid INTEGER PRIMARY KEY,
    passwordhash VARCHAR(128) NOT NULL,
    passwordsalt VARCHAR(10) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person.businessentityaddress (
    businessentityid INTEGER NOT NULL,
    addressid INTEGER NOT NULL,
    addresstypeid INTEGER NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        addressid,
        addresstypeid
    )
);

CREATE TABLE person.businessentitycontact (
    businessentityid INTEGER NOT NULL,
    personid INTEGER NOT NULL,
    contacttypeid INTEGER NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        personid,
        contacttypeid
    )
);

CREATE TABLE person.emailaddress (
    businessentityid INTEGER NOT NULL,
    emailaddressid INTEGER GENERATED ALWAYS AS IDENTITY,
    emailaddress VARCHAR(50),
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        emailaddressid
    )
);

CREATE TABLE person.personphone (
    businessentityid INTEGER NOT NULL,
    phonenumber VARCHAR(25) NOT NULL,
    phonenumbertypeid INTEGER NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        phonenumber,
        phonenumbertypeid
    )
);

CREATE TABLE person.stateprovince (
    stateprovinceid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    stateprovincecode VARCHAR(3) NOT NULL,
    countryregioncode VARCHAR(3) NOT NULL,
    isonlystateprovinceflag BOOLEAN NOT NULL,
    name VARCHAR(50) NOT NULL,
    territoryid INTEGER NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE person.address (
    addressid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    addressline1 VARCHAR(60) NOT NULL,
    addressline2 VARCHAR(60),
    city VARCHAR(30) NOT NULL,
    stateprovinceid INTEGER NOT NULL,
    postalcode VARCHAR(15) NOT NULL,
    spatiallocation VARCHAR(100),
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



-- HUMANRESOURCES



CREATE TABLE humanresources.department (
    departmentid SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    groupname VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE humanresources.shift (
    shiftid SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    starttime TIME NOT NULL,
    endtime TIME NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE humanresources.employee (
    businessentityid INTEGER PRIMARY KEY,
    nationalidnumber VARCHAR(15) NOT NULL,
    loginid VARCHAR(256) NOT NULL,
    organizationnode VARCHAR(4000),
    organizationlevel SMALLINT,
    jobtitle VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    maritalstatus CHAR(1) NOT NULL,
    gender CHAR(1) NOT NULL,
    hiredate DATE NOT NULL,
    salariedflag BOOLEAN NOT NULL,
    vacationhours SMALLINT NOT NULL,
    sickleavehours SMALLINT NOT NULL,
    currentflag BOOLEAN NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE humanresources.employeedepartmenthistory (
    businessentityid INTEGER NOT NULL,
    departmentid SMALLINT NOT NULL,
    shiftid SMALLINT NOT NULL,
    startdate DATE NOT NULL,
    enddate DATE,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        departmentid,
        shiftid,
        startdate
    )
);

CREATE TABLE humanresources.employeepayhistory (
    businessentityid INTEGER NOT NULL,
    ratechangedate TIMESTAMP NOT NULL,
    rate NUMERIC(19,4) NOT NULL,
    payfrequency SMALLINT NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        businessentityid,
        ratechangedate
    )
);

CREATE TABLE humanresources.jobcandidate (
    jobcandidateid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    businessentityid INTEGER,
    resume XML,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


---Production 



CREATE TABLE production.culture (
    cultureid CHAR(6) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.illustration (
    illustrationid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    diagram XML,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.location (
    locationid SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    costrate NUMERIC(10,4) NOT NULL,
    availability NUMERIC(8,2) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.productcategory (
    productcategoryid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.productdescription (
    productdescriptionid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(400) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.scrapreason (
    scrapreasonid SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.unitmeasure (
    unitmeasurecode CHAR(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE production.productmodel (
    productmodelid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    catalogdescription XML,
    instructions XML,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.productphoto (
    productphotoid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    thumbnailphoto BYTEA,
    thumbnailphotofilename VARCHAR(50),
    largephoto BYTEA,
    largephotofilename VARCHAR(50),
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.productsubcategory (
    productsubcategoryid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    productcategoryid INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.product (
    productid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    productnumber VARCHAR(25) NOT NULL,
    makeflag BOOLEAN NOT NULL,
    finishedgoodsflag BOOLEAN NOT NULL,
    color VARCHAR(15),
    safetystocklevel SMALLINT NOT NULL,
    reorderpoint SMALLINT NOT NULL,
    standardcost NUMERIC(19,4) NOT NULL,
    listprice NUMERIC(19,4) NOT NULL,
    size VARCHAR(5),
    sizeunitmeasurecode CHAR(3),
    weightunitmeasurecode CHAR(3),
    weight NUMERIC(8,2),
    daystomanufacture INTEGER NOT NULL,
    productline CHAR(2),
    class CHAR(2),
    style CHAR(2),
    productsubcategoryid INTEGER,
    productmodelid INTEGER,
    sellstartdate TIMESTAMP NOT NULL,
    sellenddate TIMESTAMP,
    discontinueddate TIMESTAMP,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE production.billofmaterials (
    billofmaterialsid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    productassemblyid INTEGER,
    componentid INTEGER NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    unitmeasurecode CHAR(3) NOT NULL,
    bomlevel SMALLINT NOT NULL,
    perassemblyqty NUMERIC(8,2) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.productcosthistory (
    productid INTEGER NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    standardcost NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, startdate)
);

CREATE TABLE production.productinventory (
    productid INTEGER NOT NULL,
    locationid SMALLINT NOT NULL,
    shelf VARCHAR(10) NOT NULL,
    bin SMALLINT NOT NULL,
    quantity SMALLINT NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, locationid)
);

CREATE TABLE production.productlistpricehistory (
    productid INTEGER NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    listprice NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, startdate)
);


CREATE TABLE production.productdocument (
    productid INTEGER NOT NULL,
    documentnode VARCHAR(4000) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, documentnode)
);

CREATE TABLE production.productmodelillustration (
    productmodelid INTEGER NOT NULL,
    illustrationid INTEGER NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productmodelid, illustrationid)
);

CREATE TABLE production.productmodelproductdescriptionculture (
    productmodelid INTEGER NOT NULL,
    productdescriptionid INTEGER NOT NULL,
    cultureid CHAR(6) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productmodelid, productdescriptionid, cultureid)
);

CREATE TABLE production.productproductphoto (
    productid INTEGER NOT NULL,
    productphotoid INTEGER NOT NULL,
    "primary" BOOLEAN NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, productphotoid)
);

CREATE TABLE production.productreview (
    productreviewid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    productid INTEGER NOT NULL,
    reviewername VARCHAR(50) NOT NULL,
    reviewdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    emailaddress VARCHAR(50) NOT NULL,
    rating INTEGER NOT NULL,
    comments VARCHAR(3850),
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.transactionhistory (
    transactionid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    productid INTEGER NOT NULL,
    referenceorderid INTEGER NOT NULL,
    referenceorderlineid INTEGER NOT NULL,
    transactiondate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transactiontype CHAR(1) NOT NULL,
    quantity INTEGER NOT NULL,
    actualcost NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.transactionhistoryarchive (
    transactionid INTEGER PRIMARY KEY,
    productid INTEGER NOT NULL,
    referenceorderid INTEGER NOT NULL,
    referenceorderlineid INTEGER NOT NULL,
    transactiondate TIMESTAMP NOT NULL,
    transactiontype CHAR(1) NOT NULL,
    quantity INTEGER NOT NULL,
    actualcost NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.workorder (
    workorderid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    productid INTEGER NOT NULL,
    orderqty INTEGER NOT NULL,
    stockedqty INTEGER NOT NULL,
    scrappedqty SMALLINT NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    duedate TIMESTAMP NOT NULL,
    scrapreasonid SMALLINT,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE production.workorderrouting (
    workorderid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    operationsequence SMALLINT NOT NULL,
    locationid SMALLINT NOT NULL,
    scheduledstartdate TIMESTAMP NOT NULL,
    scheduledenddate TIMESTAMP NOT NULL,
    actualstartdate TIMESTAMP,
    actualenddate TIMESTAMP,
    actualresourcehrs NUMERIC(9,4),
    plannedcost NUMERIC(19,4) NOT NULL,
    actualcost NUMERIC(19,4),
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(workorderid, productid, operationsequence)
);

CREATE TABLE production.document (
    documentnode TEXT PRIMARY KEY,
    documentlevel SMALLINT,
    title VARCHAR(50) NOT NULL,
    owner SMALLINT NOT NULL,
    folderflag BOOLEAN NOT NULL,
    filename VARCHAR(400) NOT NULL,
    fileextension VARCHAR(8) NOT NULL,
    revision CHAR(5) NOT NULL,
    changenumber INTEGER NOT NULL DEFAULT 0,
    status SMALLINT NOT NULL,
    documentsummary TEXT,
    document BYTEA,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL
);



-- Purchasing 



CREATE TABLE purchasing.shipmethod (
    shipmethodid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    shipbase NUMERIC(19,4) NOT NULL,
    shiprate NUMERIC(19,4) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE purchasing.vendor (
    businessentityid INTEGER PRIMARY KEY,
    accountnumber VARCHAR(15) NOT NULL,
    name VARCHAR(50) NOT NULL,
    creditrating SMALLINT NOT NULL,
    preferredvendorstatus BOOLEAN NOT NULL,
    activeflag BOOLEAN NOT NULL,
    purchasingwebserviceurl VARCHAR(1024),
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--

CREATE TABLE purchasing.productvendor (
    productid INTEGER NOT NULL,
    businessentityid INTEGER NOT NULL,
    averageleadtime INTEGER NOT NULL,
    standardprice NUMERIC(19,4) NOT NULL,
    lastreceiptcost NUMERIC(19,4),
    lastreceiptdate TIMESTAMP,
    minorderqty INTEGER NOT NULL,
    maxorderqty INTEGER NOT NULL,
    onorderqty INTEGER,
    unitmeasurecode CHAR(3) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(productid, businessentityid)
);

CREATE TABLE purchasing.purchaseorderheader (
    purchaseorderid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    revisionnumber SMALLINT NOT NULL,
    status SMALLINT NOT NULL,
    employeeid INTEGER NOT NULL,
    vendorid INTEGER NOT NULL,
    shipmethodid INTEGER NOT NULL,
    orderdate TIMESTAMP NOT NULL,
    shipdate TIMESTAMP,
    subtotal NUMERIC(19,4) NOT NULL,
    taxamt NUMERIC(19,4) NOT NULL,
    freight NUMERIC(19,4) NOT NULL,
    totaldue NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE purchasing.purchaseorderdetail (
    purchaseorderid INTEGER NOT NULL,
    purchaseorderdetailid INTEGER GENERATED ALWAYS AS IDENTITY,
    duedate TIMESTAMP NOT NULL,
    orderqty SMALLINT NOT NULL,
    productid INTEGER NOT NULL,
    unitprice NUMERIC(19,4) NOT NULL,
    receivedqty NUMERIC(8,2) NOT NULL,
    rejectedqty NUMERIC(8,2) NOT NULL,
    stockedqty NUMERIC(9,2) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(purchaseorderid, purchaseorderdetailid)
);



--Sales


CREATE TABLE sales.currency (
    currencycode CHAR(3) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.creditcard (
    creditcardid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cardtype VARCHAR(50) NOT NULL,
    cardnumber VARCHAR(25) NOT NULL,
    expmonth SMALLINT NOT NULL,
    expyear SMALLINT NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.salesreason (
    salesreasonid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    reasontype VARCHAR(50) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.salesterritory (
    territoryid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    countryregioncode VARCHAR(3) NOT NULL,
    "group" VARCHAR(50) NOT NULL,
    salesytd NUMERIC(19,4) NOT NULL,
    saleslastyear NUMERIC(19,4) NOT NULL,
    costytd NUMERIC(19,4) NOT NULL,
    costlastyear NUMERIC(19,4) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.specialoffer (
    specialofferid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    discountpct NUMERIC(10,4) NOT NULL,
    type VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP NOT NULL,
    minqty INTEGER NOT NULL,
    maxqty INTEGER,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--

CREATE TABLE sales.customer (
    customerid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    personid INTEGER,
    storeid INTEGER,
    territoryid INTEGER,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.salesperson (
    businessentityid INTEGER PRIMARY KEY,
    territoryid INTEGER,
    salesquota NUMERIC(19,4),
    bonus NUMERIC(19,4) NOT NULL,
    commissionpct NUMERIC(10,4) NOT NULL,
    salesytd NUMERIC(19,4) NOT NULL,
    saleslastyear NUMERIC(19,4) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.store (
    businessentityid INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salespersonid INTEGER,
    demographics XML,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.currencyrate (
    currencyrateid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    currencyratedate TIMESTAMP NOT NULL,
    fromcurrencycode CHAR(3) NOT NULL,
    tocurrencycode CHAR(3) NOT NULL,
    averagerate NUMERIC(19,4) NOT NULL,
    endofdayrate NUMERIC(19,4) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.personcreditcard (
    businessentityid INTEGER NOT NULL,
    creditcardid INTEGER NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(businessentityid, creditcardid)
);

CREATE TABLE sales.salesorderheader (
    salesorderid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    revisionnumber SMALLINT NOT NULL,
    orderdate TIMESTAMP NOT NULL,
    duedate TIMESTAMP NOT NULL,
    shipdate TIMESTAMP,
    status SMALLINT NOT NULL,
    onlineorderflag BOOLEAN NOT NULL,
    salesordernumber VARCHAR(25) NOT NULL,
    purchaseordernumber VARCHAR(25),
    accountnumber VARCHAR(15),
    customerid INTEGER NOT NULL,
    salespersonid INTEGER,
    territoryid INTEGER,
    billtoaddressid INTEGER NOT NULL,
    shiptoaddressid INTEGER NOT NULL,
    shipmethodid INTEGER NOT NULL,
    creditcardid INTEGER,
    creditcardapprovalcode VARCHAR(15),
    currencyrateid INTEGER,
    subtotal NUMERIC(19,4) NOT NULL,
    taxamt NUMERIC(19,4) NOT NULL,
    freight NUMERIC(19,4) NOT NULL,
    totaldue NUMERIC(19,4) NOT NULL,
    comment VARCHAR(128),
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.salesorderdetail (
    salesorderid INTEGER NOT NULL,
    salesorderdetailid INTEGER GENERATED ALWAYS AS IDENTITY,
    carriertrackingnumber VARCHAR(25),
    orderqty SMALLINT NOT NULL,
    productid INTEGER NOT NULL,
    specialofferid INTEGER NOT NULL,
    unitprice NUMERIC(19,4) NOT NULL,
    unitpricediscount NUMERIC(10,4) NOT NULL,
    linenumtotal NUMERIC(19,4),
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(salesorderid, salesorderdetailid)
);

CREATE TABLE sales.salesorderheadersalesreason (
    salesorderid INTEGER NOT NULL,
    salesreasonid INTEGER NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(salesorderid, salesreasonid)
);

CREATE TABLE sales.shoppingcartitem (
    shoppingcartitemid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    shoppingcartid VARCHAR(50) NOT NULL,
    quantity INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    datecreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.specialofferproduct (
    specialofferid INTEGER NOT NULL,
    productid INTEGER NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(specialofferid, productid)
);


CREATE TABLE sales.countryregioncurrency (
    countryregioncode VARCHAR(3) NOT NULL,
    currencycode CHAR(3) NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(countryregioncode, currencycode)
);


CREATE TABLE sales.salespersonquotahistory (
    businessentityid INTEGER NOT NULL,
    quotadate TIMESTAMP NOT NULL,
    salesquota NUMERIC(19,4) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(businessentityid, quotadate)
);

CREATE TABLE sales.salestaxrate (
    salestaxrateid INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    stateprovinceid INTEGER NOT NULL,
    taxtype SMALLINT NOT NULL,
    taxrate NUMERIC(10,4) NOT NULL,
    name VARCHAR(50) NOT NULL,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales.salesterritoryhistory (
    businessentityid INTEGER NOT NULL,
    territoryid INTEGER NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    rowguid UUID NOT NULL,
    modifieddate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY(businessentityid, territoryid, startdate)
);



-- Applying foreign key constraints 


-- Human Resources


ALTER TABLE humanresources.employee
ADD CONSTRAINT fk_employee_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE humanresources.employeedepartmenthistory
ADD CONSTRAINT fk_edh_employee
FOREIGN KEY (businessentityid)
REFERENCES humanresources.employee(businessentityid);

ALTER TABLE humanresources.employeedepartmenthistory
ADD CONSTRAINT fk_edh_department
FOREIGN KEY (departmentid)
REFERENCES humanresources.department(departmentid);

ALTER TABLE humanresources.employeedepartmenthistory
ADD CONSTRAINT fk_edh_shift
FOREIGN KEY (shiftid)
REFERENCES humanresources.shift(shiftid);

ALTER TABLE humanresources.jobcandidate
ADD CONSTRAINT fk_jobcandidate_employee
FOREIGN KEY (businessentityid)
REFERENCES humanresources.employee(businessentityid);

ALTER TABLE humanresources.employee
ADD CONSTRAINT fk_employee_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.person(businessentityid);

ALTER TABLE humanresources.department
ALTER COLUMN departmentid
SET GENERATED BY DEFAULT;

ALTER TABLE humanresources.shift
ALTER COLUMN shiftid
SET GENERATED BY DEFAULT;

ALTER TABLE humanresources.jobcandidate
ALTER COLUMN jobcandidateid
SET GENERATED BY DEFAULT;


--Person


ALTER TABLE person.password
ADD CONSTRAINT fk_password_person
FOREIGN KEY (businessentityid)
REFERENCES person.person(businessentityid);

ALTER TABLE person.businessentityaddress
ADD CONSTRAINT fk_bea_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE person.businessentityaddress
ADD CONSTRAINT fk_bea_addresstype
FOREIGN KEY (addresstypeid)
REFERENCES person.addresstype(addresstypeid);

ALTER TABLE person.businessentitycontact
ADD CONSTRAINT fk_bec_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE person.businessentitycontact
ADD CONSTRAINT fk_bec_person
FOREIGN KEY (personid)
REFERENCES person.person(businessentityid);

ALTER TABLE person.businessentitycontact
ADD CONSTRAINT fk_bec_contacttype
FOREIGN KEY (contacttypeid)
REFERENCES person.contacttype(contacttypeid);

ALTER TABLE person.emailaddress
ADD CONSTRAINT fk_emailaddress_person
FOREIGN KEY (businessentityid)
REFERENCES person.person(businessentityid);

ALTER TABLE person.personphone
ADD CONSTRAINT fk_personphone_person
FOREIGN KEY (businessentityid)
REFERENCES person.person(businessentityid);

ALTER TABLE person.personphone
ADD CONSTRAINT fk_personphone_type
FOREIGN KEY (phonenumbertypeid)
REFERENCES person.phonenumbertype(phonenumbertypeid);

ALTER TABLE person.person
ADD CONSTRAINT fk_person_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE person.stateprovince
ADD CONSTRAINT fk_stateprovince_countryregion
FOREIGN KEY (countryregioncode)
REFERENCES person.countryregion(countryregioncode);

ALTER TABLE person.businessentityaddress
ADD CONSTRAINT fk_bea_address
FOREIGN KEY (addressid)
REFERENCES person.address(addressid);

ALTER TABLE person.address
ADD CONSTRAINT fk_address_stateprovince
FOREIGN KEY (stateprovinceid)
REFERENCES person.stateprovince(stateprovinceid);

ALTER TABLE person.stateprovince
ADD CONSTRAINT fk_stateprovince_territory
FOREIGN KEY (territoryid)
REFERENCES sales.salesterritory(territoryid);

ALTER TABLE person.businessentity
ALTER COLUMN businessentityid
SET GENERATED BY DEFAULT;

ALTER TABLE person.address
ALTER COLUMN addressid
SET GENERATED BY DEFAULT;

ALTER TABLE person.addresstype
ALTER COLUMN addresstypeid
SET GENERATED BY DEFAULT;

ALTER TABLE person.contacttype
ALTER COLUMN contacttypeid
SET GENERATED BY DEFAULT;

ALTER TABLE person.stateprovince
ALTER COLUMN stateprovinceid
SET GENERATED BY DEFAULT;

ALTER TABLE person.phonenumbertype
ALTER COLUMN phonenumbertypeid
SET GENERATED BY DEFAULT;

ALTER TABLE person.address
ALTER COLUMN spatiallocation TYPE TEXT;


--Production


ALTER TABLE production.productsubcategory
ADD CONSTRAINT fk_productsubcategory_category
FOREIGN KEY (productcategoryid)
REFERENCES production.productcategory(productcategoryid);

ALTER TABLE production.product
ADD CONSTRAINT fk_product_subcategory
FOREIGN KEY (productsubcategoryid)
REFERENCES production.productsubcategory(productsubcategoryid);

ALTER TABLE production.product
ADD CONSTRAINT fk_product_model
FOREIGN KEY (productmodelid)
REFERENCES production.productmodel(productmodelid);

ALTER TABLE production.product
ADD CONSTRAINT fk_product_sizeunit
FOREIGN KEY (sizeunitmeasurecode)
REFERENCES production.unitmeasure(unitmeasurecode);

ALTER TABLE production.product
ADD CONSTRAINT fk_product_weightunit
FOREIGN KEY (weightunitmeasurecode)
REFERENCES production.unitmeasure(unitmeasurecode);

ALTER TABLE production.billofmaterials
ADD CONSTRAINT fk_bom_productassembly
FOREIGN KEY (productassemblyid)
REFERENCES production.product(productid);

ALTER TABLE production.billofmaterials
ADD CONSTRAINT fk_bom_component
FOREIGN KEY (componentid)
REFERENCES production.product(productid);

ALTER TABLE production.billofmaterials
ADD CONSTRAINT fk_bom_unitmeasure
FOREIGN KEY (unitmeasurecode)
REFERENCES production.unitmeasure(unitmeasurecode);

ALTER TABLE production.productinventory
ADD CONSTRAINT fk_inventory_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.productinventory
ADD CONSTRAINT fk_inventory_location
FOREIGN KEY (locationid)
REFERENCES production.location(locationid);

ALTER TABLE production.productdocument
ADD CONSTRAINT fk_productdocument_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.productmodelillustration
ADD CONSTRAINT fk_pmi_productmodel
FOREIGN KEY (productmodelid)
REFERENCES production.productmodel(productmodelid);

ALTER TABLE production.productmodelillustration
ADD CONSTRAINT fk_pmi_illustration
FOREIGN KEY (illustrationid)
REFERENCES production.illustration(illustrationid);

ALTER TABLE production.productmodelproductdescriptionculture
ADD CONSTRAINT fk_pmpdc_productmodel
FOREIGN KEY (productmodelid)
REFERENCES production.productmodel(productmodelid);

ALTER TABLE production.productmodelproductdescriptionculture
ADD CONSTRAINT fk_pmpdc_productdescription
FOREIGN KEY (productdescriptionid)
REFERENCES production.productdescription(productdescriptionid);

ALTER TABLE production.productmodelproductdescriptionculture
ADD CONSTRAINT fk_pmpdc_culture
FOREIGN KEY (cultureid)
REFERENCES production.culture(cultureid);

ALTER TABLE production.productproductphoto
ADD CONSTRAINT fk_ppp_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.productproductphoto
ADD CONSTRAINT fk_ppp_photo
FOREIGN KEY (productphotoid)
REFERENCES production.productphoto(productphotoid);

ALTER TABLE production.productreview
ADD CONSTRAINT fk_productreview_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.transactionhistory
ADD CONSTRAINT fk_transactionhistory_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.transactionhistoryarchive
ADD CONSTRAINT fk_transactionhistoryarchive_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.workorder
ADD CONSTRAINT fk_workorder_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.workorder
ADD CONSTRAINT fk_workorder_scrapreason
FOREIGN KEY (scrapreasonid)
REFERENCES production.scrapreason(scrapreasonid);

ALTER TABLE production.workorderrouting
ADD CONSTRAINT fk_workorderrouting_workorder
FOREIGN KEY (workorderid)
REFERENCES production.workorder(workorderid);

ALTER TABLE production.workorderrouting
ADD CONSTRAINT fk_workorderrouting_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE production.workorderrouting
ADD CONSTRAINT fk_workorderrouting_location
FOREIGN KEY (locationid)
REFERENCES production.location(locationid);

ALTER TABLE production.productmodelproductdescriptionculture
ADD CONSTRAINT fk_pmpdc_productdescription
FOREIGN KEY (productdescriptionid)
REFERENCES production.productdescription(productdescriptionid);



--Purchasing


ALTER TABLE purchasing.vendor
ADD CONSTRAINT fk_vendor_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE purchasing.productvendor
ADD CONSTRAINT fk_productvendor_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE purchasing.productvendor
ADD CONSTRAINT fk_productvendor_vendor
FOREIGN KEY (businessentityid)
REFERENCES purchasing.vendor(businessentityid);

ALTER TABLE purchasing.productvendor
ADD CONSTRAINT fk_productvendor_unitmeasure
FOREIGN KEY (unitmeasurecode)
REFERENCES production.unitmeasure(unitmeasurecode);

ALTER TABLE purchasing.purchaseorderheader
ADD CONSTRAINT fk_purchaseorder_employee
FOREIGN KEY (employeeid)
REFERENCES humanresources.employee(businessentityid);

ALTER TABLE purchasing.purchaseorderheader
ADD CONSTRAINT fk_purchaseorder_vendor
FOREIGN KEY (vendorid)
REFERENCES purchasing.vendor(businessentityid);

ALTER TABLE purchasing.purchaseorderheader
ADD CONSTRAINT fk_purchaseorder_shipmethod
FOREIGN KEY (shipmethodid)
REFERENCES purchasing.shipmethod(shipmethodid);

ALTER TABLE purchasing.purchaseorderdetail
ADD CONSTRAINT fk_purchaseorderdetail_header
FOREIGN KEY (purchaseorderid)
REFERENCES purchasing.purchaseorderheader(purchaseorderid);

ALTER TABLE purchasing.purchaseorderdetail
ADD CONSTRAINT fk_purchaseorderdetail_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);


--Sales


ALTER TABLE sales.salesterritory
ADD CONSTRAINT fk_salesterritory_country
FOREIGN KEY (countryregioncode)
REFERENCES person.countryregion(countryregioncode);

ALTER TABLE sales.customer
ADD CONSTRAINT fk_customer_person
FOREIGN KEY (personid)
REFERENCES person.person(businessentityid);

ALTER TABLE sales.customer
ADD CONSTRAINT fk_customer_store
FOREIGN KEY (storeid)
REFERENCES sales.store(businessentityid);

ALTER TABLE sales.customer
ADD CONSTRAINT fk_customer_territory
FOREIGN KEY (territoryid)
REFERENCES sales.salesterritory(territoryid);

ALTER TABLE sales.salesperson
ADD CONSTRAINT fk_salesperson_employee
FOREIGN KEY (businessentityid)
REFERENCES humanresources.employee(businessentityid);

ALTER TABLE sales.salesperson
ADD CONSTRAINT fk_salesperson_territory
FOREIGN KEY (territoryid)
REFERENCES sales.salesterritory(territoryid);

ALTER TABLE sales.store
ADD CONSTRAINT fk_store_businessentity
FOREIGN KEY (businessentityid)
REFERENCES person.businessentity(businessentityid);

ALTER TABLE sales.currencyrate
ADD CONSTRAINT fk_currencyrate_fromcurrency
FOREIGN KEY (fromcurrencycode)
REFERENCES sales.currency(currencycode);

ALTER TABLE sales.currencyrate
ADD CONSTRAINT fk_currencyrate_tocurrency
FOREIGN KEY (tocurrencycode)
REFERENCES sales.currency(currencycode);

ALTER TABLE sales.personcreditcard
ADD CONSTRAINT fk_personcreditcard_person
FOREIGN KEY (businessentityid)
REFERENCES person.person(businessentityid);

ALTER TABLE sales.personcreditcard
ADD CONSTRAINT fk_personcreditcard_card
FOREIGN KEY (creditcardid)
REFERENCES sales.creditcard(creditcardid);

ALTER TABLE sales.countryregioncurrency
ADD CONSTRAINT fk_countryregioncurrency_country
FOREIGN KEY (countryregioncode)
REFERENCES person.countryregion(countryregioncode);

ALTER TABLE sales.countryregioncurrency
ADD CONSTRAINT fk_countryregioncurrency_currency
FOREIGN KEY (currencycode)
REFERENCES sales.currency(currencycode);

ALTER TABLE sales.salespersonquotahistory
ADD CONSTRAINT fk_salespersonquotahistory_salesperson
FOREIGN KEY (businessentityid)
REFERENCES sales.salesperson(businessentityid);

ALTER TABLE sales.salesterritoryhistory
ADD CONSTRAINT fk_salesterritoryhistory_salesperson
FOREIGN KEY (businessentityid)
REFERENCES sales.salesperson(businessentityid);

ALTER TABLE sales.salesterritoryhistory
ADD CONSTRAINT fk_salesterritoryhistory_territory
FOREIGN KEY (territoryid)
REFERENCES sales.salesterritory(territoryid);

ALTER TABLE sales.salestaxrate
ADD CONSTRAINT fk_salestaxrate_stateprovince
FOREIGN KEY (stateprovinceid)
REFERENCES person.stateprovince(stateprovinceid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_customer
FOREIGN KEY (customerid)
REFERENCES sales.customer(customerid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_salesperson
FOREIGN KEY (salespersonid)
REFERENCES sales.salesperson(businessentityid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_territory
FOREIGN KEY (territoryid)
REFERENCES sales.salesterritory(territoryid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_billtoaddress
FOREIGN KEY (billtoaddressid)
REFERENCES person.address(addressid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_shiptoaddress
FOREIGN KEY (shiptoaddressid)
REFERENCES person.address(addressid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_shipmethod
FOREIGN KEY (shipmethodid)
REFERENCES purchasing.shipmethod(shipmethodid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_creditcard
FOREIGN KEY (creditcardid)
REFERENCES sales.creditcard(creditcardid);

ALTER TABLE sales.salesorderheader
ADD CONSTRAINT fk_salesorderheader_currencyrate
FOREIGN KEY (currencyrateid)
REFERENCES sales.currencyrate(currencyrateid);

ALTER TABLE sales.salesorderdetail
ADD CONSTRAINT fk_salesorderdetail_header
FOREIGN KEY (salesorderid)
REFERENCES sales.salesorderheader(salesorderid);

ALTER TABLE sales.salesorderdetail
ADD CONSTRAINT fk_salesorderdetail_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE sales.salesorderdetail
ADD CONSTRAINT fk_salesorderdetail_specialofferproduct
FOREIGN KEY (specialofferid, productid)
REFERENCES sales.specialofferproduct(specialofferid, productid);

ALTER TABLE sales.specialofferproduct
ADD CONSTRAINT fk_specialofferproduct_offer
FOREIGN KEY (specialofferid)
REFERENCES sales.specialoffer(specialofferid);

ALTER TABLE sales.specialofferproduct
ADD CONSTRAINT fk_specialofferproduct_product
FOREIGN KEY (productid)
REFERENCES production.product(productid);

ALTER TABLE sales.salesorderheadersalesreason
ADD CONSTRAINT fk_sohsr_salesorder
FOREIGN KEY (salesorderid)
REFERENCES sales.salesorderheader(salesorderid);

ALTER TABLE sales.salesorderheadersalesreason
ADD CONSTRAINT fk_sohsr_salesreason
FOREIGN KEY (salesreasonid)
REFERENCES sales.salesreason(salesreasonid);

ALTER TABLE sales.store
ADD CONSTRAINT fk_store_salesperson
FOREIGN KEY (salespersonid)
REFERENCES sales.salesperson(businessentityid);

ALTER TABLE sales.salesorderdetail
ADD CONSTRAINT fk_salesorderdetail_specialofferproduct
FOREIGN KEY (specialofferid, productid)
REFERENCES sales.specialofferproduct(specialofferid, productid);


ALTER TABLE sales.salesorderdetail
ADD CONSTRAINT fk_salesorderdetail_specialofferproduct
FOREIGN KEY (specialofferid, productid)
REFERENCES sales.specialofferproduct (specialofferid, productid);

ALTER TABLE sales.customer
ADD CONSTRAINT fk_customer_person
FOREIGN KEY (personid)
REFERENCES person.person (businessentityid);

ALTER TABLE production.document
ADD CONSTRAINT fk_document_employee
FOREIGN KEY (owner)
REFERENCES humanresources.employee (businessentityid

ALTER TABLE production.document
ADD CONSTRAINT fk_document_employee
FOREIGN KEY (owner)
REFERENCES humanresources.employee (businessentityid);

ALTER TABLE sales.personcreditcard
ADD CONSTRAINT fk_personcreditcard_person
FOREIGN KEY (businessentityid)
REFERENCES person.person (businessentityid);

ALTER TABLE purchasing.productvendor
ADD CONSTRAINT fk_productvendor_product
FOREIGN KEY (productid)
REFERENCES production.product (productid);

ALTER TABLE purchasing.productvendor
ADD CONSTRAINT fk_productvendor_unitmeasure
FOREIGN KEY (unitmeasurecode)
REFERENCES production.unitmeasure (unitmeasurecode);

ALTER TABLE purchasing.purchaseorderdetail
ADD CONSTRAINT fk_purchaseorderdetail_product
FOREIGN KEY (productid)
REFERENCES production.product (productid);



---Unique Constraints

-- ==========================================
-- HUMAN RESOURCES SCHEMA CONSTRAINTS
-- ==========================================

ALTER TABLE humanresources.employee DROP CONSTRAINT IF EXISTS ck_employee_birthdate;

ALTER TABLE humanresources.employee 
ADD CONSTRAINT ck_employee_birthdate 
CHECK (birthdate <= CURRENT_DATE - INTERVAL '18 years');


ALTER TABLE humanresources.employee 
    ADD CONSTRAINT ck_employee_gender CHECK (UPPER(gender::text) IN ('F', 'M')),
    ADD CONSTRAINT ck_employee_hiredate CHECK (hiredate >= '1996-07-01' AND hiredate <= CURRENT_DATE + INTERVAL '1 day'),
    ADD CONSTRAINT ck_employee_maritalstatus CHECK (UPPER(maritalstatus::text) IN ('S', 'M')),
    ADD CONSTRAINT ck_employee_sickleavehours CHECK (sickleavehours >= 0 AND sickleavehours <= 120),
    ADD CONSTRAINT ck_employee_vacationhours CHECK (vacationhours >= -40 AND vacationhours <= 240);

ALTER TABLE humanresources.employeedepartmenthistory 
    ADD CONSTRAINT ck_employeedepartmenthistory_enddate CHECK (enddate >= startdate OR enddate IS NULL);


ALTER TABLE humanresources.employeepayhistory 
    ADD CONSTRAINT ck_employeepayhistory_payfrequency CHECK (payfrequency IN (1, 2)),
    ADD CONSTRAINT ck_employeepayhistory_rate CHECK (rate >= 6.50 AND rate <= 200.00);


-- ==========================================
-- PERSON SCHEMA CONSTRAINTS
-- ==========================================
ALTER TABLE person.person 
    ADD CONSTRAINT ck_person_emailpromotion CHECK (emailpromotion >= 0 AND emailpromotion <= 2),
    ADD CONSTRAINT ck_person_persontype CHECK (persontype IS NULL OR UPPER(persontype::text) IN ('GC', 'SP', 'EM', 'IN', 'VC', 'SC'));

-- ==========================================
-- PRODUCTION SCHEMA CONSTRAINTS
-- ==========================================
ALTER TABLE production.document 
    ADD CONSTRAINT uq_document_rowguid UNIQUE (rowguid),
    ADD CONSTRAINT ck_document_status CHECK (status >= 1 AND status <= 3);

ALTER TABLE production.billofmaterials 
    ADD CONSTRAINT ck_billofmaterials_bomlevel CHECK ((productassemblyid IS NULL AND bomlevel = 0 AND perassemblyqty = 1.00) OR (productassemblyid IS NOT NULL AND bomlevel >= 1)),
    ADD CONSTRAINT ck_billofmaterials_enddate CHECK (enddate > startdate OR enddate IS NULL),
    ADD CONSTRAINT ck_billofmaterials_perassemblyqty CHECK (perassemblyqty >= 1.00),
    ADD CONSTRAINT ck_billofmaterials_productassemblyid CHECK (productassemblyid <> componentid);

ALTER TABLE production.location 
    ADD CONSTRAINT ck_location_availability CHECK (availability >= 0.00),
    ADD CONSTRAINT ck_location_costrate CHECK (costrate >= 0.00);

ALTER TABLE production.product 
    ADD CONSTRAINT ck_product_class CHECK (UPPER(class::text) IN ('H', 'M', 'L') OR class IS NULL),
    ADD CONSTRAINT ck_product_daystomanufacture CHECK (daystomanufacture >= 0),
    ADD CONSTRAINT ck_product_listprice CHECK (listprice >= 0.00),
    ADD CONSTRAINT ck_product_productline CHECK (UPPER(productline::text) IN ('R', 'M', 'T', 'S') OR productline IS NULL),
    ADD CONSTRAINT ck_product_reorderpoint CHECK (reorderpoint > 0),
    ADD CONSTRAINT ck_product_safetystocklevel CHECK (safetystocklevel > 0),
    ADD CONSTRAINT ck_product_sellenddate CHECK (sellenddate >= sellstartdate OR sellenddate IS NULL),
    ADD CONSTRAINT ck_product_standardcost CHECK (standardcost >= 0.00),
    ADD CONSTRAINT ck_product_style CHECK (UPPER(style::text) IN ('U', 'M', 'W') OR style IS NULL),
    ADD CONSTRAINT ck_product_weight CHECK (weight > 0.00);

ALTER TABLE production.productcosthistory 
    ADD CONSTRAINT ck_productcosthistory_enddate CHECK (enddate >= startdate OR enddate IS NULL),
    ADD CONSTRAINT ck_productcosthistory_standardcost CHECK (standardcost >= 0.00);

ALTER TABLE production.productinventory 
    ADD CONSTRAINT ck_productinventory_bin CHECK (bin >= 0 AND bin <= 100),
    -- Replaced T-SQL bracket LIKE syntax with a native PostgreSQL POSIX Regular Expression (~)
    ADD CONSTRAINT ck_productinventory_shelf CHECK (shelf ~ '^[A-Za-z]$' OR shelf = 'N/A');

ALTER TABLE production.productlistpricehistory 
    ADD CONSTRAINT ck_productlistpricehistory_enddate CHECK (enddate >= startdate OR enddate IS NULL),
    ADD CONSTRAINT ck_productlistpricehistory_listprice CHECK (listprice > 0.00);

ALTER TABLE production.productreview 
    ADD CONSTRAINT ck_productreview_rating CHECK (rating >= 1 AND rating <= 5);

ALTER TABLE production.transactionhistory 
    ADD CONSTRAINT ck_transactionhistory_transactiontype CHECK (UPPER(transactiontype::text) IN ('P', 'S', 'W'));

ALTER TABLE production.transactionhistoryarchive 
    ADD CONSTRAINT ck_transactionhistoryarchive_transactiontype CHECK (UPPER(transactiontype::text) IN ('P', 'S', 'W'));

ALTER TABLE production.workorder 
    ADD CONSTRAINT ck_workorder_enddate CHECK (enddate >= startdate OR enddate IS NULL),
    ADD CONSTRAINT ck_workorder_orderqty CHECK (orderqty > 0),
    ADD CONSTRAINT ck_workorder_scrappedqty CHECK (scrappedqty >= 0);

ALTER TABLE production.workorderrouting 
    ADD CONSTRAINT ck_workorderrouting_actualcost CHECK (actualcost > 0.00),
    ADD CONSTRAINT ck_workorderrouting_actualenddate CHECK (actualenddate >= actualstartdate OR actualenddate IS NULL OR actualstartdate IS NULL),
    ADD CONSTRAINT ck_workorderrouting_actualresourcehrs CHECK (actualresourcehrs >= 0.0000),
    ADD CONSTRAINT ck_workorderrouting_plannedcost CHECK (plannedcost > 0.00),
    ADD CONSTRAINT ck_workorderrouting_scheduledenddate CHECK (scheduledenddate >= scheduledstartdate);

-- ==========================================
-- PURCHASING SCHEMA CONSTRAINTS
-- ==========================================
ALTER TABLE purchasing.productvendor 
    ADD CONSTRAINT ck_productvendor_averageleadtime CHECK (averageleadtime >= 1),
    ADD CONSTRAINT ck_productvendor_lastreceiptcost CHECK (lastreceiptcost > 0.00),
    ADD CONSTRAINT ck_productvendor_maxorderqty CHECK (maxorderqty >= 1),
    ADD CONSTRAINT ck_productvendor_minorderqty CHECK (minorderqty >= 1),
    ADD CONSTRAINT ck_productvendor_onorderqty CHECK (onorderqty >= 0),
    ADD CONSTRAINT ck_productvendor_standardprice CHECK (standardprice > 0.00);

ALTER TABLE purchasing.purchaseorderdetail 
    ADD CONSTRAINT ck_purchaseorderdetail_orderqty CHECK (orderqty > 0),
    ADD CONSTRAINT ck_purchaseorderdetail_receivedqty CHECK (receivedqty >= 0.00),
    ADD CONSTRAINT ck_purchaseorderdetail_rejectedqty CHECK (rejectedqty >= 0.00),
    ADD CONSTRAINT ck_purchaseorderdetail_unitprice CHECK (unitprice >= 0.00);

ALTER TABLE purchasing.purchaseorderheader 
    ADD CONSTRAINT ck_purchaseorderheader_freight CHECK (freight >= 0.00),
    ADD CONSTRAINT ck_purchaseorderheader_shipdate CHECK (shipdate >= orderdate OR shipdate IS NULL),
    ADD CONSTRAINT ck_purchaseorderheader_status CHECK (status >= 1 AND status <= 4),
    ADD CONSTRAINT ck_purchaseorderheader_subtotal CHECK (subtotal >= 0.00),
    ADD CONSTRAINT ck_purchaseorderheader_taxamt CHECK (taxamt >= 0.00);

ALTER TABLE purchasing.shipmethod 
    ADD CONSTRAINT ck_shipmethod_shipbase CHECK (shipbase > 0.00),
    ADD CONSTRAINT ck_shipmethod_shiprate CHECK (shiprate > 0.00);

ALTER TABLE purchasing.vendor 
    ADD CONSTRAINT ck_vendor_creditrating CHECK (creditrating >= 1 AND creditrating <= 5);

-- ==========================================
-- SALES SCHEMA CONSTRAINTS
-- ==========================================
ALTER TABLE sales.salesorderdetail 
    ADD CONSTRAINT ck_salesorderdetail_orderqty CHECK (orderqty > 0),
    ADD CONSTRAINT ck_salesorderdetail_unitprice CHECK (unitprice >= 0.00),
    ADD CONSTRAINT ck_salesorderdetail_unitpricediscount CHECK (unitpricediscount >= 0.00);

ALTER TABLE sales.salesorderheader 
    ADD CONSTRAINT ck_salesorderheader_duedate CHECK (duedate >= orderdate),
    ADD CONSTRAINT ck_salesorderheader_freight CHECK (freight >= 0.00),
    ADD CONSTRAINT ck_salesorderheader_shipdate CHECK (shipdate >= orderdate OR shipdate IS NULL),
    ADD CONSTRAINT ck_salesorderheader_status CHECK (status >= 0 AND status <= 8),
    ADD CONSTRAINT ck_salesorderheader_subtotal CHECK (subtotal >= 0.00),
    ADD CONSTRAINT ck_salesorderheader_taxamt CHECK (taxamt >= 0.00);

ALTER TABLE sales.salesperson 
    ADD CONSTRAINT ck_salesperson_bonus CHECK (bonus >= 0.00);




SELECT 
    ns.nspname AS schema_name,
    rel.relname AS table_name,
    con.conname AS constraint_name,
    CASE 
        WHEN con.contype = 'c' THEN 'CHECK'
        WHEN con.contype = 'u' THEN 'UNIQUE'
        ELSE 'OTHER'
    END AS constraint_type,
    pg_get_constraintdef(con.oid) AS constraint_definition,
    con.convalidated AS is_valid
FROM pg_constraint con
INNER JOIN pg_namespace ns ON con.connamespace = ns.oid
INNER JOIN pg_class rel ON con.conrelid = rel.oid
WHERE ns.nspname IN ('sales', 'production', 'purchasing', 'humanresources', 'person')
  AND con.contype IN ('c', 'u')
ORDER BY schema_name, table_name, constraint_type;


