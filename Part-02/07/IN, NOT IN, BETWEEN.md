# IN, NOT IN and BETWEEN Operators

PostgreSQL provides special operators that make filtering data easier and more readable.

In this lesson, we learned:

- `IN`
- `NOT IN`
- `BETWEEN`

These operators help avoid writing long and repetitive conditions.

---

# Why Use These Operators?

Without these operators, queries can become lengthy.

Example:

```sql
WHERE category = 'Electronics'
OR category = 'Furniture'
```

This works, but PostgreSQL provides a cleaner alternative:

```sql
WHERE category IN ('Electronics', 'Furniture')
```

Much easier to read.

---

# IN Operator

```sql
WHERE column IN (...)
```

Meaning:

```text
The value must match at least one item from the list.
```

Think:

```text
OR
```

for multiple values.

---

## Example

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE category IN ('Electronics', 'Furniture');
```

Equivalent to:

```sql
WHERE category = 'Electronics'
OR category = 'Furniture'
```

---

## Example Data

| name    | category    |
| ------- | ----------- |
| Laptop  | Electronics |
| Chair   | Furniture   |
| Charger | Accessories |

Result:

| name   | category    |
| ------ | ----------- |
| Laptop | Electronics |
| Chair  | Furniture   |

---

# NOT IN Operator

```sql
WHERE column NOT IN (...)
```

Meaning:

```text
Value must NOT match any item in the list.
```

Think:

```text
Exclude these values
```

---

## Example

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE category NOT IN ('Electronics', 'Furniture');
```

---

## Example Data

| name    | category    |
| ------- | ----------- |
| Laptop  | Electronics |
| Chair   | Furniture   |
| Charger | Accessories |

Result:

| name    | category    |
| ------- | ----------- |
| Charger | Accessories |

Because:

```text
Electronics ❌
Furniture ❌
Accessories ✅
```

---

# BETWEEN Operator

```sql
WHERE value BETWEEN min AND max
```

Meaning:

```text
Value must be inside a range.
```

Important:

`BETWEEN` is inclusive.

This means:

```text
Start value included ✅
End value included ✅
```

---

## Example

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE price BETWEEN 100 AND 2000;
```

Equivalent to:

```sql
WHERE price >= 100
AND price <= 2000
```

---

## Example Data

| name     | price |
| -------- | ----- |
| Mouse    | 50    |
| Keyboard | 500   |
| Chair    | 2000  |
| Laptop   | 50000 |

Result:

| name     | price |
| -------- | ----- |
| Keyboard | 500   |
| Chair    | 2000  |

Because:

```text
100 <= price <= 2000
```

---

# Combining IN and BETWEEN

Real-world queries often combine multiple conditions.

Example:

```sql
SELECT
    name,
    price
FROM products
WHERE category IN ('electronics', 'accessories')
    AND price BETWEEN 100 AND 1499;
```

---

# Understanding the Query

### First Condition

```sql
category IN ('electronics', 'accessories')
```

Means:

```text
Product must belong to:
- electronics
OR
- accessories
```

---

### Second Condition

```sql
price BETWEEN 100 AND 1499
```

Means:

```text
100 <= price <= 1499
```

---

### Combined Meaning

```text
Category must be electronics or accessories
AND
Price must be between 100 and 1499
```

Both conditions must be true.

---

# Example Data

| name    | category    | price |
| ------- | ----------- | ----- |
| Mouse   | accessories | 500   |
| Charger | accessories | 1200  |
| Laptop  | electronics | 50000 |
| Chair   | furniture   | 1000  |

---

# Query Result

| name    | price |
| ------- | ----- |
| Mouse   | 500   |
| Charger | 1200  |

Why?

```text
Mouse
Category Match ✅
Price Match ✅

Charger
Category Match ✅
Price Match ✅

Laptop
Category Match ✅
Price Match ❌

Chair
Category Match ❌
Price Match ✅
```

---

# IN vs OR

Instead of:

```sql
WHERE category = 'Electronics'
OR category = 'Furniture'
OR category = 'Accessories'
```

Use:

```sql
WHERE category IN (
    'Electronics',
    'Furniture',
    'Accessories'
)
```

Cleaner and easier to maintain.

---

# BETWEEN vs >= AND <=

Instead of:

```sql
WHERE price >= 100
AND price <= 2000
```

Use:

```sql
WHERE price BETWEEN 100 AND 2000
```

More readable.

---

# Real-World Examples

Products from selected categories:

```sql
SELECT *
FROM products
WHERE category IN ('electronics', 'furniture');
```

Exclude categories:

```sql
SELECT *
FROM products
WHERE category NOT IN ('electronics', 'furniture');
```

Products within a budget:

```sql
SELECT *
FROM products
WHERE price BETWEEN 500 AND 5000;
```

---
