-- MySQL supports two kinds of aliases: column alias and table alias.

/*
Sometimes, column names are so technical that make the query’s output very
difficult to understand. To give a column a descriptive name, you can use a column alias.
SELECT
   [column_1 | expression] AS `descriptive name`
FROM
   table_name;

-- you can also give an expression an alias
-- because the AS keyword is optional you can omit it
-- (but i think it is better to use it as it avoids confusion.
*/

--Example:joining the first and last names of employess to give the full name
SELECT
  CONCAT_WS(' ', lastName, FirstName)
FROM
  employees
ORDER BY
  'Full Name';
-- with this query the column name would be 'CONCAT_WS(' ', lastName, FirstName)' which is too long

-- so you can use and alias and call it full name
  SELECT
    CONCAT_WS(' ', lastName, FirstName) AS 'Full name'
  FROM
    employees
  ORDER BY
    'Full Name';

-- Example to selects the orders whose total amount is greater than 60000.
-- Very important take note of the quotes for Order no.
SELECT
  orderNumber `Order no.`,
  SUM(priceEach * quantityOrdered) total
FROM
  orderdetails
GROUP BY
  `Order no.`
HAVING
  total > 60000;
/* important to note that you cannot use column alias with WHERE clause.
This is because when MySQL evaluates the WHERE clause, the values of the columns specified
in the SELECT clause have not been evaluated yet.
*/


--MySQL alias for tables
-- You can use an alias to give a table a different name.
-- table_name AS table_alias

-- Example assigning the employees table alias as e:
SELECT * FROM employees e;

--Once a table is assigned an alias, you can refer to the table columns using the following syntax:
--table_alias.column_name

--Example
SELECT
    e.firstName,
    e.lastName
FROM
    employees e
ORDER BY e.firstName;
/* The table aliases are often used in the statement that contains INNER JOIN,
LEFT JOIN, RIGHT JOIN clauses and in subqueries.
*/

-- Example of joining tables.
-- if I want to represent the total number of orders per customer how do i do it?
-- The customers and orders tables have the details I need but they are in two different tables:

SELECT
  customerName,
  COUNT(o.orderNumber) total
FROM
  customers AS c
INNER JOIN orders AS o ON c.customerNumber = o.customerNumber
GROUP BY
  customerName
ORDER BY
  total DESC;


--Example I want to see the total payments made by each customer:
SELECT
  customerName,
  SUM(creditLimit) credit,
  SUM(p.amount) total
FROM
  customers AS c
INNER JOIN payments AS p ON c.customerNumber = p.customerNumber
GROUP BY
  customerName
ORDER BY
  total DESC;
