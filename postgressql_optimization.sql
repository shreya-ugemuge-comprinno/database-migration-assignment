-- =============== POSTGRES SQL ===================

-- 1 

EXPLAIN (ANALYZE, BUFFERS, TIMING, COSTS)
SELECT
    soh.salesorderid,
    soh.orderdate,
    p.name AS product_name,
    ps.name AS subcategory_name,
    pc.name AS category_name,
    sod.orderqty,
    sod.unitprice,
    (sod.orderqty * sod.unitprice) AS line_total,
    cr.name AS country_region,
    sp.name AS state_province
FROM sales.salesorderheader soh
JOIN sales.salesorderdetail sod ON soh.salesorderid = sod.salesorderid
JOIN production.product p ON sod.productid = p.productid
LEFT JOIN production.productsubcategory ps ON p.productsubcategoryid = ps.productsubcategoryid
LEFT JOIN production.productcategory pc ON ps.productcategoryid = pc.productcategoryid
JOIN sales.customer c ON soh.customerid = c.customerid
JOIN person.person per ON c.personid = per.businessentityid
JOIN person.businessentityaddress bea ON per.businessentityid = bea.businessentityid
JOIN person.address a ON bea.addressid = a.addressid
JOIN person.stateprovince sp ON a.stateprovinceid = sp.stateprovinceid
JOIN person.countryregion cr ON sp.countryregioncode = cr.countryregioncode
WHERE soh.orderdate BETWEEN '2011-05-01 00:00:00' AND '2012-05-01 23:59:59'
ORDER BY line_total DESC, soh.orderdate ASC;

/* BASELINE EXPLAIN ANALYZE CRITICAL SNIPPETS:
Planning Time: 2.788 ms
Execution Time: 3.296 ms
Sort Method: quicksort  Memory: 25kB  Buffers: shared hit=768
->  Seq Scan on salesorderheader soh  (cost=0.00..1239.97 rows=1 width=16)
      Filter: ((orderdate >= '2011-05-01'::timestamp) AND (orderdate <= '2012-05-01'::timestamp))
      Rows Removed by Filter: 31465
*/




-- OPTIMIZATION 



-- 1. Calibrate statistics depth for skewed dates
ALTER TABLE sales.salesorderheader ALTER COLUMN orderdate SET STATISTICS 1000;
ANALYZE sales.salesorderheader;

-- 2. Expand operational memory boundaries for sorting routines
SET work_mem = '64MB';

-- 3. Provision the targeted covering composite index 
CREATE INDEX IF NOT EXISTS idx_salesorderheader_orderdate_perf
ON sales.salesorderheader (orderdate)
INCLUDE (salesorderid, customerid);



/* OPTIMIZED EXPLAIN ANALYZE CRITICAL SNIPPETS:
Planning Time: 4.441 ms
Execution Time: 0.105 ms
Sort Method: quicksort  Memory: 25kB  Buffers: shared hit=2
->  Index Only Scan using idx_salesorderheader_orderdate_perf on salesorderheader soh  (cost=0.29..8.31 rows=1 width=16)
      Index Cond: ((orderdate >= '2011-05-01'::timestamp) AND (orderdate <= '2012-05-01'::timestamp))
      Heap Fetches: 0
*/


-- 2. 
-- before


EXPLAIN (ANALYZE, BUFFERS, TIMING, COSTS)
SELECT 
    p.productid,
    p.name AS product_name,
    p.productnumber,
    pi.shelf,
    pi.bin,
    SUM(pi.quantity) AS current_inventory_stock,
    COUNT(th.transactionid) AS total_transactions_logged,
    AVG(th.actualcost) AS average_transaction_cost
FROM production.product p
JOIN production.productinventory pi ON p.productid = pi.productid
LEFT JOIN production.transactionhistory th ON p.productid = th.productid
WHERE p.safetystocklevel > 500
  AND th.transactiondate BETWEEN '2013-01-01 00:00:00' AND '2013-12-31 23:59:59'
GROUP BY p.productid, p.name, p.productnumber, pi.shelf, pi.bin
ORDER BY current_inventory_stock DESC, average_transaction_cost ASC;

/* BASELINE ACTUAL EXPLAIN ANALYZE OUTPUT:
Planning Time: 1.666 ms
Execution Time: 9.335 ms
Sort Method: quicksort  Memory: 25kB  Buffers: shared hit=1104
->  Seq Scan on transactionhistory th  (cost=0.00..2789.64 rows=1 width=13)
      Filter: ((transactiondate >= '2013-01-01'::timestamp) AND (transactiondate <= '2013-12-31'::timestamp))
      Rows Removed by Filter: 113443
      Buffers: shared hit=1088
->  Materialize  (loops=181)
*/



-- optimize 


-- 1. Calibrate Planner Statistics Depth for Historical Transaction Dates
ALTER TABLE production.transactionhistory ALTER COLUMN transactiondate SET STATISTICS 1000;
ANALYZE production.transactionhistory;

-- 2. Expand Session Memory Pool to Pull Sorting Mechanics off Hard Disk into RAM
SET work_mem = '128MB';

-- 3. Provision a Covered Composite Partial Index on Transaction History
CREATE INDEX IF NOT EXISTS idx_th_transactiondate_partial
ON production.transactionhistory (transactiondate)
INCLUDE (productid, actualcost)
WHERE transactiondate BETWEEN '2013-01-01 00:00:00' AND '2013-12-31 23:59:59';

-- 4. Provision Supporting Foreign Key Indexing on Inventory Mappings
CREATE INDEX IF NOT EXISTS idx_pi_productid ON production.productinventory (productid);



-- after

/* Planning Time: 5.287 ms
Execution Time: 0.120 ms
Sort Method: quicksort  Memory: 25kB  Buffers: shared hit=1
->  Index Scan using idx_th_transactiondate_partial on transactionhistory th  (cost=0.12..8.14 rows=1 width=13)
      Buffers: shared hit=1
*/


