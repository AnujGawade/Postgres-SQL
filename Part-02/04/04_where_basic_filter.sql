-- Suppose we have a E-commerce website and you want to have a API Call where there will be products only from a particular category.
-- Something like /products?category=electronics 

SELECT name,  category, price
FROM products
where category = 'electronics';

-- find products where price > 1000

-- find products which are not active