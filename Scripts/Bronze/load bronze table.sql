-- load bronze table 

create or replace procedure load_bronze_tables()
language plpgsql
as $$
declare
    start_time timestamp;
    end_time timestamp;
    start_batch_time timestamp;
    end_batch_time timestamp;
begin 
    raise notice 'start load_bronze_tables procedure';
    raise notice 'start load crm_cust_info';
    start_time := clock_timestamp();
    start_batch_time := clock_timestamp();
    
    
    raise notice 'truncate bronze.crm_cust_info';
    truncate table bronze.crm_cust_info;
    copy bronze.crm_cust_info 
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_crm\cust_info.csv'
    with (format csv,
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for crm_cust_info';
    -- now start loading the next table crm product info
    raise notice 'start load crm_prd_info';
    start_time := clock_timestamp();
    raise notice 'truncate bronze.crm_prd_info';
    truncate table bronze.crm_prd_info;
    copy bronze.crm_prd_info 
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_crm\prd_info.csv'
    with (format csv,
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for crm_prd_info';
    -- now start loading the next table crm sales details
    raise notice 'start load crm_sales_details';
    start_time := clock_timestamp();
    raise notice 'truncate bronze.crm_sales_details';
    truncate table bronze.crm_sales_details;
    copy bronze.crm_sales_details
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_crm\sales_details.csv'
    with (format csv,
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for crm_sales_details';

    -- load the next table erp_cust_az12
    raise notice 'start load erp_cust_az12';
    start_time := clock_timestamp();
    raise notice 'truncate bronze.erp_cust_az12';
    truncate table bronze.erp_cust_az12;
    copy bronze.erp_cust_az12
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_erp\CUST_AZ12.csv'
    with (format csv,
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for erp_cust_az12';
    -- load the next table erp_loc_a101
    raise notice 'start load erp_loc_a101';
    start_time := clock_timestamp();
    raise notice 'truncate bronze.erp_loc_a101';
    truncate table bronze.erp_loc_a101;
    copy bronze.erp_loc_a101
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_erp\LOC_A101.csv'
    with (format csv,
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for erp_loc_a101';
    -- load the next table erp_px_cat_g1v2
    raise notice 'start load erp_px_cat_g1v2';
    start_time := clock_timestamp();
    
    raise notice 'truncate bronze.erp_px_cat_g1v2';
    truncate table bronze.erp_px_cat_g1v2;
    copy bronze.erp_px_cat_g1v2
    from 'C:\Users\DELL\Desktop\study\sql\SQL\datasets\source_erp\PX_CAT_G1V2.csv'
    with (format csv,   
          header true,
          delimiter ',');
    end_time := clock_timestamp();
    raise notice 'Total Time Taken: %', end_time - start_time;
    raise notice 'csv load completed for erp_px_cat_g1v2';
    end_batch_time := clock_timestamp();
    raise notice 'Total Time Taken for all tables: %', end_batch_time - start_batch_time;
    raise notice 'load_bronze_tables procedure completed';


end;
$$;

call load_bronze_tables();
