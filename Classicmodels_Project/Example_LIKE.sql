--The LIKE operator is a logical operator that tests whether a string contains a specified pattern or not.
/*
-- expression LIKE pattern ESCAPE escape_character
-- MySQL provides two wildcard characters for constructing patterns: percentage % and underscore _ .
--The percentage ( % ) wildcard matches any string of zero or more characters.
--The underscore ( _ ) wildcard matches any single character.
--Note if When the pattern contains the wildcard character and you want to treat it as a regular character,
you can use the ESCAPE clause or use the backslash \ as the default escape character
--Note that the pattern is not case-sensitive. Therefore for example b% and B% patterns return the same result.
*/


-- to find employees whose first names start with the letter a:
SELECT
  lastName,
  firstName
FROM
  employees
WHERE
  firstName LIKE 'a%';
/*
In this example, MySQL scans the whole employees table to find employees whose
first names start with the letter a and are followed by any number of characters.
*/

--  to find employees whose last names end with the literal string 'on' e.g., Patterson, Thompson
SELECT
  employeeNumber,
  lastName,
  firstName
FROM
  employees
WHERE
  lastName LIKE '%on';


/*
To check if a string contains a substring, you can use the percentage ( % ) wildcard
 at the beginning and the end of the substring.

Example to find all employees whose last names contain the substring on
*/
SELECT
  employeeNumber,
  lastName,
  firstName
FROM
  employees
WHERE
  lastName LIKE '%on%';


/*
To find employees whose first names start with the letter T , end with the letter m,
and contain any single character between e.g., Tom , Tim, you use the underscore (_)
wildcard to construct the pattern as follows:
*/
SELECT
  employeeNumber,
  lastName,
  firstName
FROM
  employees
WHERE
  firstName LIKE 'T_m';

--Example  to search for employees whose last names DON'T start with the letter B
SELECT
  employeeNumber,
  lastName,
  firstName
FROM
  employees
WHERE
  lastName NOT LIKE 'B%';

-- The pattern sometimes may contain the wildcard characters e.g.discount rate 10%, _20, etc.
-- use the backslash sign as default escape character or you can define another one.
SELECT
    productCode,
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';

-- or the same can be written as below
SELECT
    productCode,
    productName
FROM
    products
WHERE
    productCode LIKE '%$_20%' ESCAPE '$';
