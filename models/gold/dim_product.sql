create view gold.dim_products as
select
	ROW_NUMBER() over (order by pn.[prd_start_date] , pn.[prd_id_key]) as product_key ,
	pn.[prd_id] as product_id ,
	pn.[prd_id_key] as product_number ,
	pn.[cat_id] as category_id ,
	ct.cat as category ,
	ct.subcat as sub_category ,
	pn.[prd_nm] as product_name ,
	pn.[prd_line] as product_line ,
	pn.[prd_cost] as product_cost ,
	ct.maintenance ,
	pn.[prd_start_date] as start_date 
from {{ ref('prd_info')}} as pn
left join {{  ref('px_cat')}} ct
on pn.cat_id = ct.id
where pn.[prd_end_dt] is null; -- to filter out hist data