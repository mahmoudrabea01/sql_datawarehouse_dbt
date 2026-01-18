insert into [silver].[crm_product_info] (
	[prd_id],
	[prd_key],
	[cat_id],
	[prd_id_key],
	[prd_nm],
	[prd_cost],
	[prd_line],
	[prd_start_date],
	[prd_end_dt]
	)
	select [prd_id] , -- no duplicate
		[prd_key] ,
		replace(SUBSTRING([prd_key] , 1 , 5) ,'-' , '_') as cat_id ,
		SUBSTRING([prd_key] , 7 , LEN([prd_key] ) ) as prd_id_key ,
		[prd_nm], -- no need for triming
		isnull([prd_cost] , 0) as [prd_cost] ,
		case 
			when upper(trim([prd_line])) = 'M' then 'Mountain'
			when upper(trim([prd_line])) = 'S' then 'Other_Sales'
			when upper(trim([prd_line])) = 'R' then 'Road'
			when upper(trim([prd_line])) = 'T' then 'Touring'
		else 'n/a' end as [prd_line] ,
		cast([prd_start_date] as date) as prd_start_date ,
		cast(lead([prd_start_date]) over(partition by prd_key order by [prd_start_date]) -1 as date ) as prd_end_dt
	from {{ ref('prd_info')}} ;
