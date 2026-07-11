CALL bronze.load_bronze();


select * from bronze.crm_cust_info;

SELECT 
    cst_id, 
    COUNT(*) AS customer_count
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


select * from bronze.crm_cust_info
where cst_id = '29449'
;