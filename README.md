# Task 3 - Data Type Mapping and Compatibility

## Objective

The objective of this task was to systematically map every MSSQL data type used in the source schema to its most appropriate equivalent in PostgreSQL and MySQL while ensuring:

1. No precision loss
2. No semantic mismatch
3. No hidden corruption during migration

The mapping strategy was based on actual schema analysis from an AdventureWorks-style database and validated across all three database systems.

---

## Data Type Mapping Document

### 1. Numeric Types

| MSSQL Type | PostgreSQL | MySQL | Rationale |
|---|---|---|---|
| `INT` | `INTEGER` | `INT` | Direct compatibility across all engines |
| `SMALLINT` | `SMALLINT` | `SMALLINT` | Same storage size and range |
| `BIGINT` | `BIGINT` | `BIGINT` | No transformation required |
| `DECIMAL(p,s)` | `NUMERIC(p,s)` | `DECIMAL(p,s)` | Exact precision preserved |
| `NUMERIC(p,s)` | `NUMERIC(p,s)` | `DECIMAL(p,s)` | PostgreSQL treats NUMERIC as exact decimal |
| `MONEY` | `NUMERIC(19,4)` | `DECIMAL(19,4)` | Prevents floating-point rounding errors |

#### Key Decision

`MONEY` was converted to `NUMERIC(19,4)` to ensure financial precision consistency across all platforms.

---

### 2. Floating Point Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `FLOAT` | `DOUBLE PRECISION` | `DOUBLE` | Approximate values only |
| `REAL` | `REAL` | `FLOAT` | Lower precision float |

#### Risk Identified

Floating-point values may behave differently across database engines because of binary representation differences.

---

### 3. String Types

| MSSQL Type | PostgreSQL | MySQL | Rationale |
|---|---|---|---|
| `VARCHAR(n)` | `VARCHAR(n)` | `VARCHAR(n)` | Direct mapping |
| `NVARCHAR(n)` | `VARCHAR(n)` | `VARCHAR(n)` with `utf8mb4` | Unicode preservation |
| `CHAR(n)` | `CHAR(n)` | `CHAR(n)` | Fixed-length preservation |
| `TEXT` | `TEXT` | `LONGTEXT` | MySQL requires LONGTEXT for large values |
| `NTEXT` | `TEXT` | `LONGTEXT` | Legacy type replacement |

#### Key Decisions

1. PostgreSQL is UTF-8 native, so there is no distinction between `NVARCHAR` and `VARCHAR`.
2. MySQL requires `utf8mb4` to prevent Unicode loss, including emojis and multilingual text corruption.

---

### 4. Date and Time Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `DATETIME` | `TIMESTAMP` | `DATETIME` | PostgreSQL stores UTC internally |
| `DATETIME2` | `TIMESTAMP(7)` | `DATETIME(6)` | Precision trimming required |
| `DATE` | `DATE` | `DATE` | Direct mapping |
| `TIME` | `TIME` | `TIME` | Direct mapping |
| `SMALLDATETIME` | `TIMESTAMP` | `DATETIME` | Precision loss acceptable |

#### Critical Edge Cases

1. SQL Server does not provide timezone awareness.
2. PostgreSQL `TIMESTAMP` may introduce timezone handling depending on configuration.
3. MySQL `DATETIME` is timezone agnostic.

#### Recommendation

Standardize timestamps using:

- PostgreSQL → `TIMESTAMP WITHOUT TIME ZONE` (legacy-safe)
- PostgreSQL → `TIMESTAMPTZ` (modern preferred design)

---

### 5. Boolean Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `BIT` | `BOOLEAN` | `TINYINT(1)` | MySQL lacks native BOOLEAN type |

#### Observed Columns

1. `finishedgoodsflag`
2. `makeflag`
3. `currentflag`

---

### 6. UUID and Identity Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `UNIQUEIDENTIFIER` | `UUID` | `CHAR(36)` | PostgreSQL supports native UUID |
| `IDENTITY` | `GENERATED AS IDENTITY` | `AUTO_INCREMENT` | Explicit remapping required |

#### Observed Example

- `rowguid` → PostgreSQL `UUID`

---

### 7. Binary Data Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `VARBINARY` | `BYTEA` | `VARBINARY/BLOB` | MySQL row-size limitations |
| `IMAGE` | `BYTEA` | `LONGBLOB` | Deprecated in MSSQL |

#### Observed Columns

1. `productphoto.largephoto`
2. `document.document`

---

### 8. XML and Semi-Structured Data

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `XML` | `XML` | `TEXT` | MySQL lacks native XML support |

#### Observed Column

- `databaselog.xmlevent`

---

### 9. Special Types

| MSSQL Type | PostgreSQL | MySQL | Notes |
|---|---|---|---|
| `ROWVERSION/TIMESTAMP` | `BYTEA` | `BIGINT` | Requires manual optimistic locking implementation |

---

## Edge Cases Discovered and Resolutions

### 1. Precision Loss in Monetary Fields

#### Problem

Fields such as:

1. `listprice`
2. `standardcost`
3. `taxamt`
4. `rate`

were stored without explicit precision.

#### Risk

1. MySQL and PostgreSQL may round values differently
2. Financial inconsistencies after migration

#### Resolution

Standardized all financial values to:

```sql
NUMERIC(19,4)
```

---

### 2. DATETIME vs TIMESTAMP Semantic Drift

#### Problem

1. MSSQL `DATETIME` is timezone unaware
2. PostgreSQL `TIMESTAMP` may introduce UTC conversion

#### Risk

Shifted reporting dates and inconsistent dashboards.

#### Resolution

Standardized all legacy-compatible timestamps using:

```sql
TIMESTAMP WITHOUT TIME ZONE
```

---

### 3. Encoding Mismatch (NVARCHAR → VARCHAR)

#### Problem

1. MSSQL `NVARCHAR` supports Unicode
2. MySQL requires explicit `utf8mb4`

#### Risk

1. Emoji loss
2. Multilingual text corruption

#### Resolution

MySQL encoding standardized as:

```sql
VARCHAR(...) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
```

---

### 4. Boolean Misinterpretation

#### Problem

MSSQL `BIT` values may contain:

1. `0`
2. `1`
3. `NULL`

#### Risk

MySQL `TINYINT(1)` may interpret `NULL` inconsistently.

#### Resolution

Enforced:

```sql
NOT NULL DEFAULT 0
```

---

### 5. UUID Storage Format Differences

#### Problem

1. MSSQL stores GUIDs as strings
2. PostgreSQL uses native UUID
3. MySQL stores UUIDs as `CHAR(36)`

#### Risk

Performance degradation in MySQL joins and indexing.

#### Resolution

1. PostgreSQL → Native `UUID`
2. MySQL → Recommendation to use `BINARY(16)` for optimization

---

### 6. TEXT Field Overuse

#### Problem

Fields such as:

1. `resume`
2. `demographics`
3. `documentsummary`

were heavily stored as `TEXT`.

#### Risk

1. Poor indexing performance
2. Slow filtering and querying

#### Resolution

Future enhancement recommendation:

- Convert structured text data into `JSONB` in PostgreSQL

---

### 7. Rowversion / Concurrency Control Loss

#### Problem

SQL Server `ROWVERSION` has no direct equivalent.

#### Risk

Loss of optimistic concurrency control.

#### Resolution

Implemented manually using:

1. PostgreSQL `BIGINT` version column
2. Trigger-based increment logic

---

### 8. Binary Data Size Handling Differences

#### Problem

1. MySQL `LONGBLOB` row-size limitations
2. PostgreSQL automatic TOAST storage

#### Risk

Large image and document insertion failures in MySQL.

#### Resolution

1. Streaming insert strategy
2. File-storage fallback mechanism

---

### 9. Schema-Level Name Collisions

#### Problem

Repeated column names existed across schemas, including:

1. `name`
2. `modifieddate`
3. `rowguid`

#### Risk

1. ORM ambiguity
2. ETL mapping confusion

#### Resolution

Enforced fully qualified mappings using:

```sql
schema.table.column
```

---

### 10. Missing Explicit Precision in Source Schema

#### Problem

Several numeric columns were defined as:

```sql
numeric
```

without explicit precision.

#### Risk

Inconsistent numeric behavior across MSSQL, PostgreSQL, and MySQL.

#### Resolution

Standardized default precision as:

```sql
NUMERIC(18,4)
```

unless overridden by business requirements.

---

## Final Migration Standards

The following migration standards were enforced across all target systems:

1. All money fields → `NUMERIC(19,4)`
2. All UUID fields → PostgreSQL native `UUID`
3. All `NVARCHAR` fields → `utf8mb4` in MySQL
4. All `DATETIME` fields → `TIMESTAMP WITHOUT TIME ZONE`
5. All `BIT` fields → `BOOLEAN` / `TINYINT(1)`
6. All `IMAGE` and `VARBINARY` fields → `BYTEA` / `BLOB`
7. All identity columns → Explicit `AUTO_INCREMENT` or `GENERATED AS IDENTITY`
