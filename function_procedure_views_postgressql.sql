-- --------------------------------------------------------------------
-- Index 
-- --------------------------------------------------------------------
-- Table: dbo.awbuildversion
CREATE UNIQUE INDEX awbuildversion_pkey ON dbo.awbuildversion USING btree (systeminformationid);

-- Table: dbo.errorlog
CREATE UNIQUE INDEX errorlog_pkey ON dbo.errorlog USING btree (errorlogid);


-- Table: humanresources.department
CREATE UNIQUE INDEX ak_department_name ON humanresources.department USING btree (name);
CREATE UNIQUE INDEX department_pkey ON humanresources.department USING btree (departmentid);

-- Table: humanresources.employee
CREATE INDEX ix_employee_organizationlevel_organizationnode ON humanresources.employee USING btree (organizationlevel, organizationnode);
CREATE INDEX ix_employee_organizationnode ON humanresources.employee USING btree (organizationnode);
CREATE UNIQUE INDEX ak_employee_loginid ON humanresources.employee USING btree (loginid);
CREATE UNIQUE INDEX ak_employee_nationalidnumber ON humanresources.employee USING btree (nationalidnumber);
CREATE UNIQUE INDEX ak_employee_rowguid ON humanresources.employee USING btree (rowguid);
CREATE UNIQUE INDEX employee_pkey ON humanresources.employee USING btree (businessentityid);

-- Table: humanresources.employeedepartmenthistory
CREATE INDEX ix_employeedepartmenthistory_departmentid ON humanresources.employeedepartmenthistory USING btree (departmentid);
CREATE INDEX ix_employeedepartmenthistory_shiftid ON humanresources.employeedepartmenthistory USING btree (shiftid);
CREATE UNIQUE INDEX employeedepartmenthistory_pkey ON humanresources.employeedepartmenthistory USING btree (businessentityid, departmentid, shiftid, startdate);

-- Table: humanresources.employeepayhistory
CREATE UNIQUE INDEX employeepayhistory_pkey ON humanresources.employeepayhistory USING btree (businessentityid, ratechangedate);

-- Table: humanresources.jobcandidate
CREATE INDEX ix_jobcandidate_businessentityid ON humanresources.jobcandidate USING btree (businessentityid);
CREATE INDEX ix_jobcandidate_resume_fts ON humanresources.jobcandidate USING gin (to_tsvector('english'::regconfig, COALESCE(resume, ''::text)));
CREATE UNIQUE INDEX jobcandidate_pkey ON humanresources.jobcandidate USING btree (jobcandidateid);

-- Table: humanresources.shift
CREATE UNIQUE INDEX ak_shift_name ON humanresources.shift USING btree (name);
CREATE UNIQUE INDEX ak_shift_starttime_endtime ON humanresources.shift USING btree (starttime, endtime);
CREATE UNIQUE INDEX shift_pkey ON humanresources.shift USING btree (shiftid);

-- Table: person.address
CREATE INDEX ix_address_stateprovinceid ON person.address USING btree (stateprovinceid);
CREATE UNIQUE INDEX address_pkey ON person.address USING btree (addressid);
CREATE UNIQUE INDEX ak_address_rowguid ON person.address USING btree (rowguid);
CREATE UNIQUE INDEX ix_address_addressline1_addressline2_city_stateprovinceid_posta ON person.address USING btree (addressline1, addressline2, city, stateprovinceid, postalcode);

-- Table: person.addresstype
CREATE UNIQUE INDEX addresstype_pkey ON person.addresstype USING btree (addresstypeid);
CREATE UNIQUE INDEX ak_addresstype_name ON person.addresstype USING btree (name);
CREATE UNIQUE INDEX ak_addresstype_rowguid ON person.addresstype USING btree (rowguid);

-- Table: person.businessentity
CREATE UNIQUE INDEX ak_businessentity_rowguid ON person.businessentity USING btree (rowguid);
CREATE UNIQUE INDEX businessentity_pkey ON person.businessentity USING btree (businessentityid);

-- Table: person.businessentityaddress
CREATE INDEX ix_businessentityaddress_addressid ON person.businessentityaddress USING btree (addressid);
CREATE INDEX ix_businessentityaddress_addresstypeid ON person.businessentityaddress USING btree (addresstypeid);
CREATE UNIQUE INDEX ak_businessentityaddress_rowguid ON person.businessentityaddress USING btree (rowguid);
CREATE UNIQUE INDEX businessentityaddress_pkey ON person.businessentityaddress USING btree (businessentityid, addressid, addresstypeid);

-- Table: person.businessentitycontact
CREATE INDEX ix_businessentitycontact_contacttypeid ON person.businessentitycontact USING btree (contacttypeid);
CREATE INDEX ix_businessentitycontact_personid ON person.businessentitycontact USING btree (personid);
CREATE UNIQUE INDEX ak_businessentitycontact_rowguid ON person.businessentitycontact USING btree (rowguid);
CREATE UNIQUE INDEX businessentitycontact_pkey ON person.businessentitycontact USING btree (businessentityid, personid, contacttypeid);

-- Table: person.contacttype
CREATE UNIQUE INDEX ak_contacttype_name ON person.contacttype USING btree (name);
CREATE UNIQUE INDEX contacttype_pkey ON person.contacttype USING btree (contacttypeid);

-- Table: person.countryregion
CREATE UNIQUE INDEX ak_countryregion_name ON person.countryregion USING btree (name);
CREATE UNIQUE INDEX countryregion_pkey ON person.countryregion USING btree (countryregioncode);

-- Table: person.emailaddress
CREATE INDEX ix_emailaddress_emailaddress ON person.emailaddress USING btree (emailaddress);
CREATE UNIQUE INDEX emailaddress_pkey ON person.emailaddress USING btree (businessentityid, emailaddressid);

-- Table: person.password
CREATE UNIQUE INDEX password_pkey ON person.password USING btree (businessentityid);

-- Table: person.person
CREATE INDEX ix_person_lastname_firstname_middlename ON person.person USING btree (lastname, firstname, middlename);
CREATE UNIQUE INDEX ak_person_rowguid ON person.person USING btree (rowguid);
CREATE UNIQUE INDEX person_pkey ON person.person USING btree (businessentityid);

-- Table: person.personphone
CREATE INDEX ix_personphone_phonenumber ON person.personphone USING btree (phonenumber);
CREATE UNIQUE INDEX personphone_pkey ON person.personphone USING btree (businessentityid, phonenumber, phonenumbertypeid);

-- Table: person.phonenumbertype
CREATE UNIQUE INDEX phonenumbertype_pkey ON person.phonenumbertype USING btree (phonenumbertypeid);

-- Table: person.stateprovince
CREATE UNIQUE INDEX ak_stateprovince_name ON person.stateprovince USING btree (name);
CREATE UNIQUE INDEX ak_stateprovince_rowguid ON person.stateprovince USING btree (rowguid);
CREATE UNIQUE INDEX ak_stateprovince_stateprovincecode_countryregioncode ON person.stateprovince USING btree (stateprovincecode, countryregioncode);
CREATE UNIQUE INDEX stateprovince_pkey ON person.stateprovince USING btree (stateprovinceid);

-- Table: production.billofmaterials
CREATE INDEX ix_billofmaterials_unitmeasurecode ON production.billofmaterials USING btree (unitmeasurecode);
CREATE UNIQUE INDEX ak_billofmaterials_productassemblyid_componentid_startdate ON production.billofmaterials USING btree (productassemblyid, componentid, startdate);
CREATE UNIQUE INDEX billofmaterials_pkey ON production.billofmaterials USING btree (billofmaterialsid);

-- Table: production.culture
CREATE UNIQUE INDEX ak_culture_name ON production.culture USING btree (name);
CREATE UNIQUE INDEX culture_pkey ON production.culture USING btree (cultureid);

-- Table: production.document
CREATE INDEX ix_document_filename_revision ON production.document USING btree (filename, revision);
CREATE UNIQUE INDEX ak_document_documentlevel_documentnode ON production.document USING btree (documentlevel, documentnode);
CREATE UNIQUE INDEX ak_document_rowguid ON production.document USING btree (rowguid);
CREATE UNIQUE INDEX document_pkey ON production.document USING btree (documentnode);

-- Table: production.illustration
CREATE UNIQUE INDEX illustration_pkey ON production.illustration USING btree (illustrationid);

-- Table: production.location
CREATE UNIQUE INDEX ak_location_name ON production.location USING btree (name);
CREATE UNIQUE INDEX location_pkey ON production.location USING btree (locationid);

-- Table: production.product
CREATE UNIQUE INDEX ak_product_name ON production.product USING btree (name);
CREATE UNIQUE INDEX ak_product_productnumber ON production.product USING btree (productnumber);
CREATE UNIQUE INDEX ak_product_rowguid ON production.product USING btree (rowguid);
CREATE UNIQUE INDEX product_pkey ON production.product USING btree (productid);

-- Table: production.productcategory
CREATE UNIQUE INDEX ak_productcategory_name ON production.productcategory USING btree (name);
CREATE UNIQUE INDEX ak_productcategory_rowguid ON production.productcategory USING btree (rowguid);
CREATE UNIQUE INDEX productcategory_pkey ON production.productcategory USING btree (productcategoryid);

-- Table: production.productcosthistory
CREATE UNIQUE INDEX productcosthistory_pkey ON production.productcosthistory USING btree (productid, startdate);

-- Table: production.productdescription
CREATE UNIQUE INDEX ak_productdescription_rowguid ON production.productdescription USING btree (rowguid);
CREATE UNIQUE INDEX productdescription_pkey ON production.productdescription USING btree (productdescriptionid);

-- Table: production.productdocument
CREATE UNIQUE INDEX productdocument_pkey ON production.productdocument USING btree (productid, documentnode);

-- Table: production.productinventory
CREATE UNIQUE INDEX productinventory_pkey ON production.productinventory USING btree (productid, locationid);

-- Table: production.productlistpricehistory
CREATE UNIQUE INDEX productlistpricehistory_pkey ON production.productlistpricehistory USING btree (productid, startdate);

-- Table: production.productmodel
CREATE UNIQUE INDEX ak_productmodel_name ON production.productmodel USING btree (name);
CREATE UNIQUE INDEX ak_productmodel_rowguid ON production.productmodel USING btree (rowguid);
CREATE UNIQUE INDEX productmodel_pkey ON production.productmodel USING btree (productmodelid);

-- Table: production.productmodelillustration
CREATE UNIQUE INDEX productmodelillustration_pkey ON production.productmodelillustration USING btree (productmodelid, illustrationid);

-- Table: production.productmodelproductdescriptionculture
CREATE UNIQUE INDEX productmodelproductdescriptionculture_pkey ON production.productmodelproductdescriptionculture USING btree (productmodelid, productdescriptionid, cultureid);

-- Table: production.productphoto
CREATE UNIQUE INDEX productphoto_pkey ON production.productphoto USING btree (productphotoid);

-- Table: production.productproductphoto
CREATE UNIQUE INDEX productproductphoto_pkey ON production.productproductphoto USING btree (productid, productphotoid);

-- Table: production.productreview
CREATE INDEX ix_productreview_productid_name ON production.productreview USING btree (productid, reviewername) INCLUDE (comments);
CREATE UNIQUE INDEX productreview_pkey ON production.productreview USING btree (productreviewid);

-- Table: production.productsubcategory
CREATE UNIQUE INDEX ak_productsubcategory_name ON production.productsubcategory USING btree (name);
CREATE UNIQUE INDEX ak_productsubcategory_rowguid ON production.productsubcategory USING btree (rowguid);
CREATE UNIQUE INDEX productsubcategory_pkey ON production.productsubcategory USING btree (productsubcategoryid);

-- Table: production.scrapreason
CREATE UNIQUE INDEX ak_scrapreason_name ON production.scrapreason USING btree (name);
CREATE UNIQUE INDEX scrapreason_pkey ON production.scrapreason USING btree (scrapreasonid);

-- Table: production.transactionhistory
CREATE INDEX ix_transactionhistory_productid ON production.transactionhistory USING btree (productid);
CREATE INDEX ix_transactionhistory_referenceorderid_referenceorderlineid ON production.transactionhistory USING btree (referenceorderid, referenceorderlineid);
CREATE UNIQUE INDEX transactionhistory_pkey ON production.transactionhistory USING btree (transactionid);

-- Table: production.transactionhistoryarchive
CREATE INDEX ix_transactionhistoryarchive_productid ON production.transactionhistoryarchive USING btree (productid);
CREATE INDEX ix_transactionhistoryarchive_referenceorderid_referenceorderlin ON production.transactionhistoryarchive USING btree (referenceorderid, referenceorderlineid);
CREATE UNIQUE INDEX transactionhistoryarchive_pkey ON production.transactionhistoryarchive USING btree (transactionid);

-- Table: production.unitmeasure
CREATE UNIQUE INDEX ak_unitmeasure_name ON production.unitmeasure USING btree (name);
CREATE UNIQUE INDEX unitmeasure_pkey ON production.unitmeasure USING btree (unitmeasurecode);

-- Table: production.workorder
CREATE INDEX ix_workorder_productid ON production.workorder USING btree (productid);
CREATE INDEX ix_workorder_scrapreasonid ON production.workorder USING btree (scrapreasonid);
CREATE UNIQUE INDEX workorder_pkey ON production.workorder USING btree (workorderid);

-- Table: production.workorderrouting
CREATE INDEX ix_workorderrouting_productid ON production.workorderrouting USING btree (productid);
CREATE UNIQUE INDEX workorderrouting_pkey ON production.workorderrouting USING btree (workorderid, productid, operationsequence);

-- Table: purchasing.productvendor
CREATE INDEX ix_productvendor_businessentityid ON purchasing.productvendor USING btree (businessentityid);
CREATE INDEX ix_productvendor_unitmeasurecode ON purchasing.productvendor USING btree (unitmeasurecode);
CREATE UNIQUE INDEX productvendor_pkey ON purchasing.productvendor USING btree (productid, businessentityid);

-- Table: purchasing.purchaseorderdetail
CREATE INDEX ix_purchaseorderdetail_productid ON purchasing.purchaseorderdetail USING btree (productid);
CREATE UNIQUE INDEX purchaseorderdetail_pkey ON purchasing.purchaseorderdetail USING btree (purchaseorderid, purchaseorderdetailid);

-- Table: purchasing.purchaseorderheader
CREATE INDEX ix_purchaseorderheader_employeeid ON purchasing.purchaseorderheader USING btree (employeeid);
CREATE INDEX ix_purchaseorderheader_vendorid ON purchasing.purchaseorderheader USING btree (vendorid);
CREATE UNIQUE INDEX purchaseorderheader_pkey ON purchasing.purchaseorderheader USING btree (purchaseorderid);

-- Table: purchasing.shipmethod
CREATE UNIQUE INDEX ak_shipmethod_name ON purchasing.shipmethod USING btree (name);
CREATE UNIQUE INDEX ak_shipmethod_rowguid ON purchasing.shipmethod USING btree (rowguid);
CREATE UNIQUE INDEX shipmethod_pkey ON purchasing.shipmethod USING btree (shipmethodid);

-- Table: purchasing.vendor
CREATE UNIQUE INDEX ak_vendor_accountnumber ON purchasing.vendor USING btree (accountnumber);
CREATE UNIQUE INDEX vendor_pkey ON purchasing.vendor USING btree (businessentityid);


-- Table: sales.countryregioncurrency
CREATE INDEX ix_countryregioncurrency_currencycode ON sales.countryregioncurrency USING btree (currencycode);
CREATE UNIQUE INDEX countryregioncurrency_pkey ON sales.countryregioncurrency USING btree (countryregioncode, currencycode);

-- Table: sales.creditcard
CREATE UNIQUE INDEX ak_creditcard_cardnumber ON sales.creditcard USING btree (cardnumber);
CREATE UNIQUE INDEX creditcard_pkey ON sales.creditcard USING btree (creditcardid);

-- Table: sales.currency
CREATE UNIQUE INDEX ak_currency_name ON sales.currency USING btree (name);
CREATE UNIQUE INDEX currency_pkey ON sales.currency USING btree (currencycode);

-- Table: sales.currencyrate
CREATE UNIQUE INDEX ak_currencyrate_currencyratedate_fromcurrencycode_tocurrencycod ON sales.currencyrate USING btree (currencyratedate, fromcurrencycode, tocurrencycode);
CREATE UNIQUE INDEX currencyrate_pkey ON sales.currencyrate USING btree (currencyrateid);

-- Table: sales.customer
CREATE INDEX ix_customer_territoryid ON sales.customer USING btree (territoryid);
CREATE UNIQUE INDEX ak_customer_accountnumber ON sales.customer USING btree (accountnumber);
CREATE UNIQUE INDEX ak_customer_rowguid ON sales.customer USING btree (rowguid);
CREATE UNIQUE INDEX customer_pkey ON sales.customer USING btree (customerid);

-- Table: sales.personcreditcard
CREATE UNIQUE INDEX personcreditcard_pkey ON sales.personcreditcard USING btree (businessentityid, creditcardid);

-- Table: sales.salesorderdetail
CREATE INDEX ix_salesorderdetail_productid ON sales.salesorderdetail USING btree (productid);
CREATE UNIQUE INDEX ak_salesorderdetail_rowguid ON sales.salesorderdetail USING btree (rowguid);
CREATE UNIQUE INDEX salesorderdetail_pkey ON sales.salesorderdetail USING btree (salesorderid, salesorderdetailid);

-- Table: sales.salesorderheader
CREATE INDEX ix_salesorderheader_customerid ON sales.salesorderheader USING btree (customerid);
CREATE INDEX ix_salesorderheader_salespersonid ON sales.salesorderheader USING btree (salespersonid);
CREATE UNIQUE INDEX ak_salesorderheader_rowguid ON sales.salesorderheader USING btree (rowguid);
CREATE UNIQUE INDEX ak_salesorderheader_salesordernumber ON sales.salesorderheader USING btree (salesordernumber);
CREATE UNIQUE INDEX salesorderheader_pkey ON sales.salesorderheader USING btree (salesorderid);

-- Table: sales.salesorderheadersalesreason
CREATE UNIQUE INDEX salesorderheadersalesreason_pkey ON sales.salesorderheadersalesreason USING btree (salesorderid, salesreasonid);

-- Table: sales.salesperson
CREATE UNIQUE INDEX ak_salesperson_rowguid ON sales.salesperson USING btree (rowguid);
CREATE UNIQUE INDEX salesperson_pkey ON sales.salesperson USING btree (businessentityid);

-- Table: sales.salespersonquotahistory
CREATE UNIQUE INDEX ak_salespersonquotahistory_rowguid ON sales.salespersonquotahistory USING btree (rowguid);
CREATE UNIQUE INDEX salespersonquotahistory_pkey ON sales.salespersonquotahistory USING btree (businessentityid, quotadate);

-- Table: sales.salesreason
CREATE UNIQUE INDEX salesreason_pkey ON sales.salesreason USING btree (salesreasonid);

-- Table: sales.salestaxrate
CREATE UNIQUE INDEX ak_salestaxrate_rowguid ON sales.salestaxrate USING btree (rowguid);
CREATE UNIQUE INDEX ak_salestaxrate_stateprovinceid_taxtype ON sales.salestaxrate USING btree (stateprovinceid, taxtype);
CREATE UNIQUE INDEX salestaxrate_pkey ON sales.salestaxrate USING btree (salestaxrateid);

-- Table: sales.salesterritory
CREATE UNIQUE INDEX ak_salesterritory_name ON sales.salesterritory USING btree (name);
CREATE UNIQUE INDEX ak_salesterritory_rowguid ON sales.salesterritory USING btree (rowguid);
CREATE UNIQUE INDEX salesterritory_pkey ON sales.salesterritory USING btree (territoryid);

-- Table: sales.salesterritoryhistory
CREATE UNIQUE INDEX ak_salesterritoryhistory_rowguid ON sales.salesterritoryhistory USING btree (rowguid);
CREATE UNIQUE INDEX salesterritoryhistory_pkey ON sales.salesterritoryhistory USING btree (businessentityid, territoryid, startdate);

-- Table: sales.shoppingcartitem
CREATE INDEX ix_shoppingcartitem_shoppingcartid_productid ON sales.shoppingcartitem USING btree (shoppingcartid, productid);
CREATE UNIQUE INDEX shoppingcartitem_pkey ON sales.shoppingcartitem USING btree (shoppingcartitemid);

-- Table: sales.specialoffer
CREATE UNIQUE INDEX ak_specialoffer_rowguid ON sales.specialoffer USING btree (rowguid);
CREATE UNIQUE INDEX specialoffer_pkey ON sales.specialoffer USING btree (specialofferid);

-- Table: sales.specialofferproduct
CREATE INDEX ix_specialofferproduct_productid ON sales.specialofferproduct USING btree (productid);
CREATE UNIQUE INDEX ak_specialofferproduct_rowguid ON sales.specialofferproduct USING btree (rowguid);
CREATE UNIQUE INDEX specialofferproduct_pkey ON sales.specialofferproduct USING btree (specialofferid, productid);

-- Table: sales.store
CREATE INDEX ix_store_salespersonid ON sales.store USING btree (salespersonid);
CREATE UNIQUE INDEX ak_store_rowguid ON sales.store USING btree (rowguid);
CREATE UNIQUE INDEX store_pkey ON sales.store USING btree (businessentityid);


-- -------------------------------------------------------------
-- View: humanresources.vemployee
-- ----------------------------------------------------------------
DROP VIEW IF EXISTS humanresources.vemployee CASCADE;

CREATE VIEW humanresources.vemployee AS 
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
FROM humanresources.employee e
JOIN person.person p ON p.businessentityid = e.businessentityid
JOIN person.businessentityaddress bea ON bea.businessentityid = e.businessentityid
JOIN person.address a ON a.addressid = bea.addressid
JOIN person.stateprovince sp ON sp.stateprovinceid = a.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = sp.countryregioncode
LEFT JOIN person.personphone pp ON pp.businessentityid = p.businessentityid
LEFT JOIN person.phonenumbertype pnt ON pp.phonenumbertypeid = pnt.phonenumbertypeid
LEFT JOIN person.emailaddress ea ON p.businessentityid = ea.businessentityid;


-- ------------------------------------------------------------
-- View: humanresources.vemployeedepartment
-- ------------------------------------------------------------
DROP VIEW IF EXISTS humanresources.vemployeedepartment CASCADE;

CREATE VIEW humanresources.vemployeedepartment AS 
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
FROM humanresources.employee e
JOIN person.person p ON p.businessentityid = e.businessentityid
JOIN humanresources.employeedepartmenthistory edh ON e.businessentityid = edh.businessentityid
JOIN humanresources.department d ON edh.departmentid = d.departmentid
WHERE edh.enddate IS NULL;


-- --------------------------------------------------------------------
-- View: humanresources.vemployeedepartmenthistory
-- -----------------------------------------------------------------------

DROP VIEW IF EXISTS humanresources.vemployeedepartmenthistory CASCADE;

CREATE VIEW humanresources.vemployeedepartmenthistory AS 
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
FROM humanresources.employee e
JOIN person.person p ON p.businessentityid = e.businessentityid
JOIN humanresources.employeedepartmenthistory edh ON e.businessentityid = edh.businessentityid
JOIN humanresources.department d ON edh.departmentid = d.departmentid
JOIN humanresources.shift s ON s.shiftid = edh.shiftid;


-- -------------------------------------------------------------
-- View: person.vstateprovincecountryregion
-- ------------------------------------------------------------

DROP VIEW IF EXISTS person.vstateprovincecountryregion CASCADE;

CREATE VIEW person.vstateprovincecountryregion AS 
SELECT 
    sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
FROM person.stateprovince sp
JOIN person.countryregion cr ON sp.countryregioncode = cr.countryregioncode;

-- --------------------------------------------------------------
-- View: production.vproductanddescription
-- ------------------------------------------------------------

DROP VIEW IF EXISTS production.vproductanddescription CASCADE;

CREATE VIEW production.vproductanddescription AS 
SELECT 
    p.productid,
    p.name,
    pm.name AS productmodel,
    pmx.cultureid,
    pd.description
FROM production.product p
JOIN production.productmodel pm ON p.productmodelid = pm.productmodelid
JOIN production.productmodelproductdescriptionculture pmx ON pm.productmodelid = pmx.productmodelid
JOIN production.productdescription pd ON pmx.productdescriptionid = pd.productdescriptionid;

-- -----------------------------------------------------------------
-- View: purchasing.vvendorwithaddresses
-- ----------------------------------------------------------------
DROP VIEW IF EXISTS purchasing.vvendorwithaddresses CASCADE;

CREATE VIEW purchasing.vvendorwithaddresses AS 
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
FROM purchasing.vendor v
JOIN person.businessentityaddress bea ON bea.businessentityid = v.businessentityid
JOIN person.address a ON a.addressid = bea.addressid
JOIN person.stateprovince sp ON sp.stateprovinceid = a.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = sp.countryregioncode
JOIN person.addresstype at ON at.addresstypeid = bea.addresstypeid;


-- ------------------------------------------------------------------------
-- View: purchasing.vvendorwithcontacts
-- ----------------------------------------------------------------------
DROP VIEW IF EXISTS purchasing.vvendorwithcontacts CASCADE;

CREATE VIEW purchasing.vvendorwithcontacts AS 
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
FROM purchasing.vendor v
JOIN person.businessentitycontact bec ON bec.businessentityid = v.businessentityid
JOIN person.contacttype ct ON ct.contacttypeid = bec.contacttypeid
JOIN person.person p ON p.businessentityid = bec.personid
LEFT JOIN person.emailaddress ea ON ea.businessentityid = p.businessentityid
LEFT JOIN person.personphone pp ON pp.businessentityid = p.businessentityid
LEFT JOIN person.phonenumbertype pnt ON pnt.phonenumbertypeid = pp.phonenumbertypeid;

-- --------------------------------------------------------------------------
-- View: sales.vindividualcustomer
-- -----------------------------------------------------------------------
DROP VIEW IF EXISTS sales.vindividualcustomer CASCADE;

CREATE VIEW sales.vindividualcustomer AS 
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
FROM person.person p
JOIN person.businessentityaddress bea ON bea.businessentityid = p.businessentityid
JOIN person.address a ON a.addressid = bea.addressid
JOIN person.stateprovince sp ON sp.stateprovinceid = a.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = sp.countryregioncode
JOIN person.addresstype at ON at.addresstypeid = bea.addresstypeid
JOIN sales.customer c ON c.personid = p.businessentityid
LEFT JOIN person.emailaddress ea ON ea.businessentityid = p.businessentityid
LEFT JOIN person.personphone pp ON pp.businessentityid = p.businessentityid
LEFT JOIN person.phonenumbertype pnt ON pnt.phonenumbertypeid = pp.phonenumbertypeid
WHERE c.storeid IS NULL;


-- ---------------------------------------------------------------------
-- View: sales.vsalesperson
-- --------------------------------------------------------------------
DROP VIEW IF EXISTS sales.vsalesperson CASCADE;

CREATE VIEW sales.vsalesperson AS 
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
    st.group AS territorygroup,
    s.salesquota,
    s.salesytd,
    s.saleslastyear
FROM sales.salesperson s
JOIN humanresources.employee e ON e.businessentityid = s.businessentityid
JOIN person.person p ON p.businessentityid = s.businessentityid
JOIN person.businessentityaddress bea ON bea.businessentityid = s.businessentityid
JOIN person.address a ON a.addressid = bea.addressid
JOIN person.stateprovince sp ON sp.stateprovinceid = a.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = sp.countryregioncode
LEFT JOIN sales.salesterritory st ON st.territoryid = s.territoryid
LEFT JOIN person.emailaddress ea ON ea.businessentityid = p.businessentityid
LEFT JOIN person.personphone pp ON pp.businessentityid = p.businessentityid
LEFT JOIN person.phonenumbertype pnt ON pnt.phonenumbertypeid = pp.phonenumbertypeid;


-- -------------------------------------------------------------------------
-- View: sales.vstorewithaddresses
-- -------------------------------------------------------------------------
DROP VIEW IF EXISTS sales.vstorewithaddresses CASCADE;

CREATE VIEW sales.vstorewithaddresses AS 
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
FROM sales.store s
JOIN person.businessentityaddress bea ON bea.businessentityid = s.businessentityid
JOIN person.address a ON a.addressid = bea.addressid
JOIN person.stateprovince sp ON sp.stateprovinceid = a.stateprovinceid
JOIN person.countryregion cr ON cr.countryregioncode = sp.countryregioncode
JOIN person.addresstype at ON at.addresstypeid = bea.addresstypeid;


-- ------------------------------------------------------------------------
-- View: sales.vstorewithcontacts
-- -----------------------------------------------------------------------

DROP VIEW IF EXISTS sales.vstorewithcontacts CASCADE;

CREATE VIEW sales.vstorewithcontacts AS 
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
FROM sales.store s
JOIN person.businessentitycontact bec ON bec.businessentityid = s.businessentityid
JOIN person.contacttype ct ON ct.contacttypeid = bec.contacttypeid
JOIN person.person p ON p.businessentityid = bec.personid
LEFT JOIN person.emailaddress ea ON ea.businessentityid = p.businessentityid
LEFT JOIN person.personphone pp ON pp.businessentityid = p.businessentityid
LEFT JOIN person.phonenumbertype pnt ON pnt.phonenumbertypeid = pp.phonenumbertypeid;

-- ------------------------------------------------------------------------
--FUNCTION AND PROCEDURE 
-- --------------------------------------------------------------------------

--FUNCTION dbo.ufngetaccountingenddate

CREATE OR REPLACE FUNCTION dbo.ufngetaccountingenddate()
 RETURNS timestamp without time zone
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN TO_TIMESTAMP('20040701', 'YYYYMMDD')
           - INTERVAL '2 milliseconds';
END;
$function$;


-- FUNCTION: dbo.ufngetaccountingstartdate

CREATE OR REPLACE FUNCTION dbo.ufngetaccountingstartdate()
 RETURNS timestamp without time zone
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN TIMESTAMP '2003-07-01 00:00:00';
END;
$function$;


-- FUNCTION: dbo.ufngetcontactinformation

CREATE OR REPLACE FUNCTION dbo.ufngetcontactinformation(p_personid integer)
 RETURNS TABLE(personid integer, firstname character varying, lastname character varying, jobtitle character varying, businessentitytype character varying)
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF p_personid IS NOT NULL THEN

        -- Employee
        IF EXISTS (
            SELECT 1
            FROM humanresources.employee e
            WHERE e.businessentityid = p_personid
        ) THEN
            RETURN QUERY
            SELECT
                p_personid,
                p.firstname,
                p.lastname,
                e.jobtitle,
                'Employee'::varchar
            FROM humanresources.employee e
            INNER JOIN person.person p ON p.businessentityid = e.businessentityid
            WHERE e.businessentityid = p_personid;

        -- Vendor Contact
        ELSIF EXISTS (
            SELECT 1
            FROM purchasing.vendor v
            INNER JOIN person.businessentitycontact bec ON bec.businessentityid = v.businessentityid
            WHERE bec.personid = p_personid
        ) THEN
            RETURN QUERY
            SELECT
                p_personid,
                p.firstname,
                p.lastname,
                ct.name,
                'Vendor Contact'::varchar
            FROM purchasing.vendor v
            INNER JOIN person.businessentitycontact bec ON bec.businessentityid = v.businessentityid
            INNER JOIN person.contacttype ct ON ct.contacttypeid = bec.contacttypeid
            INNER JOIN person.person p ON p.businessentityid = bec.personid
            WHERE bec.personid = p_personid;

        -- Store Contact
        ELSIF EXISTS (
            SELECT 1
            FROM sales.store s
            INNER JOIN person.businessentitycontact bec ON bec.businessentityid = s.businessentityid
            WHERE bec.personid = p_personid
        ) THEN
            RETURN QUERY
            SELECT
                p_personid,
                p.firstname,
                p.lastname,
                ct.name,
                'Store Contact'::varchar
            FROM sales.store s
            INNER JOIN person.businessentitycontact bec ON bec.businessentityid = s.businessentityid
            INNER JOIN person.contacttype ct ON ct.contacttypeid = bec.contacttypeid
            INNER JOIN person.person p ON p.businessentityid = bec.personid
            WHERE bec.personid = p_personid;

        -- Consumer
        ELSIF EXISTS (
            SELECT 1
            FROM person.person p
            INNER JOIN sales.customer c ON c.personid = p.businessentityid
            WHERE p.businessentityid = p_personid AND c.storeid IS NULL
        ) THEN
            RETURN QUERY
            SELECT
                p_personid,
                p.firstname,
                p.lastname,
                NULL::varchar,
                'Consumer'::varchar
            FROM person.person p
            INNER JOIN sales.customer c ON c.personid = p.businessentityid
            WHERE p.businessentityid = p_personid AND c.storeid IS NULL;
        END IF;

    END IF;
    RETURN;
END;
$function$;


-- FUNCTION: dbo.ufngetdocumentstatustext

CREATE OR REPLACE FUNCTION dbo.ufngetdocumentstatustext(p_status integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN CASE p_status
        WHEN 1 THEN 'Pending approval'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Obsolete'
        ELSE '** Invalid **'
    END;
END;
$function$;


-- FUNCTION: dbo.ufngetproductdealerprice

CREATE OR REPLACE FUNCTION dbo.ufngetproductdealerprice(p_productid integer, p_orderdate timestamp with time zone)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_dealerprice numeric(19,4);
BEGIN

    SELECT plph.listprice * 0.60
    INTO v_dealerprice
    FROM production.product p
    INNER JOIN production.productlistpricehistory plph
        ON p.productid = plph.productid
    WHERE p.productid = p_productid
      AND p_orderdate BETWEEN plph.startdate
                          AND COALESCE(
                                plph.enddate,
                                TIMESTAMPTZ '9999-12-31'
                              )
    LIMIT 1;

    RETURN v_dealerprice;

END;
$function$


-- FUNCTION: dbo.ufngetproductlistprice

CREATE OR REPLACE FUNCTION dbo.ufngetproductlistprice(p_productid integer, p_orderdate timestamp with time zone)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_listprice numeric(19,4);
BEGIN
    SELECT plph.listprice
    INTO v_listprice
    FROM production.product p
    INNER JOIN production.productlistpricehistory plph ON p.productid = plph.productid
    WHERE p.productid = p_productid
      AND p_orderdate BETWEEN plph.startdate AND COALESCE(plph.enddate, TIMESTAMPTZ '9999-12-31')
    LIMIT 1;

    RETURN v_listprice;
END;
$function$;


-- FUNCTION: dbo.ufngetproductstandardcost

CREATE OR REPLACE FUNCTION dbo.ufngetproductstandardcost(p_productid integer, p_orderdate timestamp with time zone)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_standardcost numeric(19,4);
BEGIN
    SELECT pch.standardcost
    INTO v_standardcost
    FROM production.product p
    INNER JOIN production.productcosthistory pch ON p.productid = pch.productid
    WHERE p.productid = p_productid
      AND p_orderdate BETWEEN pch.startdate AND COALESCE(pch.enddate, TIMESTAMPTZ '9999-12-31')
    LIMIT 1;

    RETURN v_standardcost;
END;
$function$;


-- FUNCTION: dbo.ufngetpurchaseorderstatustext

CREATE OR REPLACE FUNCTION dbo.ufngetpurchaseorderstatustext(p_status smallint)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN CASE p_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Complete'
        ELSE '** Invalid **'
    END;
END;
$function$;


-- FUNCTION: dbo.ufngetsalesorderstatustext

CREATE OR REPLACE FUNCTION dbo.ufngetsalesorderstatustext(p_status smallint)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN CASE p_status
        WHEN 1 THEN 'In process'
        WHEN 2 THEN 'Approved'
        WHEN 3 THEN 'Backordered'
        WHEN 4 THEN 'Rejected'
        WHEN 5 THEN 'Shipped'
        WHEN 6 THEN 'Cancelled'
        ELSE '** Invalid **'
    END;
END;
$function$;


-- FUNCTION: dbo.ufngetstock


CREATE OR REPLACE FUNCTION dbo.ufngetstock(p_productid integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_ret integer;
BEGIN
    SELECT COALESCE(SUM(quantity), 0)
    INTO v_ret
    FROM production.productinventory
    WHERE productid = p_productid;

    RETURN v_ret;
END;
$function$;


-- FUNCTION: dbo.ufnleadingzeros

CREATE OR REPLACE FUNCTION dbo.ufnleadingzeros(p_value integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN LPAD(p_value::text, 8, '0');
END;
$function$;


-- FUNCTION: dbo.uspgetbillofmaterials

CREATE OR REPLACE FUNCTION dbo.uspgetbillofmaterials(p_startproductid integer, p_checkdate timestamp with time zone)
 RETURNS TABLE(productassemblyid integer, componentid integer, componentdesc character varying, totalquantity numeric, standardcost numeric, listprice numeric, bomlevel integer, recursionlevel integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    WITH RECURSIVE bom_cte (
        productassemblyid,
        componentid,
        componentdesc,
        perassemblyqty,
        standardcost,
        listprice,
        bomlevel,
        recursionlevel
    ) AS (
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name::varchar(50),
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel::integer,
            0
        FROM production.billofmaterials b
        INNER JOIN production.product p ON b.componentid = p.productid
        WHERE b.productassemblyid = p_startproductid
          AND p_checkdate >= b.startdate
          AND p_checkdate <= COALESCE(b.enddate, p_checkdate)
        UNION ALL
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name::varchar(50),
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel::integer,
            cte.recursionlevel + 1
        FROM bom_cte cte
        INNER JOIN production.billofmaterials b ON b.productassemblyid = cte.componentid
        INNER JOIN production.product p ON b.componentid = p.productid
        WHERE p_checkdate >= b.startdate
          AND p_checkdate <= COALESCE(b.enddate, p_checkdate)
          AND cte.recursionlevel < 25
    )
    SELECT
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        SUM(b.perassemblyqty),
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
END;
$function$;


-- FUNCTION: dbo.uspgetwhereusedproductid

CREATE OR REPLACE FUNCTION dbo.uspgetwhereusedproductid(p_startproductid integer, p_checkdate timestamp with time zone)
 RETURNS TABLE(productassemblyid integer, componentid integer, componentdesc character varying, totalquantity numeric, standardcost numeric, listprice numeric, bomlevel integer, recursionlevel integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    WITH RECURSIVE bom_cte AS (
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name::varchar(50),
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            0
        FROM production.billofmaterials b
        INNER JOIN production.product p ON b.productassemblyid = p.productid
        WHERE b.componentid = p_startproductid
          AND p_checkdate >= b.startdate
          AND p_checkdate <= COALESCE(b.enddate, p_checkdate)
        UNION ALL
        SELECT
            b.productassemblyid,
            b.componentid,
            p.name::varchar(50),
            b.perassemblyqty,
            p.standardcost,
            p.listprice,
            b.bomlevel,
            cte.recursionlevel + 1
        FROM bom_cte cte
        INNER JOIN production.billofmaterials b ON cte.productassemblyid = b.componentid
        INNER JOIN production.product p ON b.productassemblyid = p.productid
        WHERE p_checkdate >= b.startdate
          AND p_checkdate <= COALESCE(b.enddate, p_checkdate)
          AND cte.recursionlevel < 25
    )
    SELECT
        b.productassemblyid,
        b.componentid,
        b.componentdesc,
        SUM(b.perassemblyqty),
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
END;
$function$;


-- FUNCTION: dbo.usplogerror

CREATE OR REPLACE PROCEDURE dbo.usplogerror(INOUT p_errorlogid integer DEFAULT 0)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    INSERT INTO dbo.errorlog (
        username, errornumber, errorseverity, errorstate, errorprocedure, errorline, errormessage
    )
    VALUES (
        CURRENT_USER, 0, 0, 0, '', 0, SQLERRM
    )
    RETURNING errorlogid INTO p_errorlogid;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred in usplogerror: %', SQLERRM;
END;
$procedure$;


CREATE OR REPLACE PROCEDURE dbo.usplogerror(IN p_errormessage text, INOUT p_errorlogid integer DEFAULT 0)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    INSERT INTO dbo.errorlog (
        username, errornumber, errorseverity, errorstate, errorprocedure, errorline, errormessage
    )
    VALUES (
        CURRENT_USER, 0, 0, 0, '', 0, p_errormessage
    )
    RETURNING errorlogid INTO p_errorlogid;
END;
$procedure$;


-- FUNCTION: dbo.uspprinterror


CREATE OR REPLACE PROCEDURE dbo.uspprinterror(IN p_message text)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Error: %', p_message;
END;
$procedure$;


-- FUNCTION: dbo.uspprinterror

CREATE OR REPLACE PROCEDURE dbo.uspprinterror()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    RAISE NOTICE 'Error: %', SQLERRM;
END;
$procedure$;


-- FUNCTION: dbo.uspsearchcandidateresumes


CREATE OR REPLACE FUNCTION dbo.uspsearchcandidateresumes(p_searchstring text)
 RETURNS TABLE(jobcandidateid integer, rank real)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT
        jc.jobcandidateid,
        ts_rank(
            to_tsvector('english', COALESCE(jc.resume::text, '')),
            plainto_tsquery('english', p_searchstring)
        ) AS rank
    FROM humanresources.jobcandidate jc
    WHERE to_tsvector('english', COALESCE(jc.resume::text, '')) @@ plainto_tsquery('english', p_searchstring)
    ORDER BY rank DESC;
END;
$function$;


-- FUNCTION: humanresources.fn_demployee

CREATE OR REPLACE FUNCTION humanresources.fn_demployee()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    RAISE EXCEPTION 'Employees cannot be deleted. They can only be marked as not current.';
    RETURN NULL;
END;
$function$;


-- FUNCTION: humanresources.uspupdateemployeehireinfo

CREATE OR REPLACE PROCEDURE humanresources.uspupdateemployeehireinfo(IN p_businessentityid integer, IN p_jobtitle text, IN p_hiredate timestamp with time zone, IN p_ratechangedate timestamp with time zone, IN p_rate numeric, IN p_payfrequency integer, IN p_currentflag boolean)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE humanresources.employee
    SET
        jobtitle = p_jobtitle,
        hiredate = p_hiredate,
        currentflag = p_currentflag
    WHERE businessentityid = p_businessentityid;

    INSERT INTO humanresources.employeepayhistory (
        businessentityid,
        ratechangedate,
        rate,
        payfrequency
    )
    VALUES (
        p_businessentityid,
        p_ratechangedate,
        p_rate,
        p_payfrequency
    );
EXCEPTION
    WHEN OTHERS THEN
        CALL dbo.usplogerror();
        RAISE;
END;
$procedure$;


-- FUNCTION: humanresources.uspupdateemployeelogin

CREATE OR REPLACE PROCEDURE humanresources.uspupdateemployeelogin(IN p_businessentityid integer, IN p_organizationnode text, IN p_loginid text, IN p_jobtitle text, IN p_hiredate timestamp with time zone, IN p_currentflag boolean)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE humanresources.employee
    SET
        organizationnode = p_organizationnode,
        loginid = p_loginid,
        jobtitle = p_jobtitle,
        hiredate = p_hiredate,
        currentflag = p_currentflag
    WHERE businessentityid = p_businessentityid;
EXCEPTION
    WHEN OTHERS THEN
        CALL dbo.usplogerror();
        RAISE;
END;
$procedure$;


-- FUNCTION: humanresources.uspupdateemployeepersonalinfo

CREATE OR REPLACE PROCEDURE humanresources.uspupdateemployeepersonalinfo(IN p_businessentityid integer, IN p_nationalidnumber character varying, IN p_birthdate timestamp with time zone, IN p_maritalstatus character, IN p_gender character)
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE humanresources.employee
    SET
        nationalidnumber = p_nationalidnumber,
        birthdate = p_birthdate,
        maritalstatus = p_maritalstatus,
        gender = p_gender
    WHERE businessentityid = p_businessentityid;
EXCEPTION
    WHEN OTHERS THEN
        CALL dbo.usplogerror();
        RAISE;
END;
$procedure$;


-- FUNCTION: person.iu_person_func

CREATE OR REPLACE FUNCTION person.iu_person_func()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF NEW.demographics IS NULL THEN
        NEW.demographics :=
        XMLPARSE(DOCUMENT '
        <IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey">
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD>
        </IndividualSurvey>');
    ELSIF NOT xpath_exists(
        '/ns:IndividualSurvey/ns:TotalPurchaseYTD',
        NEW.demographics,
        ARRAY[
            ARRAY[
                'ns',
                'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey'
            ]
        ]
    ) THEN
        NEW.demographics :=
        XMLPARSE(DOCUMENT '
        <IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey">
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD>
        </IndividualSurvey>');
    END IF;

    RETURN NEW;
END;
$function$;


-- FUNCTION: production.fn_iworkorder

CREATE OR REPLACE FUNCTION production.fn_iworkorder()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO production.transactionhistory (
        productid, referenceorderid, transactiontype, transactiondate, quantity, actualcost
    )
    VALUES (
        NEW.productid, NEW.workorderid, 'W', CURRENT_TIMESTAMP, NEW.orderqty, 0
    );
    RETURN NEW;
END;
$function$;


-- FUNCTION: production.fn_uworkorder()

CREATE OR REPLACE FUNCTION production.fn_uworkorder()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF OLD.productid IS DISTINCT FROM NEW.productid OR OLD.orderqty IS DISTINCT FROM NEW.orderqty THEN
        INSERT INTO production.transactionhistory (
            productid, referenceorderid, transactiontype, transactiondate, quantity
        )
        VALUES (
            NEW.productid, NEW.workorderid, 'W', CURRENT_TIMESTAMP, NEW.orderqty
        );
    END IF;
    RETURN NEW;
END;
$function$;


-- FUNCTION: purchasing.fn_dvendor

CREATE OR REPLACE FUNCTION purchasing.fn_dvendor()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    RAISE EXCEPTION 'Vendors cannot be deleted. They can only be marked as not active.';
    RETURN NULL;
END;
$function$;



-- FUNCTION: purchasing.fn_ipurchaseorderdetail()

CREATE OR REPLACE FUNCTION purchasing.fn_ipurchaseorderdetail()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO production.transactionhistory (
        productid, referenceorderid, referenceorderlineid, transactiontype, transactiondate, quantity, actualcost
    )
    VALUES (
        NEW.productid, NEW.purchaseorderid, NEW.purchaseorderdetailid, 'P', CURRENT_TIMESTAMP, NEW.orderqty, NEW.unitprice
    );

    UPDATE purchasing.purchaseorderheader poh
    SET subtotal = (
        SELECT COALESCE(SUM(pod.linetotal), 0)
        FROM purchasing.purchaseorderdetail pod
        WHERE pod.purchaseorderid = poh.purchaseorderid
    )
    WHERE poh.purchaseorderid = NEW.purchaseorderid;

    RETURN NEW;
END;
$function$;


-- FUNCTION: purchasing.fn_upurchaseorderdetail()

CREATE OR REPLACE FUNCTION purchasing.fn_upurchaseorderdetail()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF OLD.productid IS DISTINCT FROM NEW.productid
       OR OLD.orderqty IS DISTINCT FROM NEW.orderqty
       OR OLD.unitprice IS DISTINCT FROM NEW.unitprice THEN

        INSERT INTO production.transactionhistory (
            productid, referenceorderid, referenceorderlineid, transactiontype, transactiondate, quantity, actualcost
        )
        VALUES (
            NEW.productid, NEW.purchaseorderid, NEW.purchaseorderdetailid, 'P', CURRENT_TIMESTAMP, NEW.orderqty, NEW.unitprice
        );

        UPDATE purchasing.purchaseorderheader poh
        SET subtotal = (
            SELECT COALESCE(SUM(pod.linetotal), 0)
            FROM purchasing.purchaseorderdetail pod
            WHERE pod.purchaseorderid = poh.purchaseorderid
        )
        WHERE poh.purchaseorderid = NEW.purchaseorderid;

    END IF;

    NEW.modifieddate := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$function$;


-- FUNCTION: purchasing.fn_upurchaseorderheader()

CREATE OR REPLACE FUNCTION purchasing.fn_upurchaseorderheader()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        NEW.revisionnumber := OLD.revisionnumber + 1;
    END IF;

    NEW.modifieddate := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$function$;


-- FUNCTION: sales.fn_usalesorderheader()

CREATE OR REPLACE FUNCTION sales.fn_usalesorderheader()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_startdate timestamp without time zone;
    v_enddate   timestamp without time zone;
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        NEW.revisionnumber := OLD.revisionnumber + 1;
    END IF;

    IF OLD.subtotal IS DISTINCT FROM NEW.subtotal THEN
        v_startdate := dbo.ufngetaccountingstartdate();
        v_enddate   := dbo.ufngetaccountingenddate();

        UPDATE sales.salesperson sp
        SET salesytd = (
            SELECT COALESCE(SUM(soh.subtotal), 0)
            FROM sales.salesorderheader soh
            WHERE soh.salespersonid = sp.businessentityid
              AND soh.status = 5
              AND soh.orderdate BETWEEN v_startdate AND v_enddate
        )
        WHERE sp.businessentityid = NEW.salespersonid
          AND NEW.orderdate BETWEEN v_startdate AND v_enddate;

        UPDATE sales.salesterritory st
        SET salesytd = (
            SELECT COALESCE(SUM(soh.subtotal), 0)
            FROM sales.salesorderheader soh
            WHERE soh.territoryid = st.territoryid
              AND soh.status = 5
              AND soh.orderdate BETWEEN v_startdate AND v_enddate
        )
        WHERE st.territoryid = NEW.territoryid
          AND NEW.orderdate BETWEEN v_startdate AND v_enddate;

    END IF;

    NEW.modifieddate := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$function$;



-- FUNCTION: sales.idu_salesorderdetail_func()

CREATE OR REPLACE FUNCTION sales.idu_salesorderdetail_func()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    -- INSERT / UPDATE
    IF TG_OP IN ('INSERT', 'UPDATE') THEN
        INSERT INTO production.transactionhistory (
            productid, referenceorderid, referenceorderlineid, transactiontype, transactiondate, quantity, actualcost
        )
        VALUES (
            NEW.productid, NEW.salesorderid, NEW.salesorderdetailid, 'S', CURRENT_TIMESTAMP, NEW.orderqty, NEW.unitprice
        );

        UPDATE sales.salesorderheader soh
        SET subtotal = (
            SELECT COALESCE(SUM(sod.linetotal), 0)
            FROM sales.salesorderdetail sod
            WHERE sod.salesorderid = soh.salesorderid
        )
        WHERE soh.salesorderid = NEW.salesorderid;
    END IF;

    -- DELETE
    IF TG_OP = 'DELETE' THEN
        UPDATE sales.salesorderheader soh
        SET subtotal = (
            SELECT COALESCE(SUM(sod.linetotal), 0)
            FROM sales.salesorderdetail sod
            WHERE sod.salesorderid = soh.salesorderid
        )
        WHERE soh.salesorderid = OLD.salesorderid;

        RETURN OLD;
    END IF;

    RETURN NEW;
END;
$function$;