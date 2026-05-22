# Task 1 - Schema and Data Migration

## Objective

The objective of this task was to migrate the complete Microsoft SQL Server (MSSQL) database schema and data into PostgreSQL and MySQL while preserving:

1. Table structures
2. Constraints
3. Relationships
4. Indexes
5. Nullability rules
6. Default values
7. Referential integrity

The final goal was to ensure that both target databases behaved functionally equivalent to the original MSSQL system.

---

## Migration Overview

The migration process was divided into two major phases:

1. Schema Migration  
2. Data Migration  

Both PostgreSQL and MySQL required syntax adaptation and datatype transformation because several MSSQL-specific features are not directly supported in open-source database systems.

---

## Schema Migration

### PostgreSQL Migration

#### Approach

The MSSQL schema was converted into PostgreSQL-compatible DDL by modifying:

- MSSQL-specific data types
- Constraint syntax
- Identity column definitions
- Index definitions
- XML-related structures

#### Key PostgreSQL Adjustments

| MSSQL Feature | PostgreSQL Equivalent |
|---|---|
| `GETDATE()` | `NOW()` |
| `NEWID()` | `gen_random_uuid()` |
| Clustered Index | B-tree Index |
| `IDENTITY` | `GENERATED AS IDENTITY` |
| XML Operations | PostgreSQL XML / TEXT fallback |

---

### MySQL Migration

#### Approach

The MSSQL schema was adapted into MySQL-compatible syntax while ensuring structural equivalence across all database objects.

#### Major Datatype Conversions

| MSSQL Type | MySQL Type |
|---|---|
| `UNIQUEIDENTIFIER` | `CHAR(50)` |
| `BIT` | `TINYINT(1)` |
| `IMAGE` | `LONGBLOB` |
| `MONEY` | `DECIMAL(19,4)` |
| `XML` | `LONGTEXT` |

#### Key MySQL Adjustments

- Used `AUTO_INCREMENT` for identity columns
- Configured `utf8mb4` character encoding
- Adapted index definitions for MySQL syntax
- Replaced unsupported XML functionality

---

## Data Migration

### Migration Process

The data migration workflow included:

1. Exporting data from MSSQL
2. Converting encoding to UTF-8
3. Loading parent tables before child tables
4. Preserving foreign key relationships
5. Validating row counts after each load

---

### Referential Integrity Handling

To maintain data consistency throughout the migration:

1. Parent tables were migrated first
2. Child tables were migrated afterward
3. Foreign key constraints were validated after import
4. Migration followed dependency hierarchy strictly

---

## Challenges Faced and Resolutions

### 1. XML Function Compatibility Issues

#### Issue
MSSQL XML functions were not directly supported in PostgreSQL and MySQL.

#### Resolution
XML parsing logic was replaced with compatible TEXT-based or platform-specific alternatives.

---

### 2. View Dependency Issues

#### Issue
Existing views blocked schema and datatype modifications.

#### Resolution
Dependent views were temporarily dropped and recreated after migration completion.

---

### 3. Clustered Index Differences

#### Issue
MSSQL clustered index behavior was not supported in target databases.

#### Resolution
Equivalent B-tree indexes were created in PostgreSQL and MySQL.

---

### 4. Encoding Mismatch Problems

#### Issue
Character corruption occurred during data transfer.

#### Resolution
All exports were standardized to UTF-8 encoding before migration.

---

### 5. Identity Column Compatibility

#### Issue
MSSQL `IDENTITY` columns were not directly portable.

#### Resolution

- PostgreSQL → `GENERATED AS IDENTITY`
- MySQL → `AUTO_INCREMENT`

---

### 6. UUID Handling Differences

#### Issue
UUID representation varied across database systems.

#### Resolution

- PostgreSQL → Native `UUID` type
- MySQL → `CHAR(50)` representation

---

### 7. Binary Data Migration Issues

#### Issue
The MSSQL `IMAGE` datatype was not directly portable.

#### Resolution

- PostgreSQL → `BYTEA`
- MySQL → `LONGBLOB`

---

### 8. Reserved Keyword Conflicts

#### Issue
Some column names conflicted with SQL reserved keywords.

#### Resolution

- PostgreSQL → `"column_name"`
- MySQL → `` `column_name` ``

---

### 9. Datetime Precision Mismatches

#### Issue
Differences existed in datetime precision across platforms.

#### Resolution

- PostgreSQL → `TIMESTAMP(7)`
- MySQL → `DATETIME(6)`
