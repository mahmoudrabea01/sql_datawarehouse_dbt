insert into [silver].[erp_cust_az12] (
		[cid] ,
		[birth_date] ,
		[gender]
	)
	select 
		case when [cid] like 'NAS%' THEN SUBSTRING([cid] , 4 , LEN([cid]))
		else [cid] end as [cid],
		case when [birth_date] > GETDATE() then null
		else [birth_date] end as [birth_date] ,
		case when upper(trim([gender])) = 'F' then 'Female' 
		when upper(trim([gender])) = 'M' then 'Male' 
		when trim([gender]) = '' or [gender] = null then 'n/a'
		else trim([gender]) end as [gender]
	--we can go as 	-- case when upper(trim([gender])) in ('F' , 'FEMALE' ) then 'Female'
					--	when upper(trim([gender])) in ('M' , 'MALE' ) then 'Male'
					-- else 'n/a'
	from {{ ref('cust_az12')}} ;