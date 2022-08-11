-- The WHERE clause allows you to specify a search condition for the rows returned by a query.
SELECT
    select_list
FROM
    table_name
WHERE
    search_condition;

/*
- the search_condition can be a combination of one or more expressions using
the logical operator AND, OR and NOT.
- In MySQL, a predicate is a Boolean expression that evaluates to TRUE, FALSE,
or UNKNOWN.
- The SELECT statement will include any row that satisfies the search_condition
in the result set.
- Besides the SELECT statement, you can use the WHERE clause in the UPDATE or DELETE
statement to specify which rows to update or delete.
- When executing a SELECT statement with a WHERE clause,

note:
MySQL evaluates the WHERE clause after the FROM clause and before the SELECT and ORDER BY clauses:
FROM > WHERE > SELECT > ORDER BY
*/

-- Using MySQL WHERE clause with equality operator example
-- The following query uses the WHERE clause to find all employees whose job titles are Sales Rep:
SELECT
  lastName,
  firstName,
  jobTitle
FROM
  employees
WHERE
  jobTitle='Sales Rep';


-- Using MySQL WHERE clause with the AND operator
-- The following eg finds employees whose job titles are Sales Rep and office codes are 1
SELECT
  lastName,
  firstName,
  jobTitle
FROM
  employees
WHERE
  jobTitle = 'Sales Rep' AND officeCode = 1;


-- Using MySQL WHERE clause with OR operator
-- This query finds employees whose job title is Sales Rep or employees who locate the office with office code 1
SELECT
  lastName,
  firstName,
  jobTitle,
  officeCode
FROM
  employees
WHERE
  jobTitle = 'Sales Rep' OR officeCode = 1
ORDER BY
  officeCode,
  jobTitle;

-- Using MySQL WHERE clause with the BETWEEN operator example
--The following query finds employees who locate in offices whose office code is from 1 to 3:
SELECT
  lastName,
  firstName,
  officeCode
FROM
  employees
WHERE
  officeCode BETWEEN 1 AND 3
ORDER BY
  officeCode;

--  Using MySQL WHERE clause with the LIKE operator example
/*
- The LIKE operator evaluates to TRUE if a value matches a specified pattern.
- To form a pattern, you use the % and _ wildcards.
- The % wildcard matches any string of zero or more characters
- the _ wildcard matches any single character.
*/
--Example The following query finds the employees whose last names end with the string 'son'
SELECT
  lastName,
  firstName,
  jobTitle
FROM
  employees
WHERE
  lastName LIKE '%son'
ORDER BY
  firstName;


--Using MySQL WHERE clause with the IN operator example
-- The IN operator returns TRUE if a value matches any value in a list.
--For example to find employees who locate in the office with office code 1, 2 and 3 see below:
SELECT
  lastName,
  firstName,
  officeCode
FROM
  employees
WHERE
  officeCode IN (1,2,3)
ORDER BY
  officeCode;


--  Using MySQL WHERE clause with the IS NULL operator
-- To check if a value is NULL or not, you use the IS NULL operator, not the equal operator (=).
-- The IS NULL operator returns TRUE if a value is NULL.
-- In the database world, NULL is a marker that indicates that a value is missing or unknown.
-- take note NULL is not equivalent to the number 0 or an empty string.
SELECT
  lastName,
  firstName,
  officeCode
FROM
  employees
WHERE
  reportsTo IS NULL;


-- Using MySQL WHERE clause with comparison operators
/*
Operator	Description
=	Equal to. You can use it with almost any data type.
<> or !=	Not equal to
<	Less than. You typically use it with numeric and date/time data types.
>	Greater than.
<=	Less than or equal to
>=	Greater than or equal to
*/

--Example to see all employees that are not sales reps:
SELECT
  lastName,
  firstName,
  jobTitle
FROM
  employees
WHERE
  jobTitle <> 'Sales Rep';
