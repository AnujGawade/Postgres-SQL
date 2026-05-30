# UPDATE Statement - Modifying Existing Data

The `UPDATE` statement is used to modify existing records in a table.

Unlike `INSERT`, which adds new rows, `UPDATE` changes data that already exists.

Common use cases:

- changing product prices
- updating inventory stock
- changing user information
- updating order status
- correcting incorrect data

---

# Why Verify Data Before Updating?

A good practice is:

1. Check if the record exists
2. Update the record
3. Verify the updated result

This helps prevent mistakes and ensures the correct row is modified.

---

# Complete SQL for This Lesson

```sql
-- Check existing data

SELECT
    name,
    price,
    stock,
    sku
FROM products
WHERE sku = 'ELEC-IP15-001';

-- Update product

UPDATE products
SET
    price = 69999.99,
    stock = 33
WHERE sku = 'ELEC-IP15-001';

-- Verify updated data

SELECT
    name,
    price,
    stock,
    sku
FROM products
WHERE sku = 'ELEC-IP15-001';
```

---

# Step 1: Check Existing Data

```sql
SELECT
    name,
    price,
    stock,
    sku
FROM products
WHERE sku = 'ELEC-IP15-001';
```

---

## Why Do This?

Before updating:

```text
Confirm the record exists
Confirm current values
Verify you are targeting the correct row
```

Example result:

| name      | price    | stock | sku           |
| --------- | -------- | ----- | ------------- |
| iPhone 15 | 65000.00 | 20    | ELEC-IP15-001 |

---

# Understanding the WHERE Clause

```sql
WHERE sku = 'ELEC-IP15-001'
```

This identifies the exact product.

Think:

```text
Find the row whose SKU is ELEC-IP15-001
```

Without this condition, PostgreSQL would update multiple rows.

---

# Step 2: Update Data

```sql
UPDATE products
SET
    price = 69999.99,
    stock = 33
WHERE sku = 'ELEC-IP15-001';
```

---

# Understanding UPDATE

```sql
UPDATE products
```

Means:

```text
Modify data in the products table
```

---

# Understanding SET

```sql
SET
    price = 69999.99,
    stock = 33
```

Specifies which columns should change.

Changes:

```text
price → 69999.99
stock → 33
```

---

# Multiple Column Updates

You can update one or more columns.

Example:

```sql
SET price = 69999.99
```

Single column update.

---

Example:

```sql
SET
    price = 69999.99,
    stock = 33
```

Multiple column update.

---

# Why WHERE Is Critical

This is one of the most important SQL rules.

Correct:

```sql
UPDATE products
SET price = 69999.99
WHERE sku = 'ELEC-IP15-001';
```

Only one product updates.

---

Dangerous:

```sql
UPDATE products
SET price = 69999.99;
```

No `WHERE` clause.

Result:

```text
Every product gets updated.
```

This is one of the most common database mistakes.

---

# Step 3: Verify Updated Data

After updating:

```sql
SELECT
    name,
    price,
    stock,
    sku
FROM products
WHERE sku = 'ELEC-IP15-001';
```

---

## Why Verify?

To confirm:

```text
Update succeeded
Correct row changed
New values are saved
```

---

# Before Update

| sku           | price    | stock |
| ------------- | -------- | ----- |
| ELEC-IP15-001 | 65000.00 | 20    |

---

# After Update

| sku           | price    | stock |
| ------------- | -------- | ----- |
| ELEC-IP15-001 | 69999.99 | 33    |

Changes:

```text
65000.00 → 69999.99
20 → 33
```

---

# Real-World Workflow

A common production workflow:

```sql
-- Step 1
SELECT ...

-- Step 2
UPDATE ...

-- Step 3
SELECT ...
```

Purpose:

```text
Verify
Update
Verify Again
```

This reduces mistakes and makes debugging easier.

---

# Practical Examples

Update only stock:

```sql
UPDATE products
SET stock = 50
WHERE sku = 'ELEC-IP15-001';
```

---

Update only price:

```sql
UPDATE products
SET price = 79999.99
WHERE sku = 'ELEC-IP15-001';
```

---

Update multiple fields:

```sql
UPDATE products
SET
    price = 79999.99,
    stock = 50
WHERE sku = 'ELEC-IP15-001';
```

---
