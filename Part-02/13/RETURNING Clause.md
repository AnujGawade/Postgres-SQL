# RETURNING Clause

The `RETURNING` clause allows PostgreSQL to immediately return data from rows that were affected by an operation.

It can be used with:

- `INSERT`
- `UPDATE`
- `DELETE`

Instead of running another `SELECT` query, PostgreSQL can return the affected rows directly.

---

# Why Use RETURNING?

Without `RETURNING`:

```sql
INSERT INTO products (...)
VALUES (...);

SELECT *
FROM products
WHERE sku = 'ELEC-TEMP-015';
```

Two queries are required.

With `RETURNING`:

```sql
INSERT INTO products (...)
VALUES (...)
RETURNING *;
```

One query does everything.

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
    'webcam camera',
    'Electronics',
    456.67,
    56,
    'ELEC-TEMP-015',
    'webcam camera'
)
RETURNING
    id,
    name,
    category,
    price,
    stock,
    created_at;
```

---

# Understanding the Query

## INSERT INTO

```sql
INSERT INTO products (...)
```

Adds a new row to the table.

---

## VALUES

```sql
VALUES (...)
```

Contains the data being inserted.

---

## RETURNING

```sql
RETURNING ...
```

Tells PostgreSQL:

```text
After inserting the row,
return these columns.
```

---

# Why RETURNING Is Useful

Some values are generated automatically.

Examples:

```sql
id SERIAL PRIMARY KEY
```

and

```sql
created_at TIMESTAMP DEFAULT NOW()
```

We don't know those values before insertion.

`RETURNING` allows us to immediately see them.

---

# Example Insert

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
    'webcam camera',
    'Electronics',
    456.67,
    56,
    'ELEC-TEMP-015',
    'webcam camera'
);
```

PostgreSQL automatically generates:

```text
id
created_at
```

---

# Using RETURNING

```sql
RETURNING
    id,
    name,
    category,
    price,
    stock,
    created_at;
```

Returns the inserted row immediately.

Example output:

| id  | name          | category    | price  | stock | created_at          |
| --- | ------------- | ----------- | ------ | ----- | ------------------- |
| 15  | webcam camera | Electronics | 456.67 | 56    | 2026-05-28 10:30:45 |

---

# Important Note

Your query contains a small typo:

You wrote:

```sql
create_at
```

Correct column name is likely:

```sql
created_at
```

Correct query:

```sql
RETURNING
    id,
    name,
    category,
    price,
    stock,
    created_at;
```

---

# Returning All Columns

Instead of listing columns:

```sql
RETURNING *;
```

Example:

```sql
INSERT INTO products (...)
VALUES (...)
RETURNING *;
```

Returns every column from the inserted row.

---

# RETURNING with UPDATE

You can also see updated rows immediately.

Example:

```sql
UPDATE products
SET price = 999.99
WHERE sku = 'ELEC-TEMP-015'
RETURNING *;
```

Result:

```text
Updated row is returned.
```

---

# RETURNING with DELETE

You can view deleted data before it disappears.

Example:

```sql
DELETE FROM products
WHERE sku = 'ELEC-TEMP-015'
RETURNING *;
```

Result:

```text
Deleted row is returned.
```

Very useful for:

- logging
- auditing
- debugging

---

# Real Backend Example

Suppose a user creates a product.

Backend sends:

```sql
INSERT INTO products (...)
VALUES (...)
RETURNING id;
```

PostgreSQL responds:

```json
{
  "id": 15
}
```

Backend can immediately use:

```text
Product ID = 15
```

without running another query.

---

# Common Usage Patterns

Return generated ID:

```sql
RETURNING id;
```

---

Return ID and timestamp:

```sql
RETURNING id, created_at;
```

---

Return complete row:

```sql
RETURNING *;
```

---

# Why Developers Love RETURNING

Benefits:

- fewer database queries
- better performance
- immediate access to generated values
- cleaner backend code
- useful for APIs

---
