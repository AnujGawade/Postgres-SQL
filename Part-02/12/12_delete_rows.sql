

-- INSERT INTO products (name, category, price, stock, sku, description)
-- VALUES ('temp product', 'Electronic', 345.45, 45, 'ELEC-TEMP-013', 'Temporary Product');

SELECT name, category, sku
FROM products
WHERE sku = 'ELEC-TEMP-013';

DELETE FROM products
where sku = 'ELEC-TEMP-013';

SELECT name, category, sku
FROM products
WHERE sku = 'ELEC-TEMP-013';