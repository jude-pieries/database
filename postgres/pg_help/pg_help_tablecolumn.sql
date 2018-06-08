CREATE OR REPLACE FUNCTION pg_help_tablecolumn ( _schemaname name, _routinename name)
RETURNS TABLE ( dbname information_schema.sql_identifier , 
				tableschema information_schema.sql_identifier, 
				tablename information_schema.sql_identifier,  
				columnname information_schema.sql_identifier, 
				isnullable 	information_schema.yes_or_no, 
				default_value information_schema.character_data,  
				datatype information_schema.character_data ,  
				Column_Length information_schema.cardinal_number ,
				numericscale information_schema.cardinal_number , 
				datetimeprecision information_schema.cardinal_number 
				)
LANGUAGE PLPGSQL
AS $$
BEGIN
	RETURN QUERY
	SELECT table_catalog dbname , 
			table_schema tableschema, 
			table_name tablename,  
			column_name columnname, 
			is_nullable isnullable,
			column_default default_value,  
			data_type datatype  , 
			character_maximum_length Column_Length,
			numeric_scale numericscale, 
			datetime_precision  datetimeprecision
	FROM information_schema.columns 
	WHERE  table_schema= LOWER(_schemaname) and 
			table_name = LOWER(_routinename) 
	ORDER BY ordinal_position;
END ;
$$;