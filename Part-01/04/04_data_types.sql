DROP TABLE IF EXISTS basics.products_basic;

CREATE TABLE basics.products_basic (

    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    stock INTEGER DEFAULT 0,
    total_views BIGINT DEFAULT 0,
    price NUMERIC(10, 2),
    is_active BOOLEAN DEFAULT true
);

INSERT INTO basics.products_basic
(name, description, stock, total_views, price, is_active)
VALUES
(
    'Product 1',
    'This is product description',
    100,
    1200,
    2455.65,
    true
);

SELECT * FROM basics.products_basic;

SELECT id, name, price, is_active
FROM basics.products_basic
WHERE is_active = true;