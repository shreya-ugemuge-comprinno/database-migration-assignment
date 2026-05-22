# Task 2 - Stored Procedure Conversion

## Objective

The objective of this task was to convert Microsoft SQL Server (MSSQL) stored procedures, views, and functions into PostgreSQL (PL/pgSQL) and MySQL-compatible procedural syntax while preserving:

1. Business logic
2. Query behavior
3. Data integrity
4. Performance
5. Readability and maintainability

The migration focused on producing idiomatic and optimized implementations rather than direct line-by-line translations of T-SQL code.

---

## Components Converted

The following database objects were analyzed and migrated:

1. Stored Procedures (transactional and business logic)
2. Scalar Functions (single-value return logic)
3. Table-Valued Functions (result set generators)
4. Views (complex joins and aggregations)
5. XML-based procedures/functions (MSSQL-specific XML logic)

---

## PostgreSQL (PL/pgSQL) Conversion Approach

MSSQL stored procedures were rewritten using PL/pgSQL while adapting SQL Server procedural logic into PostgreSQL-native syntax and behavior.

### Key Syntax Transformations

| MSSQL (T-SQL) | PostgreSQL (PL/pgSQL) |
|---|---|
| `GETDATE()` | `NOW()` |
| `ISNULL(x,y)` | `COALESCE(x,y)` |
| `PRINT` | `RAISE NOTICE` |
| `TOP N` | `LIMIT N` |
| `NEWID()` | `gen_random_uuid()` |
| `@@ROWCOUNT` | `GET DIAGNOSTICS row_count = ROW_COUNT` |
| `TRY...CATCH` | `BEGIN ... EXCEPTION WHEN OTHERS THEN` |
| `CONVERT()` | `CAST()` / `TO_CHAR()` |

---

### PostgreSQL Optimization Decisions

1. Converted cursor-based logic into set-based SQL operations
2. Reduced row-by-row processing for better execution performance
3. Used PostgreSQL-native aggregation functions such as `STRING_AGG`
4. Replaced procedural loops with declarative SQL queries wherever possible
5. Simplified nested query structures for maintainability

---

## MySQL Conversion Approach

Stored procedures were rewritten using MySQL procedural syntax while preserving original business behavior.

### Key Adjustments

1. Used `DELIMITER` blocks for procedure definitions
2. Used `BEGIN ... END` procedural blocks
3. Converted control flow logic into MySQL-compatible `IF/ELSE`
4. Used `DECLARE` statements for variables
5. Replaced `IDENTITY` columns with `AUTO_INCREMENT`
6. Replaced MSSQL string concatenation with `CONCAT()`

---

## Function Conversion

### Objective

MSSQL scalar and table-valued functions were converted into PostgreSQL and MySQL equivalents while preserving return behavior and query logic.

### Key Adjustments

1. Scalar functions rewritten using `CREATE FUNCTION`
2. Table-valued functions converted into:
   - `RETURNS TABLE`
   - `SETOF`
   - Result-set based SQL queries

3. Aggregation logic migrated using:
   - `STRING_AGG` (PostgreSQL)
   - `GROUP_CONCAT` (MySQL)
   - `ARRAY_AGG` (PostgreSQL)

---

## View Conversion

### Objective

Views were migrated while preserving:

1. Joins
2. Filters
3. Aggregations
4. Encapsulated business logic

### Key Changes

1. Removed MSSQL-specific syntax
2. Replaced XML-based transformations with:
   - Text-based processing
   - Flattened relational queries
3. Simplified complex nested views into optimized `SELECT` statements where possible

---

## XML Handling Conversion

### Challenge

MSSQL XML methods such as:

1. `.value()`
2. `.nodes()`
3. `.query()`

are not directly supported in MySQL and only partially supported in PostgreSQL.

---

### Resolution

#### PostgreSQL

1. XML logic partially retained using XPath/XML functions
2. Some XML processing converted into TEXT-based logic

#### MySQL

1. XML stored as `LONGTEXT`
2. XML extraction logic manually rewritten where required

---

## Key Differences Encountered

### 1. Control Flow Differences

T-SQL procedural flow differs significantly from PL/pgSQL and MySQL procedural syntax.

#### Resolution

1. Rewrote procedural blocks using native control-flow structures
2. Adapted variable declarations and exception handling logic

---

### 2. Cursor vs Set-Based Logic

Many MSSQL procedures relied heavily on cursors and row-by-row processing.

#### Resolution

1. Replaced cursor-heavy logic with set-based SQL operations
2. Improved execution performance and scalability

---

### 3. Error Handling Differences

| MSSQL | PostgreSQL | MySQL |
|---|---|---|
| `TRY...CATCH` | `EXCEPTION WHEN OTHERS` | `DECLARE HANDLER` |

#### Resolution

Implemented platform-native exception handling mechanisms for equivalent transactional behavior.

---

### 4. String Handling Differences

| MSSQL | PostgreSQL | MySQL |
|---|---|---|
| `+` | `\|\|` | `CONCAT()` |

#### Resolution

String concatenation logic was rewritten using target-platform syntax.

---

### 5. Identity and UUID Differences

#### Resolution

1. `IDENTITY` replaced with:
   - `GENERATED AS IDENTITY`
   - `SERIAL`
   - `AUTO_INCREMENT`

2. `NEWID()` replaced with:
   - `gen_random_uuid()` (PostgreSQL)
   - String-based UUID generation (MySQL)

---

### 6. XML Support Limitations

#### Challenge

MSSQL XML functionality is not fully portable across PostgreSQL and MySQL.

#### Resolution

1. XML-based logic redesigned using relational or text-based processing
2. Deferred unsupported XML-heavy objects where required

---

## Optimization Decisions

The migration emphasized performance optimization and maintainability.

### Improvements Made

1. Replaced row-by-row processing with set-based SQL queries
2. Eliminated unnecessary cursors
3. Reduced procedural complexity
4. Leveraged native aggregation functions
5. Standardized procedural patterns across PostgreSQL and MySQL
6. Simplified deeply nested query structures

---

## Procedure-to-Function Conversion Decisions

Some MSSQL objects required structural redesign rather than direct object-type conversion.

### Example: `ufnGetContactInformation`

In MSSQL, `ufnGetContactInformation` was implemented as a table-valued function returning a result set.

Because PostgreSQL and MySQL handle result-returning procedural objects differently, equivalent implementations required redesign.

---

### PostgreSQL Conversion

Implemented using:

1. `RETURNS TABLE`
2. `SETOF`
3. PL/pgSQL result-returning functions

#### Benefits

1. Cleaner PostgreSQL integration
2. Improved compatibility with PL/pgSQL
3. More idiomatic PostgreSQL implementation patterns

---

### MySQL Conversion

MySQL does not support table-valued functions equivalent to SQL Server.

#### Resolution

1. Reimplemented logic using stored procedures
2. Returned result sets through procedural `SELECT` statements
3. Used parameterized query patterns where appropriate

---

## Deferred / Not Migrated Objects

### MySQL – Deferred XML/XQuery Views

The following XML/XQuery-heavy views were deferred in MySQL due to lack of equivalent native XML processing support.

#### HumanResources

1. `vJobCandidate`
2. `vJobCandidateEducation`
3. `vJobCandidateEmployment`

#### Person

1. `vAdditionalContactInfo`

#### Production

1. `vProductModelCatalogDescription`
2. `vProductModelInstructions`

#### Sales

1. `vPersonDemographics`
2. `vStoreWithDemographics`
3. `vSalesPersonSalesByFiscalYears` (PIVOT-based logic)

---

### Reason

These objects relied heavily on:

1. MSSQL XML methods (`.value()`, `.nodes()`, `.query()`)
2. PIVOT-based transformations
3. Complex hierarchical XML structures

MySQL lacks native XML/XQuery capabilities equivalent to SQL Server, and full migration would require redesign into relational structures, which was outside the current migration scope.

---

### PostgreSQL – Not Migrated Stored Procedures

The following stored procedures were not migrated to PostgreSQL due to dependency on SQL Server-specific functionality.

| Stored Procedure | Reason |
|---|---|
| `uspGetEmployeeManagers` | Depends on `hierarchyid`, which is SQL Server specific |
| `uspGetManagerEmployees` | Uses recursive hierarchy logic based on `hierarchyid` |
| `uspUpdateEmployeeLogin` | Requires redesign of hierarchical employee structure |
| XML-related procedures/views | PostgreSQL XML handling differs significantly from MSSQL |

---

### Reason

These procedures were deferred because:

1. `hierarchyid` has no direct PostgreSQL equivalent
2. Recursive hierarchy logic requires redesign using `WITH RECURSIVE`
3. XML processing logic differs significantly between platforms
4. Business logic depended on SQL Server-specific implementation patterns

---

## Summary of Impact

### MySQL

1. XML-heavy views deferred due to lack of XML/XQuery support
2. PIVOT-based views require redesign using relational aggregation

### PostgreSQL

1. Hierarchy-based procedures deferred due to `hierarchyid` dependency
2. XML procedural logic requires additional redesign effort

These deferred objects will require future redesign using:

1. Recursive SQL models
2. Relational restructuring
3. Platform-native XML alternatives
