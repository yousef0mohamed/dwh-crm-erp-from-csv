# Naming Conventions

This document defines the naming standards followed throughout the Data Warehouse project.
The goal is to maintain a consistent, readable, and predictable naming structure across schemas, tables, columns, and database objects.

---

## Table of Contents

1. [General Naming Guidelines](#general-naming-guidelines)
2. [Table Naming Standards](#table-naming-standards)

   * [Bronze Layer](#bronze-layer)
   * [Silver Layer](#silver-layer)
   * [Gold Layer](#gold-layer)
3. [Column Naming Standards](#column-naming-standards)

   * [Surrogate Keys](#surrogate-keys)
   * [Technical Columns](#technical-columns)
4. [Stored Procedure Naming](#stored-procedure-naming)

---

## General Naming Guidelines

The following rules apply to database objects throughout the project:

* **Case:** Use lowercase characters for database object names.
* **Word Separation:** Use `snake_case`, with underscores separating individual words.
* **Language:** Use English names consistently across the database.
* **Clarity:** Names should clearly describe the purpose or content of the object.
* **Reserved Keywords:** Avoid using SQL Server reserved keywords as names for database objects.
* **Consistency:** Follow the same naming pattern across all layers of the warehouse.

---

# Table Naming Standards

## Bronze Layer

The Bronze layer stores data in its original form as received from the source systems.

Tables follow this pattern:

```text
<source_system>_<entity>
```

Where:

* `<source_system>` identifies the originating system, such as `crm` or `erp`.
* `<entity>` represents the original source table or dataset name.

### Example

```text
crm_cust_info
```

This represents customer information originating from the CRM system.

### Rules

* Keep the source system identifier as the table prefix.
* Preserve the original source table name where possible.
* Avoid applying business-oriented naming changes to raw Bronze tables.

---

## Silver Layer

The Silver layer contains cleansed and standardized versions of the source data.

The naming pattern remains:

```text
<source_system>_<entity>
```

Where:

* `<source_system>` identifies the original source system.
* `<entity>` corresponds to the source entity being processed.

### Example

```text
erp_cust_az12
```

This identifies customer-related data originating from the ERP system.

### Rules

* Retain the source-system prefix.
* Keep the relationship with the original source entity clear.
* Use the same naming convention across Silver tables for consistency with the Bronze layer.

---

## Gold Layer

Gold tables represent business-ready data designed for reporting and analytical workloads.

The standard pattern is:

```text
<category>_<entity>
```

Where:

* `<category>` describes the table's role within the analytical model.
* `<entity>` identifies the business subject represented by the table.

### Examples

```text
dim_customers
dim_products
fact_sales
```

Here:

* `dim_` identifies a dimension table.
* `fact_` identifies a fact table.

---

## Gold Table Prefixes

| Prefix    | Purpose                                                       | Example                |
| --------- | ------------------------------------------------------------- | ---------------------- |
| `dim_`    | Dimension table containing descriptive attributes             | `dim_customers`        |
| `fact_`   | Fact table containing measurable business events              | `fact_sales`           |
| `report_` | Table designed specifically to support reporting requirements | `report_sales_monthly` |

The prefixes make it easier to identify the role of a table without having to inspect its structure.

---

# Column Naming Standards

## Surrogate Keys

Surrogate keys are used as the primary identifiers for dimension records.

The standard format is:

```text
<entity>_key
```

### Example

```text
customer_key
product_key
```

### Rules

* Dimension surrogate keys should use the `_key` suffix.
* The name should clearly identify the business entity represented by the key.
* Surrogate keys should be distinct from source-system business keys.

For example:

```text
customer_key
```

is the warehouse-generated key for a customer, while:

```text
customer_id
```

represents the identifier originating from the source system.

---

## Technical Columns

Technical or metadata columns should use the following structure:

```text
dwh_<column_name>
```

The `dwh_` prefix identifies columns that are generated or maintained by the Data Warehouse rather than originating directly from the source systems.

### Example

```text
dwh_load_date
```

This column can be used to record when a record was loaded into the warehouse.

Other technical metadata can follow the same pattern, for example:

```text
dwh_insert_date
dwh_update_date
dwh_source
```

---

# Stored Procedure Naming

Stored procedures responsible for loading warehouse layers follow a simple and consistent naming pattern:

```text
load_<layer>
```

Where `<layer>` represents the target warehouse layer.

### Examples

```text
load_bronze
load_silver
load_gold
```

These names indicate the purpose of each procedure directly:

* `load_bronze` → Loads data into the Bronze layer.
* `load_silver` → Performs the Silver-layer cleansing and transformation process.
* `load_gold` → Builds or refreshes the analytical Gold-layer structures.

Using a consistent procedure naming pattern makes ETL processes easier to identify, maintain, and execute.
