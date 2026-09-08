/*
===============================================================================
DDL Script: Create Gold Layer Views
===============================================================================
Purpose:
    This script creates the views used in the Gold layer of the data warehouse.

    The Gold layer provides the final business-ready representation of the
    data, following a Star Schema structure that includes dimension and fact
    views.

    Each view retrieves and integrates data from the Silver layer while
    applying the required transformations, standardization, and enrichment
    to prepare the data for analytical use.

Usage:
    - Execute this script to create or update the Gold layer views.
    - The resulting views can be queried for reporting, analysis, and
      downstream business intelligence processes.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
	ci.cst_id                           AS customer_id,
	ci.cst_key                          AS customer_number,
	ci.cst_firstname                    AS first_name,
	ci.cst_lastname                     AS last_name,
	la.cntry                            AS country,
	ci.cst_marital_status               AS marital_status,
	
  CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		   ELSE COALESCE(ca.gen , 'n/a')
	END AS gender,
	
  ci.cst_create_date                   AS create_date,
	ca.bdate                             AS birth_date
	
FROM silver.crm_cust_info ci
LEFT OUTER JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT OUTER JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt , pn.prd_key) AS product_key,
	pn.prd_id       AS product_id,
	pn.prd_key      AS product_number,
	pn.prd_nm       AS product_name,
	pn.cat_id       AS category_id,
	pc.cat          AS category,
	pc.subcat       AS subcategory,
	pc.maintenance  AS maintenance,
	pn.prd_cost     AS cost,
	pn.prd_line     AS product_line,
	pn.prd_start_dt AS start_date

FROM silver.crm_prd_info pn
LEFT OUTER JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id 
WHERE prd_end_dt IS NULL -- Filter out all historical data

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO 

CREATE VIEW gold.fact_sales AS
SELECT
	sd.sls_ord_num  AS order_number,
	pr.product_key  AS product_key,
	cu.customer_key AS customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt  AS shipping_date,
	sd.sls_due_dt   AS due_date,
	sd.sls_sales    AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price    AS price
FROM silver.crm_sales_details sd
LEFT OUTER JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT OUTER JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id
