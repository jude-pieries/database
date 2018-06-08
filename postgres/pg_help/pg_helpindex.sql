CREATE OR REPLACE function pg_helpindex ( _schemaname varchar, _tablename varchar) 
RETURNS TABLE ( schema_nameV name , 
				table_nameV name ,
				index_name name , 
				index_def text , 
				indexoptions text[] , 
				IndexRows float4 ,
				index_scan bigint ,
				index_reads bigint , 
				index_fetch bigint 
			 ) 
LANGUAGE plpgsql 
SECURITY INVOKER 
AS $function$ 
BEGIN 
RETURN QUERY 
SELECT 
   n.nspname  as "schema_nameV" ,
  t.relname  as "table_nameV",
  c.relname  as "index_name",
  pg_get_indexdef(i.indexrelid) as "index_def",
  c.reloptions "indexoptions" , 
  c.reltuples "IndexRows" ,  
  iu.idx_scan "index_scan", 
  iu.idx_tup_read "index_reads", 
  iu.idx_tup_fetch "index_fetch"--,   c.oid , c.relname , t.oid ,t.relname , c.* 

FROM pg_catalog.pg_class c
  JOIN pg_catalog.pg_namespace n ON n.oid        = c.relnamespace
  JOIN pg_catalog.pg_index i ON i.indexrelid = c.oid
  JOIN pg_catalog.pg_class t ON i.indrelid   = t.oid
  JOIN pg_stat_user_indexes iu on 
  c.oid = iu.indexrelid
WHERE c.relkind = 'i'
  and n.nspname not in ('pg_catalog', 'pg_toast')
  and pg_catalog.pg_table_is_visible(c.oid)

and t.relname  = lower(_tablename)
and n.nspname  = lower(_schemaname); 

END $function$ ;
