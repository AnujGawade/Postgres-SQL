-- Return is going to give back the affected rows after you will do anytime we inser, update or delete.

INSERT INTO products (name, category, price, stock, sku, description)
VALUES ('webcam camera', 'Electronics', 456.67, 56, 'ELEC-TEMP-015', 'webcam camera')
RETURNING id, name, category, price, stock, create_at;