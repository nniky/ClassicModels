/*
The LIMIT clause is used in the SELECT statement to constrain the number of rows to return.
You will probably be using this to get specific rows and therefore it will make
more sense to use the LIMIT clause with an ORDER BY clause.
*/

-- Example o get the top five customers who have the highest credit:
SELECT
  customerNumber,
  customerName,
  creditLimit
FROM
  customers
ORDER BY
  creditLimit DESC
LIMIT 5;
--First the order by clause sorts the customers by their credit limits
-- then the limit by clause returns the first 5 rows

/* on a side note if you want to limit the number of rows displayed on a screen
you can use the LIMIT function but first you have to know how many rows there are in a table
*/
SELECT
  COUNT(*)
FROM
  customers;

  --This shows the table has 122 customers. So if you want to display 10 per screen
SELECT
    customerNumber,
    customerName
FROM
    customers
ORDER BY customerName
LIMIT 10;

-- Then the next page would be as below  to get the rows 11 – 20:
SELECT
    customerNumber,
    customerName
FROM
    customers
ORDER BY customerName
LIMIT 10,10;

-- Using MySQL LIMIT to get the nth highest or lowest value
/*
SELECT select_list
FROM table_name
ORDER BY sort_expression
LIMIT n-1, 1;
*/

-- Example to find customer who has the 3rd highest credit
SELECT
  customerName,
  creditLimit
FROM
  customers
ORDER BY
  creditLimit DESC
Limit 2, 1;
