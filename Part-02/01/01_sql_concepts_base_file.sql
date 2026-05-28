CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name TEXT NOT NULL,

    category TEXT NOT NULL,

    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),

    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),

    is_active BOOLEAN NOT NULL DEFAULT true,

    sku TEXT UNIQUE,

    description TEXT,

    create_at TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO products (
    name,
    category,
    price,
    stock,
    is_active,
    sku,
    description
)
VALUES
(
    'iPhone 15',
    'Electronics',
    79999.99,
    25,
    true,
    'ELEC-IP15-001',
    'Apple iPhone 15 with 128GB storage'
),
(
    'Samsung Galaxy S24',
    'Electronics',
    69999.50,
    18,
    true,
    'ELEC-S24-002',
    'Samsung flagship smartphone with AMOLED display'
),
(
    'Nike Air Max',
    'Footwear',
    8999.00,
    40,
    true,
    'SHOE-NAM-003',
    'Comfortable running shoes for daily wear'
),
(
    'Wooden Study Table',
    'Furniture',
    12500.75,
    10,
    true,
    'FURN-TBL-004',
    'Solid wood study table with storage drawer'
),
(
    'Gaming Keyboard',
    'Accessories',
    3499.99,
    30,
    true,
    'ACC-GKB-005',
    'Mechanical RGB gaming keyboard'
),
(
    'Bluetooth Speaker',
    'Electronics',
    2499.50,
    50,
    true,
    'ELEC-SPK-006',
    'Portable wireless bluetooth speaker'
),
(
    'Office Chair',
    'Furniture',
    5999.00,
    12,
    true,
    'FURN-CHR-007',
    'Ergonomic office chair with lumbar support'
),
(
    'Water Bottle',
    'Lifestyle',
    499.00,
    100,
    true,
    'LIFE-WB-008',
    '1 litre stainless steel water bottle'
),
(
    'Dell Monitor 24 Inch',
    'Electronics',
    14999.99,
    8,
    true,
    'ELEC-MON-009',
    '24 inch full HD IPS monitor'
),
(
    'Backpack',
    'Accessories',
    1999.00,
    60,
    false,
    'ACC-BAG-010',
    'Travel backpack with multiple compartments'
);