

-- limit --> how many rows you want to return
-- offset --> how many rows we want to skip

-- Suppose we have a task where we want to return five products and want to sort the name of the product in Ascending order. 

-- SELECT name, price
-- FROM products
-- ORDER BY name ASC
-- LIMIT 5;

-- Pagination
SELECT name, price
FROM products 
ORDER BY name ASC
LIMIT 5 OFFSET 0;

SELECT name, price
FROM products 
ORDER BY name ASC
LIMIT 5 OFFSET 5;

-- Pratical API Example
-- (page - 1) * limit
-- for 2nd page (2 - 1) * 5 --> 5
-- for 2nd page (3 - 1) * 5 --> 10

SELECT name, price
FROM products 
ORDER BY name ASC
LIMIT 5 OFFSET 10;