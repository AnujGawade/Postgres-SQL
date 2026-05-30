-- Similar as before lecture I will check if the data exists

SELECT name, category, price, is_active
FROM products
WHERE category = 'Accessories';

-- We need to update the accessories category product prices by 10%.

UPDATE products 
SET price = ROUND(price * 1.10,2)
WHERE category = 'Accessories';

SELECT name, category, price, is_active
FROM products
WHERE category = 'Accessories';

UPDATE products
SET is_active = FALSE
WHERE stock = 0; 