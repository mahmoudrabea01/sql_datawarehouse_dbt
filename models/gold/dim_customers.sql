create view gold.dim_customers as
select
	ROW_NUMBER() over (order by ci.[cst_id]) as customer_key ,
	ci.[cst_id] as customer_id ,
	ci.[cst_key] as customer_number ,
	ci.[cst_firstname] as first_name ,
	ci.[cst_lastname] as last_name ,
	cl.country ,
	ci.[cst_marital_status] as marital_status ,
	case when ci.[cst_gender] != 'n/a' then ci.[cst_gender]
	else coalesce(ca.gender , 'n/a') 
	end as gender ,
	ca.birth_date as birthdate ,
	ci.cst_create_date as create_date
from {{ ref('cust_info')}} as ci
left join {{ ref('cust_az')}} as ca
	on ci.cst_key = ca.cid
left join {{ ref('loc')}} as cl
	on ci.cst_key = cl.cid ;
