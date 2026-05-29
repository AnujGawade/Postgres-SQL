-- AND --> every condition must be true.
-- OR --> atleast one condition must be true.
-- NOT --> reverse/exclude a condition.

-- Create a Filter which is going to return me electronics product but price has to be greater than 1000.   

-- SELECT name, category, price 
-- FROM products
-- WHERE category = 'Electronics' AND price >= 1000

-- Products where category is electronics or furniture
-- SELECT name, category, price 
-- FROM products
-- WHERE category = 'Electronics' OR category = 'Furniture'

-- Return products which is not from category Accessories.
-- SELECT name, category 
-- FROM products
-- WHERE NOT category = 'Accessories'

SELECT name, category, price, stock
FROM products
WHERE (category = 'Electronics' OR category = 'Furniture') 
    AND stock > 10;

