# Primary Key

A primary key uniquely identifies each row in a table.

Every row should have something unique that helps the database identify that specific record.

That unique identifier is called a:

```text
PRIMARY KEY
```

---

# Why Primary Keys Are Important

Without a primary key, many database operations become difficult.

Problems without primary keys:

- difficult to UPDATE specific rows
- difficult to DELETE specific rows
- difficult to reference rows from other tables
- difficult to create relationships between tables
- duplicate rows become harder to manage

Example:

Imagine a table:

```text
title   | price
--------+------
sale 1  | 200
sale 1  | 200
```

Now if you want to update only one row:

```sql
UPDATE sales
SET price = 500
WHERE title = 'sale 1';
```

Both rows may get updated.

Database cannot uniquely identify which row you meant.

Primary keys solve this problem.

---

# Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.sales;

CREATE TABLE basics.sales(

    id SERIAL PRIMARY KEY,

    title TEXT NOT NULL,

    price NUMERIC(10, 2) NOT NULL DEFAULT 0,

    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO basics.sales (title, price)
VALUES
    ('sale 1', 200),
    ('sale 2', 500);

SELECT * FROM basics.sales WHERE id = 2;
```

---

# Dropping Existing Table

```sql
DROP TABLE IF EXISTS basics.sales;
```

Deletes the table if it already exists.

Useful during practice.

---

# Creating Table

```sql
CREATE TABLE basics.sales(
```

Creates a table inside the `basics` schema.

---

# Column Breakdown

## `id SERIAL PRIMARY KEY`

```sql
id SERIAL PRIMARY KEY
```

This is the most important column in the table.

---

## SERIAL

```sql
SERIAL
```

Creates an auto-incrementing integer.

Generated automatically:

```text
1
2
3
4
5
```

Every new row gets the next number.

Example:

First row:

```text
id = 1
```

Second row:

```text
id = 2
```

---

## PRIMARY KEY

```sql
PRIMARY KEY
```

Rules:

- must be unique
- cannot be NULL
- identifies each row uniquely

Invalid:

```text
1
1
NULL
```

Valid:

```text
1
2
3
```

---

# `title TEXT NOT NULL`

```sql
title TEXT NOT NULL
```

Stores sale title.

Examples:

```text
sale 1
sale 2
black friday sale
```

`NOT NULL` means:

Every sale must have a title.

---

# `price NUMERIC(10, 2) NOT NULL DEFAULT 0`

```sql
price NUMERIC(10, 2) NOT NULL DEFAULT 0
```

Stores exact decimal numbers.

Good for:

- money
- prices
- financial calculations

---

## `NUMERIC(10, 2)`

Meaning:

- 10 → total digits allowed
- 2 → digits after decimal

Examples:

Valid:

```text
200.00
500.50
99999.99
```

---

## `NOT NULL`

Price is required.

Database rejects:

```text
NULL
```

---

## `DEFAULT 0`

If no price is provided:

```text
0
```

gets inserted automatically.

---

# `created_at TIMESTAMP DEFAULT NOW()`

```sql
created_at TIMESTAMP DEFAULT NOW()
```

Automatically stores current timestamp.

Example:

```text
2026-05-27 22:30:15
```

---

# Inserting Data

```sql
INSERT INTO basics.sales (title, price)
VALUES
    ('sale 1', 200),
    ('sale 2', 500);
```

Inserts two rows.

Generated automatically:

```text
id
created_at
```

---

# Stored Data Example

| id  | title  | price |
| --- | ------ | ----- |
| 1   | sale 1 | 200   |
| 2   | sale 2 | 500   |

---

# Finding Specific Rows

```sql
SELECT * FROM basics.sales
WHERE id = 2;
```

This finds the row where:

```text
id = 2
```

Result:

```text
2 | sale 2 | 500
```

---

# Why Primary Keys Matter

Primary keys make operations reliable.

Examples:

Update specific row:

```sql
UPDATE basics.sales
SET price = 700
WHERE id = 2;
```

Delete specific row:

```sql
DELETE FROM basics.sales
WHERE id = 1;
```

Reference from another table:

```text
sale_id = 2
```

Without primary keys:

- duplicate data causes confusion
- updates become unsafe
- relationships become unreliable

---

# Real-World Usage

Primary keys are used everywhere.

Examples:

- user_id
- order_id
- payment_id
- product_id
- invoice_id

Almost every table should have a primary key.

---
