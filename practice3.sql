-- MATH OPERATIONS


-- Addition, Substraction and Multiplication

SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;


-- Integer, Modulo and Decimal Divisions

SELECT 11 / 6;
SELECT 11 % 6;
SELECT 11.0 / 6; 
SELECT CAST(11 AS numeric(3,1)) / 6;


-- Exponents, Roots and Factorials

SELECT 3 ^ 4;         -- Exponentiation
SELECT |/ 10;         -- Square Root (operator)
SELECT sqrt(10);      -- Square Root (function)
SELECT ||/ 10;        -- Cube Root
SELECT factorial(4);  -- Factorial (function)
SELECT 4 !;           -- Factorial (operator; PostgreSQL 13 and earlier only)


-- Percentile functions

CREATE TABLE percentile_test (
    numbers integer
);

INSERT INTO percentile_test (numbers) VALUES
    (1), (2), (3), (4), (5), (6);

SELECT
    percentile_cont(.5)
    WITHIN GROUP (ORDER BY numbers),
    percentile_disc(.5)
    WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;


-- Sum, Avg, Round and Percentile_Count functions

SELECT sum(pop_est_2019) AS county_sum,
       round(avg(pop_est_2019), 0) AS county_average,
       percentile_cont(.5)
       WITHIN GROUP (ORDER BY pop_est_2019) AS county_median
FROM us_counties_pop_est_2019;
