--GROUP BY
/*
this is a useful clause that groups a set of rows into a set of summary rows
by values or expressions.
It returns one row for each group.
In other words it reduces the number of rows in the result set.

SELECT
    c1, c2,..., cn, aggregate_function(ci)
FROM
    table
WHERE
    where_conditions
GROUP BY c1 , c2,...,cn;

MySQL evaluates the GROUP BY clause after the FROM and WHERE clauses and before
 the HAVING, SELECT, DISTINCT, ORDER BY and LIMIT clauses:
 FROM > WHERE > GROUP BY > SELECT > DISTINCT > ORDER BY > LIMIT

 In practice, you often use the GROUP BY clause with aggregate functions such as
 SUM, AVG, MAX, MIN, and COUNT. The aggregate function that appears in the SELECT
 clause provides the information of each group.
*/

-- Example seeing the order statuses in the orders table:
SELECT
  status
FROM
  orders
GROUP BY
  status;

-- Example you want to know the numbers of orders per status:
SELECT
  status, COUNT(*)
FROM
  orders
GROUP BY
  status;

-- Example to get the total amount of all orders by status:
SELECT
  status,
  SUM(quantityOrdered * priceEach) AS 'Total Amount'
FROM
  orders
INNER JOIN orderdetails USING(orderNumber)
GROUP BY
  status;

--Example to get the order numbers and the total amount of each order
SELECT
  orderNumber,
  SUM(quantityOrdered * priceEach) AS 'Total Amount'
FROM
  orderdetails
GROUP BY
  orderNumber;

-- Example get the total sales for orders shipped each year
SELECT
  YEAR(orderDate) AS Year,
  SUM(quantityOrdered * priceEach) AS 'Total Amount'
FROM
  orders
INNER JOIN orderdetails USING(orderNumber)
WHERE
  status = 'shipped'
GROUP BY 
  Year;

--Example to get the total sales of the years after 2003
SELECT
  YEAR(orderDate) AS Year,
  SUM(quantityOrdered * priceEach) AS 'TOTAL AMOUNT'
FROM
  orders
INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'shipped'
GROUP BY Year
HAVING Year > 2003;
