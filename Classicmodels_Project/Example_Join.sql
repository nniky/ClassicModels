/*
Sometimes data is split across multiple related tables and therefore is incomplete
from a business perspective.
For example the complete order information in the sample database is split across
the orders table and the orderdetails tables.
There are common columns in both these tables known as foreign key columns
JOINS come into play when we are trying to access the information from two different
but related tables

A join is a method of linking data between one (self-join) or more tables based
on values of the common column between the tables.

MySQL supports the following joins
1. inner join
2. Left join
3. Right join
4. Cross join

The join clause is used in the SELECT statement appeared after the FROM clause.

Example
For the purpose of understanding joins I am going to create two sample tables to play with
called members and committees
*/
CREATE TABLE members (member_id INT AUTO_INCREMENT,
  name VARCHAR(100),
  PRIMARY KEY (member_id));

CREATE TABLE committees (committee_id INT AUTO_INCREMENT,
  name VARCHAR(100),
  PRIMARY KEY (committee_id));

INSERT INTO members(name) VALUES ('John'),('Jane'),('Mary'),('David'),('Amelia');
INSERT INTO committees(name) VALUES ('John'),('Mary'),('Amelia'),('Joe');

--INNER JOIN
/* The inner join clause joins two tables based on a condition which is known as a join predicate.
-- The inner join clause compares each row from the first table with every row from the second table.
-- If values from both rows satisfy the join condition, the inner join clause creates
 a new row whose column contains all columns of the two rows from both tables and
 includes this new row in the result set.
 -- In other words, the inner join clause includes only matching rows from both tables.

--IF INNER JOIN of the two tables committees and members was represented in a venn
diagram it would be the middle section that overlaps from the two circles.
*/

--the syntax is
/*
SELECT
    select_list
FROM t1
INNER JOIN t2 ON join_condition1
INNER JOIN t3 ON join_condition2
...;

First, specify the main table that appears in the FROM clause (t1).
Second, specify the table that will be joined with the main table, which appears
in the INNER JOIN clause (t2, t3,…).
Third, specify a join condition after the ON keyword of the INNER JOIN clause.
The join condition specifies the rule for matching rows between the main table
and the table appeared in the INNER JOIN clause.
*/

--Example INNER join using the two tables:
SELECT
  m.member_id,
  m.Name AS member,
  c.committee_id,
  c.Name AS committee
FROM
  members m
INNER JOIN committees c ON m.Name = c.Name;

--or USING clause can be used if the column names in both tables used for matching are the same:
SELECT
  m.member_id,
  m.name AS member,
  c.committee_id,
  c.name AS committee
FROM
  members m
INNER JOIN committees c USING (name);

--Example2
SELECT
  productCode,
  productName,
  textDescription
FROM
  products t1
INNER JOIN productlines t2 ON t1.productline = t2.productline;

--Example3
--If we want order number, order status, and total sales in one table
SELECT
  orderNumber,
  status,
  SUM(quantityOrdered * priceEach) total
FROM
  orders
INNER JOIN orderdetails USING(orderNumber)
GROUP BY orderNumber;

--Example 4
--Joining 3 tables together say we want order number, the order date, the order line number
-- the product name , the quantity ordered and the price

SELECT
  orderNumber,
  orderDate,
  orderLineNumber,
  productName,
  quantityOrdered,
  priceEach
FROM
  orders
INNER JOIN orderdetails USING (orderNumber)
INNER JOIN products USING (productCode)
ORDER BY
orderNumber,
orderLineNumber;

-- Example 5
/* find the orders where the sales price of the product whose code is S10_1678 that is less than
the manufacturer’s suggested retail price (MSRP) for that product.
*/

SELECT
  orderNumber,
  productName,
  MSRP,
  priceEach
FROM
  products p
INNER JOIN orderdetails o ON
 p.productCode = o.productCode AND
o.priceEach < p.MSRP
WHERE p.productCode = 'S10_1678';


--LEFT JOIN
/*
a left join also requires a join predicate. When joining two tables using a left join,
the concepts of left and right tables are introduced.

The left join selects data starting from the left table. For each row in the left table,
the left join compares with every row in the right table.

If the values in the two rows satisfy the join condition, the left join clause
creates a new row whose columns contain all columns of the rows in both tables
and includes this row in the result set.

If the values in the two rows are not matched, the left join clause still creates
a new row whose columns contain columns of the row in the left table and NULL
for columns of the row in the right table.

In other words, the left join selects all data from the left table whether there
are matching rows exist in the right table or not.this is the major difference to Inner join

In case there are no matching rows from the right table found, the left join uses NULLs for
columns of the row from the right table in the result set.
*/

SELECT
  m.member_id,
  m.name AS member,
  c.committee_id,
  c.Name AS committee
FROM
  members m
LEFT JOIN committees c USING (name);

--Example if we just wanted to see the members who are not in any committees
SELECT
  m.member_id,
  m.name AS member,
  c.committee_id,
  c.Name AS committee
FROM
  members m
LEFT JOIN committees c USING (name)
WHERE c.committee_id IS NULL;


--Example: get all the customers and their respective orders.
SELECT
  customerNumber,
  customerName,
  orderNumber,
  status
FROM
  customers
LEFT JOIN orders USING (customerNumber);

--Example to see all the customers that have no orders
SELECT
  customerNumber,
  customerName,
  orderNumber,
  status
FROM
  customers
LEFT JOIN orders USING (customerNumber)
WHERE orderNumber IS NULL;

-- Example to see all the employees the customers they handle if any and the payments made by them:
SELECT
  lastName,
  firstName,
  jobTitle,
  customerName,
  checkNumber,
  amount
FROM
  employees
LEFT JOIN customers c ON
 SalesRepEmployeeNumber = employeeNumber
LEFT JOIN payments p ON
p.customerNumber = c.customerNumber
ORDER BY
customerName,
checkNumber;

--Example
SELECT
  orderNumber,
  customerNumber,
  productCode
FROM
  orders
LEFT JOIN orderdetails USING(orderNumber)
WHERE orderNumber = 10123;


Example
SELECT
  orderNumber,
  customerNumber,
  customerName,
  productCode
FROM
  orders
LEFT JOIN customers USING(customerNumber)
LEFT JOIN orderdetails USING(orderNumber);


--RIGHT joins
/*
The right join clause is similar to the left join clause except that the treatment
 of left and right tables is reversed. The right join starts selecting data from
 the right table instead of the left table.

The right join clause selects all rows from the right table and matches rows in the left table.
If a row from the right table does not have matching rows from the left table,
the column of the left table will have NULL in the final result set.

MySQL RIGHT JOIN allows you to query data from two or more related tables.
The RIGHT JOIN starts selecting rows from the right table.
It always returns rows from the right table whether or not there’s match rows in the left table.
The RIGHT OUTER JOIN is the synonym of the RIGHT JOIN.
*/

SELECT
  m.member_id,
  m.name AS member,
  c.committee_id,
  c.name AS committee
FROM
  members m
RIGHT JOIN committees c USING (name);


SELECT
  customerNumber,
  customerName,
  orderNumber,
  status
FROM
  customers
INNER JOIN orders USING (customerNumber);

--Example seeing all employees and which customers they are linked to
SELECT
  customerNumber,
  customerName,
  employeeNumber,
  lastName 'employee name'
FROM
  customers
RIGHT JOIN employees ON SalesRepEmployeeNumber = employeeNumber
ORDER BY 'employee name';




--CROSS JOIN
/*
Unlike the inner join, left join, and right join, the cross join clause does not
have a join condition.

The cross join makes a Cartesian product of rows from the joined tables.
The cross join combines each row from the first table with every row from the right
table to make the result set.

Suppose the first table has n rows and the second table has m rows the CROSS JOIN
that joins the tables will return n X m rows

The cross join is useful for generating planning data. For example, you can carry
the sales planning by using the cross join of customers, products, and years.
*/

SELECT
m.member_id,
m.name AS member,
c.committee_id,
c.name AS committee
FROM
  members m
CROSS JOIN committees c;


--SELF JOIN
/*
there is a special case that you need to join a table to itself, which is known as a self join.
The self join is often used to query hierarchical data or to compare a row with other rows within the same table.
To perform a self join, you must use table aliases to not repeat the same table name
 twice in a single query. Note that referencing a table twice or more in a query
 without using table aliases will cause an error.
*/

--Example to better illustrate the organization structure from the employees table
SELECT
  CONCAT_WS(' ', e.lastName, e.firstName) AS employee,
  e.jobTitle AS 'Employee Position',
  CONCAT_WS(' ', m.lastName, m.firstName) AS Manager,
  m.jobTitle AS 'Manager Position'
FROM
  employees e
INNER JOIN employees m ON m.employeeNumber = e.reportsTo
ORDER BY
  Manager;

SELECT
    CONCAT_WS(' ', e.lastName, e.firstName) AS employee,
    e.jobTitle AS 'Employee Position',
    IFNULL(CONCAT_WS(' ', m.lastName, m.firstName), 'President') AS Manager,
    IFNULL(m.jobTitle,' ') AS 'Manager Position'
  FROM
    employees e
  LEFT JOIN employees m ON m.employeeNumber = e.reportsTo
  ORDER BY
    Manager;
