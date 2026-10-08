# Vehicle Management Database (SQL Server / T-SQL)

A **3NF-normalized relational database** for a vehicle repair shop, written in **T-SQL (Microsoft SQL Server)**. It tracks customers, their vehicles, and repair jobs, and it works as a complete practice set covering basic queries through advanced T-SQL features.

## Database Design

**Database:** `VehicleDB`
**Data file:** `VehicleDB_Data_1` (25 MB initial, 100 MB max, 5% growth)
**Log file:** `VehicleDB_Log_1` (2 MB initial, 50 MB max, 1 MB growth)

### Tables

| Table | Purpose | Key columns |
| --- | --- | --- |
| `Customer` | Customer contact details | `Customer_ID` (PK), name, phone, addresses, city, email |
| `Vehicle` | Vehicles owned by customers | `Vehicle_ID` (PK), `VIN` (unique), make, model, year, `Owner_ID` (FK) |
| `Vehicle_Status` | Lookup table for repair status | `Status_ID` (PK), `Status_Name` |
| `Repair` | Repair jobs per vehicle | `Repair_ID` (PK), `Vehicle_ID` (FK), `Status_ID` (FK), date, description, cost |

### Relationships

```
Customer 1 ──< Vehicle 1 ──< Repair >── 1 Vehicle_Status
```

One customer can own many vehicles, one vehicle can have many repairs, and each repair has one status.

## Repository Contents

| File | Description |
| --- | --- |
| `1295498_DDL.sql` | Database and table creation, `ALTER TABLE`, views, sequences, stored procedures, user-defined table types, functions |
| `1295498_DML.sql` | Sample data inserts, `SELECT` queries, joins, aggregates, window and analytic functions, and view justifications |
| `Case Study(1295498).docx` | The original problem statement and the list of required tasks |

## What's Covered

**DML / Querying**
- `INSERT`, `UPDATE`, `DELETE`, `SELECT INTO`
- Filtering with `LIKE`, `BETWEEN`, `IN`, wildcard ranges, `OFFSET/FETCH`, `TOP`
- Aggregates: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`, plus `GROUP BY`
- `JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `UNION`, `EXISTS`, subqueries, CTEs
- `CUBE`, `ROLLUP`, `GROUPING SETS`, `OVER` clause, `ANY` / `ALL` / `SOME`
- `CASE`, `IIF`, `CHOOSE`, `COALESCE`, `ISNULL`, `GROUPING`
- Ranking functions: `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`
- Analytic functions: `FIRST_VALUE`, `LAST_VALUE`, `LEAD`, `LAG`, `PERCENT_RANK`, `CUME_DIST`, `PERCENTILE_CONT`, `PERCENTILE_DISC`

**DDL / Programmability**
- Views: standard, `ENCRYPTION`, `SCHEMABINDING`, updatable, `WITH CHECK OPTION`, `ALTER` and `DROP`
- Sequences (create, alter, drop)
- Stored procedures: parameters, optional and `OUTPUT` parameters, `RECOMPILE`, `ENCRYPTION`, `THROW`, `TRY...CATCH`, transactions, table-valued parameters
- User-defined functions: scalar, inline table-valued, multi-statement table-valued

## Getting Started

### Prerequisites

- Microsoft SQL Server (2017 or later recommended)
- SQL Server Management Studio (SSMS) or Azure Data Studio

### Setup

1. Open `1295498_DDL.sql` in SSMS.
2. The `CREATE DATABASE` block at the top is commented out. Uncomment it and **edit the `FileName` paths** to match your SQL Server data folder, or create `VehicleDB` manually.
3. Run the DDL script to create the tables, views, procedures and functions.
4. Run `1295498_DML.sql` to insert the sample data and execute the practice queries.

Some statements, such as the `DROP` examples, change the database. If a script fails halfway, drop and recreate `VehicleDB` and run the scripts again in order.

## Sample Data

The sample data is fictional and covers customers with vehicles such as Honda Civic, Toyota Avalon, Hyundai Creta and Suzuki Swift, with repair costs and statuses like Pending.

## Author

Name: *your name here*
GitHub: [@your-username](https://github.com/your-username)

## License

Add a license of your choice (for example MIT), or remove this section.

