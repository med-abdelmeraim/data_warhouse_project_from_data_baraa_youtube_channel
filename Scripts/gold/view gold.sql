
-- dim costumer 

DROP VIEW IF EXISTS gold.dim_customers;

CREATE VIEW gold.dim_customers AS

select 
    cs.cst_id      as customer_id,
    cs.cst_key      as customer_key,
    cs.cst_firstname      as first_name,
    cs.cst_lastname        as last_name,
    ci.bdate        as birthday,
    case when ci.gen = 'n/a' then cs.cst_gndr
        when  cs.cst_gndr ='n/a' then ci.gen
        else cs.cst_gndr
        end as gender ,
    cs.cst_marital_status   as marital_status   , 
    cp.cntry     as country,
    cs.cst_create_date     
from silver.crm_cust_info  cs
LEFT JOIN silver.erp_cust_az12 ci 
    ON cs.cst_key = ci.cid
LEFT JOIN silver.erp_loc_a101 cp
    ON  cs.cst_key = cp.cid;

-- dim product 
DROP VIEW IF EXISTS gold.dim_products;

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
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
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL; -- Filter out all historical data


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================

DROP VIEW IF EXISTS gold.fact_sales;

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
LEFT JOIN gold.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id ;

