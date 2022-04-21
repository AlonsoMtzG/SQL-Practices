-- Create tables

CREATE TABLE district_2020 (
    id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);

CREATE TABLE district_2035 (
    id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

-- Insert values 

INSERT INTO district_2020 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Webutuck High School');

-- JOIN

SELECT *
FROM district_2020 JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- INNER JOIN
SELECT *
FROM district_2020 INNER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- JOIN with USING (ids won't be shown)

SELECT *
FROM district_2020 JOIN district_2035
USING (id)
ORDER BY district_2020.id;

-- LEFT JOIN (join using data from left table)

SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- RIGHT JOIN (join using data from right table)

SELECT *
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2035.id;

-- FULL OUTER JOIN

SELECT *
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- CROSS JOIN

SELECT *
FROM district_2020 CROSS JOIN district_2035
ORDER BY district_2020.id, district_2035.id;

-- CROSS JOIN simplified as a SELECT from two tables:
SELECT *
FROM district_2020, district_2035
ORDER BY district_2020.id, district_2035.id;

-- CROSS JOIN == JOIN with true in the ON clause:
SELECT *
FROM district_2020 JOIN district_2035 ON true
ORDER BY district_2020.id, district_2035.id;

-- Filter missing values in JOIN with IS NULL

SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2035.id IS NULL;

-- RIGHT JOIN
SELECT *
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2020.id IS NULL;

-- Select columns from JOIN

SELECT district_2020.id,
       district_2020.school_2020,
       district_2035.school_2035
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- Using aliases

SELECT d20.id,
       d20.school_2020,
       d35.school_2035
FROM district_2020 AS d20 LEFT JOIN district_2035 AS d35
ON d20.id = d35.id
ORDER BY d20.id;

-- JOIN on multiple tables
SELECT d20.id,
       d20.school_2020,
       en.enrollment,
       gr.grades
FROM district_2020 AS d20 JOIN district_2020_enrollment AS en
    ON d20.id = en.id
JOIN district_2020_grades AS gr
    ON d20.id = gr.id
ORDER BY d20.id;

-- Combining query results with UNION
-- Note: Result is a list of unique fields 
SELECT * FROM district_2020
UNION
SELECT * FROM district_2035
ORDER BY id;

-- Combining query results with UNION ALL
-- Result is a list with all fields from all tables
SELECT * FROM district_2020
UNION ALL
SELECT * FROM district_2035
ORDER BY id;

-- Combine with UNION query

SELECT '2020' AS year,
       school_2020 AS school
FROM district_2020

UNION ALL

SELECT '2035' AS year,
       school_2035
FROM district_2035
ORDER BY school, year;

-- INTERSECT: All that are in A and B``

SELECT * FROM district_2020
INTERSECT
SELECT * FROM district_2035
ORDER BY id;


-- EXCEPT: All from A that are not in B
SELECT * FROM district_2020
EXCEPT
SELECT * FROM district_2035
ORDER BY id;
