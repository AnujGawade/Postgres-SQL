-- IN --> value must match one item from the list.
-- NOT IN --> value must not match any time from the list.
-- BETWEEN --> value must be inside a range.

-- SELECT name, category, price
-- FROM products
-- WHERE category IN ('Electronics', 'Furniture');

-- SELECT name, category, price
-- FROM products
-- WHERE category NOT IN ('Electronics', 'Furniture');

-- SELECT name, category, price
-- FROM products
-- WHERE price BETWEEN 100 AND 2000;
-- It will include 100 and 2000 also

SELECT name, price
FROM products
WHERE category IN ('electronics', 'accessories')
    AND price BETWEEN 100 AND 1499;