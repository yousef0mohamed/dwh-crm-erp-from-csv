/*
===============================================================================
Gold Layer - Data Quality Validation
===============================================================================
Purpose:
    This script validates the quality and integrity of the data stored in the
    Gold layer.

    The validation focuses on:
    - Ensuring surrogate keys in dimension tables are unique.
    - Verifying that fact records have valid references to their dimensions.
    - Confirming that the relationships between fact and dimension tables
      are correctly maintained for analytical workloads.

Usage:
    Run these checks after the Gold layer has been populated or refreshed.

    Any returned records should be investigated and corrected before using
    the Gold layer for reporting or analytical purposes.
===============================================================================
*/

-- ====================================================================
-- Validate 'gold.dim_customers'
-- ====================================================================
-- Check for duplicate customer surrogate keys
-- Expected Result: No rows
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Validate 'gold.dim_products'
-- ====================================================================
-- Check for duplicate product surrogate keys
-- Expected Result: No rows
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Validate 'gold.fact_sales'
-- ====================================================================
-- Check whether every fact record is linked to an existing
-- customer and product dimension record
-- Expected Result: No rows
SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p
    ON p.product_key = f.product_key
WHERE c.customer_key IS NULL
   OR p.product_key IS NULL;
```
