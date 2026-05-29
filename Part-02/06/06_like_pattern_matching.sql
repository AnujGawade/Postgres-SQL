-- like - case sensitive pattern match
-- ilike - case insensitive pattern match
-- % means anything can come after it
-- exactly one character

-- SELECT name, price
-- FROM products
-- WHERE name LIKE 'Wooden%';

SELECT name, price
FROM products
WHERE name ILIKE '%galaxy%';