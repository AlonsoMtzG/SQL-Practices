-- Import & Export Practice 



-- Import

-- Create table to store the data with the same columns of the .csv file

-- Import data
-- We have to make de data accesible to the postgres user

-- General syntax for importing .csv file 
COPY table_name
FROM '/path/to/file'
WITH (FORMAT CSV, HEADER);

-- We can specify the columns to import
COPY table_name (column1, column2, column3)
FROM '/path/to/file'
WITH (FORMAT CSV, HEADER);

-- And also rows
COPY table_name (column1, column2, column3)
FROM '/path/to/file'
WITH (FORMAT CSV, HEADER)
WHERE column2 = 'Value';



-- Export

-- We use the same import procedure, but now with 'TO' instead of 'FROM'.
-- And setting the delimiter
COPY table_name
TO '/path/to/file'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- And in the same way we can also specify columns to export
COPY table_name (column1, column2, column3)
TO '/path/to/file'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

-- Also we can export a query result
COPY (
    SELECT column1, column2
    FROM table_name
    WHERE column3 ILIKE '%alu%'
     )
TO '/path/to/file'
WITH (FORMAT CSV, HEADER);
