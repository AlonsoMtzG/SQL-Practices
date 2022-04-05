-- Lists the schools in alphabetical order along with 
-- the teachers ordered by the last name A-Z
SELECT *
 FROM teachers
ORDER BY school ASC, last_name ASC;

-- Finds the one teacher whose first name starts
-- with the letter S and who earns more than $40 000
SELECT *
FROM teachers
WHERE first_name LIKE ‘s%’
AND salary > 40000

-- Rank teachers hired since January 1, 2010, 
-- ordered by highest pait to lowest
SELECT *
FROM teachers
WHERE hire_date >= to_date('01-Jan-2010','DD-MON-YYYY')
ORDER BY salary DESC;
