# Task 4 - Query Performance Optimization and Execution Tuning

## PostgreSQL Query Optimization Reports

---

## 1. Analytical Sales Ledger Join Optimization

### Problem Before Optimization

The query execution suffered from inefficient data access patterns caused by the absence of a targeted index.

#### Issues Identified

1. Sequential Table Scan (`Seq Scan`)
   
   The database engine scanned approximately 31,465 rows individually because no optimized index existed for the target query predicates.

2. Excessive Memory Buffer Usage
   
   A total of 768 shared hit blocks were loaded into memory to process records that ultimately produced no matching results.

3. High I/O and CPU Overhead
   
   The database performed unnecessary row filtering and buffer traversal operations, significantly increasing execution latency.

---

### Optimization Applied

A covered index strategy was implemented to eliminate unnecessary table access operations.

#### Improvements Introduced

1. Index Only Scan
   
   A covering B-Tree index enabled the database to retrieve all required data directly from the index structure without accessing the base table.

2. Elimination of Redundant Row Filtering
   
   The optimizer no longer scanned or discarded irrelevant records.

3. Reduced Buffer Traversal
   
   Only two shared memory blocks were accessed after optimization.

---

### Result After Optimization

The optimized execution path eliminated large-scale sequential scans and significantly reduced memory consumption.

#### Performance Comparison Matrix

| Evaluation Metric | Baseline State (Before) | Optimized State (After) | Improvement Delta |
|---|---|---|---|
| Execution Speed | `3.296 ms` | `0.105 ms` | `96.8% Reduction` |
| I/O Memory Footprint | `768 Shared Hit Blocks` | `2 Shared Hit Blocks` | `99.7% Less Buffer Load` |
| Table Scan Method | `Seq Scan` | `Index Only Scan` | Eliminated Wasted I/O |
| Wasted Rows Evaluated | `31,465 Rows` | `0 Rows` | Zero Filtering Overhead |
| Planner Estimate Accuracy | Estimated `1` Row (Actual `0`) | Estimated `1` Row (Actual `0`) | Structural Synchronization |

---

### Planning Time Analysis

Post-optimization planning time increased slightly from:

- `2.788 ms`
- to `4.441 ms`

This behavior is expected because:

1. Expanded column-level statistics increased optimization permutations
2. The planner evaluated additional execution paths
3. Query plans become cached in production environments

Although planning overhead increased marginally, the reduction in execution time more than compensated for the additional planning cost.

---

## 2. Inventory Stock and Transactional History Ledger Optimization

### Problem Before Optimization

The query execution suffered from repetitive sequential scans and inefficient loop materialization behavior.

#### Issues Identified

1. Full Sequential Table Scan
   
   The database scanned approximately 113,443 transaction records to locate entries within the target date range.

2. Repetitive Nested Loop Processing
   
   The execution engine repeated the same large scan operation 181 separate times because of inefficient query structure and missing indexing.

3. High Computational and Memory Cost
   
   Excessive looping dramatically increased execution cost and memory pressure.

---

### Optimization Applied

A partial covered index and updated planner statistics were introduced.

#### Improvements Introduced

1. Partial B-Tree Index
   
   A highly selective index was created specifically for the target 2013 transaction range.

2. Statistics Calibration
   
   Query planner statistics were refreshed to improve cardinality estimation accuracy.

3. Direct Index Lookup
   
   The optimizer replaced iterative scans with efficient indexed retrieval.

---

### Result After Optimization

The database eliminated repetitive table scans and transformed the workload into a direct index-based retrieval operation.

#### Performance Reconciliation Matrix

| Evaluation Metric | Baseline State (Before) | Optimized State (After) | Performance Delta | Status |
|---|---|---|---|---|
| Data Scan Strategy | `Seq Scan + Loop Materialization` | `Index Scan (Partial B-Tree)` | Eliminated Iterative Looping | Optimized |
| Total Execution Speed | `9.335 ms` | `0.120 ms` | `98.71% Reduction` | Passed |
| Wasted Rows Evaluated | `113,443 Rows` | `0 Rows` | Zero Filtering Overhead | Passed |
| I/O Memory Footprint | `1,104 Shared Hit Blocks` | `1 Shared Hit Block` | `99.91% Buffer Relief` | Passed |
| Computational Plan Cost | `2833.24 Cost Units` | `17.22 Cost Units` | `99.39% Processing Relief` | Passed |

---

# MySQL Query Optimization Reports

---

## 1. Inventory Stock and Transactional History Ledger Optimization

### Problem Before Optimization

The query suffered from inefficient table scanning and disk-based sorting operations.

#### Issues Identified

1. Full Table Scan
   
   More than 113,000 transaction rows were scanned sequentially to identify records within the required date range.

2. Disk Spill During Sorting
   
   Insufficient memory allocation forced MySQL to create temporary disk files during sorting and aggregation operations.

3. Excessive Disk I/O
   
   Temporary disk writes significantly increased execution latency.

---

### Optimization Applied

A two-step optimization strategy was implemented.

#### Improvements Introduced

1. B-Tree Index Creation
   
   A targeted B-Tree index was created on the date column to eliminate sequential scanning.

2. Expanded Sorting Memory
   
   Session-level sorting memory was increased using:

```sql
sort_buffer_size
```

to ensure all sorting operations remained entirely in RAM.

---

### Result After Optimization

The optimized execution plan eliminated disk-based temporary operations and reduced scan overhead.

#### Performance Reconciliation Matrix

| Evaluation Criteria | Baseline State (Before) | Optimized State (After) | Performance Delta | Status |
|---|---|---|---|---|
| Aggregation Engine | Temporary Disk Files | High-Speed RAM Buffer | Eliminated Disk I/O | Optimized |
| Data Scan Strategy | Global Table Sweep | Targeted B-Tree Index Scan | Direct Row Lookup | Optimized |
| Total Query Latency | `142.000 ms` | `0.120 ms` | `99.91% Reduction` | Passed |
| Storage Spill Activity | Active Hard Drive Writes | Fully In-Memory | Total I/O Relief | Passed |

---

## 2. Credit Card Sales Ledger Optimization

### Problem Before Optimization

The query experienced memory exhaustion and excessive temporary disk operations during aggregation.

#### Issues Identified

1. Large-Scale Row Scanning
   
   The database scanned thousands of sales records without an optimized retrieval path.

2. Memory Buffer Exhaustion
   
   Aggregation operations exceeded available sorting memory.

3. Temporary Disk Usage
   
   Intermediate results were written to physical storage, dramatically increasing latency.

---

### Optimization Applied

A composite indexing strategy and expanded memory allocation were implemented.

#### Improvements Introduced

1. Increased Session Memory

```sql
SET SESSION sort_buffer_size = 32M;
```

This ensured all sorting and aggregation operations remained entirely within RAM.

2. Composite Index Creation
   
   A composite index provided direct lookup access for date and credit-card-based filtering operations.

---

### Result After Optimization

The query execution became entirely memory-resident and avoided all temporary disk operations.

#### Performance Comparison Matrix

| Evaluation Metric | Unoptimized State (Before) | Optimized State (After) | Performance Improvement |
|---|---|---|---|
| Data Retrieval Method | Full Table Scan | Composite Index Lookup | `99.9% Less Manual Processing` |
| Aggregation Processing | Disk Spill Operations | In-Memory RAM Processing | Eliminated Disk I/O |
| Total Execution Time | `60.300 ms` | `0.037 ms` | `99.93% Faster Execution` |
| System Resource Utilization | High Disk and CPU Usage | Zero Disk Activity | Production Ready |

---

## Overall Optimization Outcome

The implemented indexing strategies, planner calibration improvements, and memory optimization techniques collectively produced the following benefits across PostgreSQL and MySQL environments:

1. Elimination of unnecessary sequential scans
2. Reduction of excessive buffer traversal operations
3. Elimination of temporary disk spill activity
4. Improved query-planner efficiency
5. Significant reduction in execution latency
6. Increased production-readiness and scalability
7. Improved I/O throughput and reduced computational overhead

The optimized workloads now execute using highly efficient index-driven access paths with near-zero unnecessary disk interaction.
