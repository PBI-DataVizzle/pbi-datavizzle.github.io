WITH info_schema_columns_data AS (
        SELECT 
            COLUMN_NAME AS column_name, 
            DATA_TYPE AS old_data_type,
            CASE 
                WHEN DATA_TYPE = 'varchar' THEN 'nvarchar'
                WHEN DATA_TYPE IN ('bit', 'int', 'bigint', 'smallint', 'money', 'tinyint') THEN 'int'
                ELSE DATA_TYPE
            END AS new_data_type, 
            NUMERIC_PRECISION AS numeric_precision,
            NUMERIC_SCALE AS numeric_scale,
            CHARACTER_MAXIMUM_LENGTH AS old_data_length,
            CASE 
                WHEN DATA_TYPE IN ('bit', 'int', 'bigint', 'smallint', 'money', 'tinyint')
                AND COALESCE( NUMERIC_PRECISION,NUMERIC_SCALE) IS NOT NULL
                THEN CAST(CONCAT(NUMERIC_PRECISION, ',', NUMERIC_SCALE ) AS NVARCHAR) 
                ELSE CAST(CHARACTER_MAXIMUM_LENGTH AS NVARCHAR) 
            END AS data_length,
            IS_NULLABLE AS is_nullable,
            ROW_NUMBER() OVER (ORDER BY ORDINAL_POSITION) AS rn
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = 'Sales'  
        AND TABLE_NAME = 'SalesOrderHeader'   
    ),
    cte_prepared_output AS (
        SELECT 
            column_name,
            old_data_type,
            new_data_type,
            old_data_length,
            data_length,
            CASE
                WHEN data_length IS NULL THEN NULL
                WHEN data_length = -1 THEN '(MAX)'
                WHEN data_length IS NOT NULL THEN CONCAT('(', data_length, ')')
                ELSE CONCAT( '(', 
                        CASE 
                            WHEN old_data_length BETWEEN 9 AND 10 THEN 10
                            WHEN old_data_length BETWEEN 11 AND 15 THEN 15
                            WHEN old_data_length BETWEEN 16 AND 20 THEN 20
                            WHEN old_data_length BETWEEN 90 AND 100 THEN 100
                            WHEN old_data_length BETWEEN 101 AND 200 THEN 200
                            WHEN old_data_length BETWEEN 201 AND 255 THEN 255
                            ELSE old_data_length
                        END
                , ')' )
            END AS new_data_length, 
            is_nullable,
            rn
        FROM info_schema_columns_data
    )
    SELECT 
        column_name,
        old_data_type,
        new_data_type,
        data_length,
        new_data_length,
        is_nullable,

        -- these case statements provide a pastable script for your 'INSERT INTO' snippet. v2 is wrapped in square brackets
        CASE 
            WHEN rn = 1 THEN column_name
            ELSE ', ' + column_name
        END AS insert_table_script,

		CASE 
            WHEN rn = 1 THEN CONCAT('[',column_name,']')
            ELSE ', ' + CONCAT('[',column_name,']')
        END AS insert_table_script_v2,

        -- these case statements provide a pastable script for your 'CREATE TABLE' snippet. v2 is wrapped in square brackets
        CASE 
            WHEN rn = 1 THEN CONCAT_WS( '  ', column_name , UPPER(new_data_type) , new_data_length )
            ELSE ', ' + CONCAT_WS( '  ', column_name , UPPER(new_data_type) , new_data_length )
        END AS create_table_script,
		CASE 
            WHEN rn = 1 THEN CONCAT_WS( '  ', CONCAT('[',column_name,']') , UPPER(new_data_type) , new_data_length )
            ELSE ', ' + CONCAT_WS( '  ', CONCAT('[',column_name,']') , UPPER(new_data_type) , new_data_length )
        END AS create_table_script_v2
    FROM cte_prepared_output;
