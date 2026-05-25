-- ================== MY SQL =====================
-- 1. Query Performance Optimization Report: Inventory Stock & Transactional History Ledger 

EXPLAIN ANALYZE
SELECT 
    p.productid,
    p.name AS product_name,
    p.productnumber,
    pi.shelf,
    pi.bin,
    SUM(pi.quantity) AS current_inventory_stock,
    COUNT(th.transactionid) AS total_transactions_logged,
    AVG(th.actualcost) AS average_transaction_cost
FROM production_product p
JOIN production_productinventory pi ON p.productid = pi.productid
LEFT JOIN production_transactionhistory th ON p.productid = th.productid
WHERE p.safetystocklevel > 500
  AND th.transactiondate BETWEEN '2013-01-01 00:00:00' AND '2013-12-31 23:59:59'
GROUP BY p.productid, p.name, p.productnumber, pi.shelf, pi.bin
ORDER BY current_inventory_stock DESC, average_transaction_cost ASC;

-- Before

-> Sort: current_inventory_stock DESC, average_transaction_cost  (actual time=142..142 rows=0 loops=1)
     -> Table scan on <temporary>  (actual time=142..142 rows=0 loops=1)


-- optimize

-- 1. Expand the session sort buffer memory to prevent disk-based sorting temp files
SET SESSION sort_buffer_size = 33554432; -- Allocate 32MB of high-speed RAM for this session

-- 2. Provision a composite B-Tree Index 
-- (Note: MySQL does not support the INCLUDE clause; we append columns directly to the index key)
CREATE INDEX idx_th_date_product_cost 
ON production_transactionhistory (transactiondate, productid, actualcost);

-- 3. Provision supporting Foreign Key index coverage if missing
CREATE INDEX idx_pi_productid 
ON production_productinventory (productid);


-- After

-> Sort: current_inventory_stock DESC, average_transaction_cost  (actual time=0.0525..0.0525 rows=0 loops=1)
     -> Table scan on <temporary>  (actual time=0.0442..0.0442 rows=0 loops=1)



-- 2.  Query Performance Optimization Report: Credit Card Sales Ledger

EXPLAIN ANALYZE
SELECT 
    soh.salesorderid,
    soh.orderdate,
    soh.customerid,
    cc.cardtype,
    SUM(soh.subtotal) AS total_sales,
    AVG(soh.freight) AS average_shipping_cost
FROM sales_salesorderheader soh
FORCE INDEX (idx_soh_date_cc_subtotal)
JOIN sales_creditcard cc ON soh.creditcardid = cc.creditcardid
WHERE cc.cardtype = 'Vista'
  AND soh.orderdate BETWEEN '2012-01-01 00:00:00' AND '2012-12-31 23:59:59'
GROUP BY soh.salesorderid, soh.orderdate, soh.customerid, cc.cardtype
ORDER BY total_sales DESC;


-- before 

-> Sort: total_sales DESC  (actual time=60.3..60.3 rows=0 loops=1)
     -> Table scan on <temporary>  (actual time=60.3..60.3 rows=0 loops=1)
         -> Aggregate using temporary table  (actual time=60.3..60.3 rows=0 loops=1)
          


-- optimization 

-- 1. Allocate ample sorting memory room to prevent the disk fallback entirely
SET SESSION sort_buffer_size = 33554432; 

-- 2. Build the perfect composite B-Tree index to handle the dates, joins, and aggregates
CREATE INDEX idx_soh_date_cc_subtotal 
ON sales_salesorderheader (orderdate, creditcardid, subtotal, freight);

-- 3. Index the foreign lookups column
CREATE INDEX idx_cc_cardtype 
ON sales_creditcard (cardtype);


-- after

-> Sort: total_sales DESC  (actual time=0.0374..0.0374 rows=0 loops=1)
     -> Table scan on <temporary>  (actual time=0.0317..0.0317 rows=0 loops=1)
         -> Aggregate using temporary table  (actual time=0.0307..0.0307 rows=0 loops=1)
          