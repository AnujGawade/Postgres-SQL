# DELETE Statement - Removing Data

The `DELETE` statement is used to remove rows from a table.

Unlike:

- `INSERT` → adds data
- `UPDATE` → modifies data

`DELETE` removes data permanently.

Because deleting data is irreversible (unless backups exist), it is important to verify records before deleting them.

---

# Safe Delete Workflow

A common production workflow is:

```text
1. Verify the record exists
2. Delete the record
3. Verify it was removed
```

This is exactly what we are doing in this lesson.

---

# Complete SQL for This Lesson

```sql
-- Insert sample data

INSERT INTO products (
    name,
    category,
    price,
    stock,
    sku,
    description
)
VALUES (
    'temp product',
    'Electronic',
    345.45,
    45,
    'ELEC-TEMP-013',
    'Temporary Product'
);

-- Verify record exists

SELECT
    name,
    category,
    sku
FROM products
WHERE sku = 'ELEC-TEMP-013';

-- Delete record

DELETE FROM products
WHERE sku = 'ELEC-TEMP-013';

-- Verify deletion

SELECT
    name,
    category,
    sku
FROM products
WHERE sku = 'ELEC-TEMP-013';
```

---

# Step 1: Verify Data Exists

```sql
SELECT
    name,
    category,
    sku
FROM products
WHERE sku = 'ELEC-TEMP-013';
```

Purpose:

```text
Confirm the row exists before deleting.
```

Example result:

| name         | category   | sku           |
| ------------ | ---------- | ------------- |
| temp product | Electronic | ELEC-TEMP-013 |

This confirms the product is present in the table.

---

# Why Use SKU?

```sql
WHERE sku = 'ELEC-TEMP-013'
```

SKU is acting as a unique identifier.

Using unique values is safer because:

```text
Only one row should match.
```

This prevents accidental deletion of multiple records.

---

# Step 2: Delete the Record

```sql
DELETE FROM products
WHERE sku = 'ELEC-TEMP-013';
```

---

# Understanding DELETE

```sql
DELETE FROM products
```

Means:

```text
Remove rows from the products table.
```

---

# Understanding WHERE

```sql
WHERE sku = 'ELEC-TEMP-013'
```

Means:

```text
Delete only the matching product.
```

Without the `WHERE` clause:

```sql
DELETE FROM products;
```

Every row would be deleted.

This is one of the most dangerous SQL mistakes.

---

# Before Delete

| name         | category   | sku           |
| ------------ | ---------- | ------------- |
| temp product | Electronic | ELEC-TEMP-013 |

---

# After Delete

The row no longer exists.

---

# Step 3: Verify Deletion

```sql
SELECT
    name,
    category,
    sku
FROM products
WHERE sku = 'ELEC-TEMP-013';
```

---

# Expected Result

```text
0 rows returned
```

Meaning:

```text
The product was successfully removed.
```

---

# Why Verify Again?

Purpose:

```text
Confirm deletion worked.
Ensure correct row was removed.
Avoid assumptions.
```

A good database workflow is:

```text
Check
Delete
Check Again
```

---

# DELETE vs DROP

Many beginners confuse these.

---

## DELETE

```sql
DELETE FROM products
WHERE sku = 'ELEC-TEMP-013';
```

Removes:

```text
Rows
```

Table still exists.

---

## DROP

```sql
DROP TABLE products;
```

Removes:

```text
Entire table
```

Including:

- structure
- columns
- data

---

# Example

DELETE:

Before:

```text
100 rows
```

After:

```text
99 rows
```

Table remains.

---

DROP:

Before:

```text
products table exists
```

After:

```text
products table does not exist
```

---

# Real-World Examples

Delete one product:

```sql
DELETE FROM products
WHERE sku = 'ELEC-TEMP-013';
```

---

Delete inactive products:

```sql
DELETE FROM products
WHERE is_active = false;
```

---

Delete out-of-stock products:

```sql
DELETE FROM products
WHERE stock = 0;
```

---

# Important Safety Rule

Always verify your condition first.

Instead of:

```sql
DELETE FROM products
WHERE stock = 0;
```

Run:

```sql
SELECT *
FROM products
WHERE stock = 0;
```

Check the rows.

Then execute the delete.

This prevents accidental data loss.

---
