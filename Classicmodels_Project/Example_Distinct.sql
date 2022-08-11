/*
When querying data from a table, you may get duplicate rows.
To remove these duplicate rows, you use the DISTINCT clause in the SELECT statement.
SELECT DISTINCT
    select_list
FROM
    table_name
WHERE
    search_condition
ORDER BY
    sort_expression;

When executing the SELECT statement with the DISTINCT clause, MySQL evaluates the DISTINCT clause
 after the FROM, WHERE, and SELECT clause and before the ORDER BY clause:
 FROM > WHERE > SELECT > DISTINCT > ORDER BY
*/

-- Example to select employees with unique last names:
SELECT DISTINCT
  lastName
FROM
  employees
ORDER BY
 lastName;

-- Use the IN operator to check if a value is in a set of values.
-- Use the IN operator to form a condition for the WHERE clause.
/*
In case the list has many values, you need to construct a very long statement with multiple OR operators.
Hence, the IN operator allows you to shorten the query and make it more readable.
*/

-- to find the offices located in the USA and France:
SELECT
    officeCode,
    city,
    phone,
    country
FROM
    offices
WHERE
    country IN ('USA' , 'France');

-- Use the MySQL NOT IN to check if a value doesn’t match any value in a list.
-- to find the offices that do not locate in France and the USA:
SELECT
    officeCode,
    city,
    phone
FROM
    offices
WHERE
    country NOT IN ('USA' , 'France')
ORDER BY
    city;
