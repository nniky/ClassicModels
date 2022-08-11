--Example o find customers who do not have a sales representative:
SELECT
  customerName,
  country,
  salesRepEmployeeNumber
FROM
  customers
WHERE
  salesRepEmployeeNumber IS NULL
ORDER BY
  customerName;

-- Example to find customers who have a sales representative
SELECT
  customerName,
  country,
  salesRepEmployeeNumber
FROM
  customers
WHERE
  salesRepEmployeeNumber IS NOT NULL
ORDER BY
  customerName;
