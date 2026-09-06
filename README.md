# Data Warehouse & Analytics Project

A complete **Data Warehouse and Analytics solution built with SQL Server**, covering the full data journey from raw source files to clean, integrated, and analytics-ready data.

The project focuses on applying practical **Data Engineering, ETL, Data Modeling, and SQL Analytics** concepts using a modern layered architecture.

---

## 🏗️ Data Architecture

The project follows the **Medallion Architecture**, which organizes the data platform into three main layers:

**Bronze → Silver → Gold**

![Data Architecture](docs/data_architecture.png)

### 🥉 Bronze Layer — Raw Data

The Bronze layer acts as the initial landing area for the source data.

* Loads data from the original CSV files without applying business transformations.
* Preserves the source data in its raw form.
* Provides a reliable starting point for the ETL process.

### 🥈 Silver Layer — Cleaned & Integrated Data

The Silver layer prepares the raw data for further processing.

Main activities include:

* Data cleansing
* Handling missing and inconsistent values
* Standardizing data formats
* Resolving data quality issues
* Integrating data from different source systems

### 🥇 Gold Layer — Business-Ready Data

The Gold layer contains the final analytical model.

Data is transformed into a **Star Schema** consisting of:

* Fact tables for measurable business events
* Dimension tables for descriptive attributes
* Relationships optimized for analytical queries and reporting

---

## 📌 Project Overview

The project covers the following major components:

### 1. Data Architecture

Designing a layered data warehouse using the **Bronze, Silver, and Gold** architecture.

### 2. ETL Development

Building SQL-based ETL processes to:

* Extract data from source files
* Load raw data into the Bronze layer
* Clean and transform data in the Silver layer
* Create analytical structures in the Gold layer

### 3. Data Modeling

Designing a dimensional model based on a **Star Schema** to make analytical queries simpler and more efficient.

### 4. Data Analytics

Developing SQL queries and analytical reports to investigate:

* Customer behavior
* Product performance
* Sales performance
* Sales trends
* Key business metrics

---

## 🎯 Project Objectives

The main objective is to build a centralized data warehouse capable of combining data from multiple source systems and transforming it into reliable, analysis-ready information.

The project demonstrates practical experience with:

* SQL Server
* SQL Development
* ETL Pipelines
* Data Cleaning
* Data Integration
* Data Warehousing
* Dimensional Data Modeling
* Star Schema
* Data Analytics

---

# 🚀 Data Warehouse Requirements

## Business Objective

Build a modern SQL Server Data Warehouse that consolidates sales-related information from different source systems and provides a reliable foundation for analytical reporting.

## Data Sources

The project uses data from two source systems:

* **ERP**
* **CRM**

The source data is provided as CSV files and contains information related to customers, products, sales, and other business entities.

## Data Quality

Before the data reaches the analytical layer, several data quality issues are addressed, including:

* Missing values
* Invalid or inconsistent records
* Different data formats
* Duplicate or conflicting information
* Inconsistent naming and attributes

## Data Integration

The ERP and CRM sources are integrated into a unified data model so that information from both systems can be analyzed together.

## Data Scope

The warehouse focuses on the **latest available dataset**.

Historical tracking and full historization are outside the scope of this project.

## Documentation

The project includes documentation covering:

* Data architecture
* Data flow
* Data models
* Data catalog
* Naming conventions
* ETL processes

This documentation helps explain how the data moves through the warehouse and how the final analytical model is structured.

---

# 📊 Analytics & Reporting

After completing the data warehouse, SQL-based analytical queries are used to generate business insights.

The analysis focuses primarily on:

### 👥 Customer Analysis

Understanding customer behavior and purchasing patterns.

### 📦 Product Analysis

Evaluating product performance and identifying important product-level metrics.

### 💰 Sales Analysis

Analyzing sales performance and identifying trends across the available data.

These analyses transform the warehouse data into useful information that can support business decisions.

---

# 📂 Repository Structure

```text
data-warehouse-project/
│
├── datasets/
│   └── Raw ERP and CRM CSV files
│
├── docs/
│   ├── etl.drawio
│   ├── data_architecture.drawio
│   ├── data_catalog.md
│   ├── data_flow.drawio
│   ├── data_models.drawio
│   ├── naming-conventions.md
│   └── requirements.md
│
├── scripts/
│   ├── bronze/
│   │   └── Raw data ingestion scripts
│   │
│   ├── silver/
│   │   └── Data cleaning and transformation scripts
│   │
│   └── gold/
│       └── Analytical model creation scripts
│
├── tests/
│   └── Data quality and validation scripts
│
├── README.md
├── .gitignore
└── requirements.txt
```

---

# 🛠️ Tools & Technologies

The project was developed using the following tools and technologies:

| Technology       | Purpose                                             |
| ---------------- | --------------------------------------------------- |
| **SQL Server**   | Database and Data Warehouse                         |
| **SSMS**         | Database development and management                 |
| **SQL**          | ETL, transformations, and analytics                 |
| **Draw.io**      | Architecture, data flow, and data modeling diagrams |
| **Git & GitHub** | Version control and project management              |
| **CSV**          | Source data format                                  |

---

# 🔄 Data Flow

The overall data processing flow can be summarized as:

```text
ERP CSV Files ──┐
                ├──> Bronze ──> Silver ──> Gold ──> Analytics
CRM CSV Files ──┘
```

Each layer has a specific responsibility, allowing the data pipeline to remain organized, maintainable, and easier to troubleshoot.

---

# 📚 Documentation

Additional project documentation is available inside the `docs` directory:

* **Data Architecture** — Overall architecture of the warehouse
* **Data Flow** — Movement of data between different layers
* **Data Models** — Star schema and table relationships
* **Data Catalog** — Description of datasets and fields
* **Naming Conventions** — Standardized naming rules
* **ETL Documentation** — Extraction, transformation, and loading processes
* **Requirements** — Business and analytical requirements

---

# 🧪 Data Quality & Testing

Validation and testing are performed throughout the ETL process to ensure that the resulting data is reliable.

Examples include:

* Checking for NULL values
* Identifying duplicate records
* Validating relationships between tables
* Checking data consistency
* Verifying row counts after transformations
* Validating the final Gold-layer data

---

# ⭐ Key Learning Outcomes

Through this project, I gained practical experience in:

* Designing a modern Data Warehouse architecture
* Working with the Medallion Architecture
* Building SQL-based ETL pipelines
* Cleaning and integrating data from multiple sources
* Designing dimensional models
* Building a Star Schema
* Writing analytical SQL queries
* Implementing data quality checks
* Documenting a complete data warehouse project
* Managing a data project using Git and GitHub

---

# 👨‍💻 About the Project

This repository represents my implementation of a complete **Data Warehouse and Analytics project**, developed as part of my journey into **Data Engineering**.

The goal was not only to build the warehouse, but also to understand the complete workflow of a real-world data platform — starting from source systems and ending with business-ready analytical data.
