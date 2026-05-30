-- To update a row first we are going to see if the data exists in the database.

SELECT name, price, stock, sku
FROM products
where sku = 'ELEC-IP15-001';

-- Now I want to update price and also the stock
UPDATE products
SET price = 69999.99,
    stock = 33
WHERE sku = 'ELEC-IP15-001';

SELECT name, price, stock, sku
FROM products
where sku = 'ELEC-IP15-001';

-- Here what i have done is I am checking IF the data exists and then update it and again see if the data is updated or not