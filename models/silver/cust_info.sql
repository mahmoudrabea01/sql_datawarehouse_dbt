with cte_customer as(select * ,
				ROW_NUMBER() over (partition by [cst_id] order by [cst_create_date] desc) as row_num
				from {{ ref('cust_info')}}
					where  [cst_id] is not null
	)
	insert into [silver].[crm_customers_info] (
		[cst_id],
		[cst_key] ,
		[cst_firstname] ,
		[cst_lastname] ,
		[cst_marital_status] ,
		[cst_gender] ,
		[cst_create_date]
	)
	select 
		[cst_id],
		[cst_key],
		trim([cst_firstname]) as cst_firtname,
		trim([cst_lastname]) as cst_lastname,
			case when
				upper([cst_marital_status]) = 'S' then 'Single'
			when 
				upper([cst_marital_status]) = 'M' then 'Married'
			else 'n/a' 
			end as [cst_marital_status] ,

		case when
				upper([cst_gender]) = 'M' then 'Male'
			when 
				upper([cst_gender]) = 'F' then 'Female'
			else 'n/a' 
			end as cst_gender,
			[cst_create_date]
	from {{ ref('cust_info')}}
	where row_num = 1 ;