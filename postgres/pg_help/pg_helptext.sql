CREATE OR REPLACE function pg_helptext ( _schemaname name, _routinename name)
RETURNS TABLE (function_text text, function_arguments text ) 
LANGUAGE plpgsql 
AS  $$
BEGIN 
RETURN  QUERY
	SELECT pg_get_functiondef(f.oid) , pg_get_function_arguments(f.oid)
	FROM pg_catalog.pg_proc f
	INNER JOIN pg_catalog.pg_namespace n ON (f.pronamespace = n.oid)
	WHERE n.nspname = lower(_schemaname)  and
		  f.proname = lower(_routinename) ; 
	END; 
$$;
