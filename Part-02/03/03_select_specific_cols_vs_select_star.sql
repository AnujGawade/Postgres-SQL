-- Select Specifif columns vs select *

-- Select * is going to return every column for every product.
-- But when our applications grow, let's say while creating actual production project, And suppose in that project we have 1000 columns then we have to return some data. 

-- Select All Example
SELECT price FROM products

-- As creates an alias for the output of that column name
-- makes the col name easier to read

SELECT 
    name AS product_name
    price AS selling_price
    stock AS available_quantity
FROM products;