-- Suppose we have to order the products for a particular filter or complete data from cheapest to expensive. Meaning in a  Ascending Order.

-- SELECT name, price
-- FROM products
-- ORDER BY price ASC;

-- SELECT name, price
-- FROM products
-- ORDER BY price DESC;

SELECT name, category, price
FROM products
ORDER BY category ASC, price DESC;