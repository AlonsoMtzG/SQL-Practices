-- CLEANING DATABASE

CREATE TABLE meat_poultry_egg_establishments (
    establishment_number text CONSTRAINT est_number_key PRIMARY KEY,
    company text,
    street text,
    city text,
    st text,
    zip text,
    phone text,
    grant_date date,
    activities text,
    dbas text
);

COPY meat_poultry_egg_establishments
FROM '/tmp/MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX company_idx ON meat_poultry_egg_establishments (company);

-- Count the rows imported:
SELECT count(*) FROM meat_poultry_egg_establishments;


-- FINDING DUPLICATES

-- Multiple companies at the same address

SELECT company,
       street,
       city,
       st,
       count(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- Grouping and counting states

SELECT st, 
       count(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;


-- FINDING NULL RECORDS

-- Using IS NULL to find missing values in the st column

SELECT establishment_number,
       company,
       city,
       st,
       zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;


-- CONSTRAINTS FOR SOME COLUMNS

-- Using length() and count() to test the zip column

SELECT length(zip),
       count(*) AS length_count
FROM meat_poultry_egg_establishments
GROUP BY length(zip)
ORDER BY length(zip) ASC;

-- Filtering with length() to find short zip values

SELECT st,
       count(*) AS st_count
FROM meat_poultry_egg_establishments
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;


-- FIX

-- Backing up a table

CREATE TABLE meat_poultry_egg_establishments_backup AS
SELECT * FROM meat_poultry_egg_establishments;

-- Creating and filling the st_copy column with ALTER TABLE and UPDATE

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN meat_processing boolean;

UPDATE meat_poultry_egg_establishments set meat_processing = true WHERE activities LIKE '%Meat Processing%';

-- Using max aggregation function to keep one record for duplicated results

SELECT max(establishment_number)
FROM meat_pultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- Clean data 
DELETE FROM meat_pultry_egg_establishments
WHERE establishment_number not in (
       SELECT max(establishment_number)
       FROM meat_pultry_egg_establishments
       GROUP BY company, street, city, st
);


-- Data consistency is important in databases. This can be achieved using TRANSACTIONS.
-- If something fails inside a transaction, it's possible to rollback. This will not save the changes.

-- Start transaction

UPDATE meat_pultry_egg_establishments SET company = 'wrong data';

rollback;

-- Call 'commit;' to save
-- Use transaction every update of data.




