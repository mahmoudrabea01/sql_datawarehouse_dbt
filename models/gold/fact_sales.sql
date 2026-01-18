create view gold.fact_sales as 
select 
	sd.sls_order_num as order_number ,
	dc.customer_key as customer_key ,
	dp.product_key as product_key ,
	sd.sls_order_date as order_date ,
	sd.sls_ship_date as ship_date ,
	sd.sls_due_date as delivered_date ,
	sd.sls_price as price ,
	sd.sls_quantity as quantity ,
	sd.sls_sales as sales 
from {{ ref('sales_details')}} as sd
left join {{ref('dim_customers')}} as dc
	on sd.sls_cust_id = dc.customer_id
left join {{ ref('dim_product')}} as dp
	on sd.sls_prd_key = dp.product_number ;