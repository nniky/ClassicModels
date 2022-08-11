/*
1. The ORDER BY clause is used to sort the rows in a result set
2. ASC stands for ascending and the DESC stands for descending.
3. The ORDER BY clause sorts the result set in ascending order by default unless specified otherwise
4. It is possible to sort the result set by a column in ascending order and then by another column in descending order:
ORDER BY
    column1 ASC,
    column2 DESC;
*/

--The following query uses the ORDER BY clause to sort the customers by their last names in ascending order.
SELECT contactLastname, contactFirstname FROM customers ORDER BY contactLastname;

-- using ORDER BY clause to sort the customers by their last names in DESCENDING order.
SELECT contactLastname, contactFirstname FROM customers ORDER BY contactLastname DESC;

-- Using MySQL ORDER BY clause to sort the result set by multiple columns
SELECT contactLastname, contactFirstname FROM customers ORDER BY contactLastname DESC, contactFirstname ASC;
SELECT contactLastname, contactFirstname FROM customers ORDER BY contactLastname DESC, contactFirstname;

-- Using MySQL ORDER BY clause to sort a result set by an expression example
-- The following query selects the order line items from the orderdetails table.
-- It calculates the subtotal for each line item and sorts the result set based on the subtotal.
SELECT orderNumber, orderLineNumber, quantityOrdered * priceEach FROM orderdetails ORDER BY quantityOrdered * priceEach DESC;

-- to make the above query more readable you can use an Alias for quantityOrdered * priceEach
SELECT orderNumber, orderLineNumber, quantityOrdered * priceEach AS Subtotal FROM orderdetails ORDER BY Subtotal DESC;


-- Using MySQL ORDER BY clause to sort data using a custom list
/*
The FIELD() function has the following syntax:
FIELD(str, str1, str2)
The FIELD() function returns the position position of the str in the str1, str2, … list.
If the str is not in the list, the FIELD() function returns 0.
In other words if you want to sort a list in a specific order you can use Field(). See below
*/

--example
/*
Suppose that you want to sort the sales orders based on their statuses in the following order:
In Process
On Hold
Cancelled
Resolved
Disputed
Shipped
*/
SELECT orderNumber, status FROM orders ORDER BY FIELD(status,'In Process','On Hold','Cancelled','Resolved','Disputed','Shipped');

--In MySQL, NULL is lower than non-NULL values
-- Therefore in ASC sort the NULL values appear first while DESC sort the NULL values appear last
SELECT firstName, lastName, reportsTo FROM employees ORDER BY reportsTo;

-- nb To remember When executing the SELECT statement with an ORDER BY clause, MySQL always evaluates the ORDER BY clause after the FROM and SELECT clauses:
-- FROM > SELECT > ORDER BY
