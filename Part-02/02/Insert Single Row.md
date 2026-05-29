# INSERT INTO Statement

`INSERT INTO` is used to add new rows into a table.

In this lesson, we insert product data into the `products` table.

---

# Complete SQL for This Lesson

```sql
INSERT INTO products (
    name,
    category,
    price,
    stock,
    sku,
    description
)
VALUES (
    'Laptop Stand',
    'electronics',
    5000.00,
    23,
    'ELEC-IP15-002',
    'Laptop stand description'
);
```

---

# Understanding INSERT INTO

```sql
INSERT INTO products
```

This tells PostgreSQL:

```text
Insert a new row into the products table
```

---

# Specifying Columns

```sql
(
    name,
    category,
    price,
    stock,
    sku,
    description
)
```

These are the columns where data will be inserted.

Order matters.

Meaning:

| Column      | Value                    |
| ----------- | ------------------------ |
| name        | Laptop Stand             |
| category    | electronics              |
| price       | 5000.00                  |
| stock       | 23                       |
| sku         | ELEC-IP15-002            |
| description | Laptop stand description |

---

# VALUES Keyword

```sql
VALUES (...)
```

Contains the actual data to insert.

---

# Inserted Values Breakdown

## `name`

```sql
'Laptop Stand'
```

Product name.

Data type:

```text
TEXT / VARCHAR
```

---

## `category`

```sql
'electronics'
```

Product category.

Examples:

```text
electronics
fashion
furniture
```

---

## `price`

```sql
5000.00
```

Product price.

Usually stored using:

```sql
NUMERIC(10, 2)
```

Why?

Because prices require exact decimal precision.

---

## `stock`

```sql
23
```

Available quantity in inventory.

Stored using:

```sql
INTEGER
```

---

## `sku`

```sql
'ELEC-IP15-002'
```

SKU stands for:

```text
Stock Keeping Unit
```

Unique product identifier.

Examples:

```text
ELEC-IP15-002
PHONE-001
LAPTOP-ABC
```

Used for:

- inventory management
- product tracking
- order systems

---

## `description`

```sql
'Laptop stand description'
```

Stores product details.

Usually stored as:

```sql
TEXT
```

---

# Result After Insert

Example table data:

| id  | name         | category    | price   | stock | sku           |
| --- | ------------ | ----------- | ------- | ----- | ------------- |
| 1   | Laptop Stand | electronics | 5000.00 | 23    | ELEC-IP15-002 |

If `id` is:

```sql
SERIAL PRIMARY KEY
```

Then PostgreSQL generates it automatically.

---

# Viewing Inserted Data

```sql
SELECT * FROM products;
```

Returns all rows from the table.

---

# Why Column Names Are Important

Good practice:

```sql
INSERT INTO products (
    name,
    category,
    price
)
VALUES (
    'Laptop Stand',
    'electronics',
    5000
);
```

Instead of:

```sql
INSERT INTO products
VALUES (...);
```

Why?

Because explicit columns:

- improve readability
- reduce mistakes
- protect against schema changes

---

# Important Notes

String values use:

```sql
''
```

(single quotes)

Correct:

```sql
'Laptop Stand'
```

Wrong:

```sql
"Laptop Stand"
```

Because double quotes are used for:

- column names
- table names
- identifiers

---
