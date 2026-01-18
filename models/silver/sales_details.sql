
	insert into [silver].[crm_sales_details](
	[sls_order_num] ,
	[sls_prd_key] ,
	[sls_cust_id] ,
	[sls_order_date] ,
	[sls_ship_date] ,
	[sls_due_date] ,
	[sls_sales] ,
	[sls_quantity] ,
	[sls_price]
	)
	select
	[sls_order_num] ,
	[sls_prd_key] ,
	[sls_cust_id] ,
	case
		when [sls_order_dt] <=0 or LEN([sls_order_dt]) != 8 then null
		else cast(cast( [sls_order_dt] as varchar) as date )
		end as sls_order_dt,
	case
		when [sls_ship_date] <=0 or LEN([sls_ship_date]) != 8 then null
		else cast(cast( [sls_ship_date] as varchar) as date )
		end as sls_ship_date,
	case
		when [sls_due_date] <=0 or LEN([sls_due_date]) != 8 then null
		else cast(cast( [sls_due_date] as varchar) as date )
		end as sls_due_date, -- even the ship and due dates are perfect but we consider issues in the future
	case when [sls_sales] is null or [sls_sales] <= 0 or [sls_sales] != [sls_quantity] * ABS([sls_price])
		 then [sls_quantity] * ABS([sls_price]) 
		 else [sls_sales] end as [sls_sales],
	[sls_quantity] , -- no issue
	case when [sls_price] is null or [sls_price] <= 0 or [sls_price] != ABS([sls_sales]) /[sls_quantity] 
		 then ABS([sls_sales]) /[sls_quantity] 
		 else [sls_price] end as [sls_price]
	from {{ ref('sales_details')}} ;