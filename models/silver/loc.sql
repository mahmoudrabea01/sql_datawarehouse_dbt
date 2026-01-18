insert into silver.erp_loc_a101 (
			[cid] ,
			[country] 
	)
	select REPLACE(cid, '-' , '') as cid ,
	case when upper(trim([country])) in ( 'DE' , 'GERMANY') THEN 'germany'
		when upper(trim([country])) in ( 'US' , 'UNITED STATES' , 'USA') THEN 'USA'
		when upper(trim([country])) in ( 'UK' , 'UNITED KINGDOM') THEN 'UK'
		when upper(trim([country])) = '' or [country] is  NULL  THEN 'N/A'
		ELSE trim([country]) end as [country]
	from {{ ref('loc_a101')}};
