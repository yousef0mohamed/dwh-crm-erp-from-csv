# Gold Layer Data Catalog

## Overview

The **Gold Layer** contains the final, business-ready representation of the data warehouse.
It is designed to support analytical queries, reporting, and business intelligence use cases.

The Gold layer follows a **Star Schema** design and is composed of **dimension tables** that provide descriptive information and **fact tables** that store measurable business events.

---

## 1. `gold.dim_customers`

### Purpose

Contains the master customer information used for analysis, combining customer attributes with demographic and geographic details.

### Columns

| Column Name       | Data Type    | Description                                                                     |
| ----------------- | ------------ | ------------------------------------------------------------------------------- |
| `customer_key`    | INT          | Surrogate key used to uniquely identify a customer within the dimension.        |
| `customer_id`     | INT          | Business identifier associated with the customer in the source system.          |
| `customer_number` | NVARCHAR(50) | Alphanumeric customer identifier used for tracking and source-system reference. |
| `first_name`      | NVARCHAR(50) | Customer's first name.                                                          |
| `last_name`       | NVARCHAR(50) | Customer's last or family name.                                                 |
| `country`         | NVARCHAR(50) | Country associated with the customer's location.                                |
| `marital_status`  | NVARCHAR(50) | Customer's marital status, such as `Married` or `Single`.                       |
| `gender`          | NVARCHAR(50) | Customer's gender, standardized as `Male`, `Female`, or `n/a`.                  |
| `birthdate`       | DATE         | Customer's date of birth.                                                       |
| `create_date`     | DATE         | Date on which the customer record was originally created in the source system.  |

---

## 2. `gold.dim_products`

### Purpose

Provides descriptive information about products, including their classifications, characteristics, costs, and availability periods.

### Columns

| Column Name            | Data Type    | Description                                                                |
| ---------------------- | ------------ | -------------------------------------------------------------------------- |
| `product_key`          | INT          | Surrogate key used to uniquely identify a product within the dimension.    |
| `product_id`           | INT          | Business identifier assigned to the product in the source system.          |
| `product_number`       | NVARCHAR(50) | Alphanumeric product code used to identify and reference the product.      |
| `product_name`         | NVARCHAR(50) | Name and description of the product.                                       |
| `category_id`          | NVARCHAR(50) | Identifier of the product's category.                                      |
| `category`             | NVARCHAR(50) | High-level classification of the product, such as `Bikes` or `Components`. |
| `subcategory`          | NVARCHAR(50) | More specific classification of the product within its category.           |
| `maintenance_required` | NVARCHAR(50) | Indicates whether the product requires maintenance, such as `Yes` or `No`. |
| `cost`                 | INT          | Base cost associated with the product.                                     |
| `product_line`         | NVARCHAR(50) | Product line or segment, such as `Road`, `Mountain`, or `Touring`.         |
| `start_date`           | DATE         | Date from which the product became active or available.                    |

---

## 3. `gold.fact_sales`

### Purpose

Stores sales transactions at the **order-line level** and serves as the main fact table for sales-related analysis and reporting.

### Columns

| Column Name     | Data Type    | Description                                                                   |
| --------------- | ------------ | ----------------------------------------------------------------------------- |
| `order_number`  | NVARCHAR(50) | Identifier of the sales order associated with the transaction.                |
| `product_key`   | INT          | Surrogate key referencing the corresponding product in `gold.dim_products`.   |
| `customer_key`  | INT          | Surrogate key referencing the corresponding customer in `gold.dim_customers`. |
| `order_date`    | DATE         | Date on which the sales order was placed.                                     |
| `shipping_date` | DATE         | Date on which the order was shipped.                                          |
| `due_date`      | DATE         | Date by which the order was expected to be fulfilled or payment was due.      |
| `sales_amount`  | INT          | Total sales value for the individual order line.                              |
| `quantity`      | INT          | Number of units of the product included in the order line.                    |
| `price`         | INT          | Unit selling price of the product for the order line.                         |

---

## 🔗 Gold Layer Relationships

The Gold layer follows a **Star Schema** where the sales fact table is connected to the customer and product dimensions.

```text
                 ┌──────────────────────┐
                 │   dim_customers      │
                 │──────────────────────│
                 │ customer_key (PK)    │
                 │ customer_id          │
                 │ customer_number      │
                 │ ...                  │
                 └──────────┬───────────┘
                            │
                            │ customer_key
                            │
                    ┌───────▼────────┐
                    │   fact_sales   │
                    │────────────────│
                    │ order_number   │
                    │ customer_key   │
                    │ product_key    │
                    │ order_date     │
                    │ sales_amount   │
                    │ quantity       │
                    │ price          │
                    └───────┬────────┘
                            │
                            │ product_key
                            │
                 ┌──────────▼───────────┐
                 │    dim_products     │
                 │─────────────────────│
                 │ product_key (PK)    │
                 │ product_id          │
                 │ product_number      │
                 │ product_name        │
                 │ category            │
                 │ subcategory         │
                 │ ...                 │
                 └─────────────────────┘
```

### Data Model Summary

| Table                | Type      | Role                                                    |
| -------------------- | --------- | ------------------------------------------------------- |
| `gold.dim_customers` | Dimension | Provides customer attributes for analysis.              |
| `gold.dim_products`  | Dimension | Provides product and classification attributes.         |
| `gold.fact_sales`    | Fact      | Stores sales transactions and measurable sales metrics. |
