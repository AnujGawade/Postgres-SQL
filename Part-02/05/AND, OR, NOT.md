# AND, OR, NOT Operators

The `WHERE` clause becomes much more powerful when combined with logical operators.

PostgreSQL provides three main logical operators:

- `AND`
- `OR`
- `NOT`

These operators allow us to build complex filtering conditions.

---

# Logical Operators Overview

## AND

```sql
condition1 AND condition2
```

Meaning:

```text
Every condition must be true.
```

Example:

```sql
WHERE category = 'Electronics'
AND price >= 1000
```

A row is returned only if:

- category is Electronics ✅
- price is greater than or equal to 1000 ✅

Both conditions must be true.

---

## OR

```sql
condition1 OR condition2
```

Meaning:

```text
At least one condition must be true.
```

Example:

```sql
WHERE category = 'Electronics'
OR category = 'Furniture'
```

Returns:

- Electronics products ✅
- Furniture products ✅

Only one condition needs to match.

---

## NOT

```sql
NOT condition
```

Meaning:

```text
Reverse or exclude a condition.
```

Example:

```sql
WHERE NOT category = 'Accessories'
```

Returns:

Everything except:

```text
Accessories
```

---

# Example 1: Electronics Products Above ₹1000

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE category = 'Electronics'
    AND price >= 1000;
```

---

## Understanding the Query

Condition:

```sql
category = 'Electronics'
```

AND

```sql
price >= 1000
```

Both must be true.

---

## Example Data

| name   | category    | price |
| ------ | ----------- | ----- |
| Mouse  | Electronics | 500   |
| Laptop | Electronics | 50000 |
| Chair  | Furniture   | 2000  |

Result:

| name   | category    | price |
| ------ | ----------- | ----- |
| Laptop | Electronics | 50000 |

Why?

```text
Mouse
Electronics ✅
Price >= 1000 ❌

Laptop
Electronics ✅
Price >= 1000 ✅
```

Only Laptop satisfies both.

---

# Example 2: Electronics OR Furniture

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE category = 'Electronics'
    OR category = 'Furniture';
```

---

## Meaning

Return products belonging to either:

```text
Electronics
```

OR

```text
Furniture
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

Accessories are excluded.

---

# Example 3: Excluding Accessories

```sql
SELECT
    name,
    category
FROM products
WHERE NOT category = 'Accessories';
```

---

## Meaning

Return all products except:

```text
Accessories
```

Equivalent to:

```sql
WHERE category != 'Accessories'
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

# Combining AND and OR

Real-world queries often require multiple conditions.

Example:

```sql
SELECT
    name,
    category,
    price,
    stock
FROM products
WHERE (
        category = 'Electronics'
        OR category = 'Furniture'
      )
      AND stock > 10;
```

---

# Why Parentheses Matter

Parentheses group conditions together.

This query means:

```text
(Category is Electronics OR Furniture)
AND
Stock must be greater than 10
```

---

## Example Data

| name    | category    | stock |
| ------- | ----------- | ----- |
| Laptop  | Electronics | 20    |
| Chair   | Furniture   | 15    |
| Mouse   | Electronics | 5     |
| Charger | Accessories | 50    |

Result:

| name   | category    | stock |
| ------ | ----------- | ----- |
| Laptop | Electronics | 20    |
| Chair  | Furniture   | 15    |

Why?

```text
Laptop
Electronics ✅
Stock > 10 ✅

Chair
Furniture ✅
Stock > 10 ✅

Mouse
Electronics ✅
Stock > 10 ❌

Charger
Accessories ❌
```

---

# Operator Precedence

PostgreSQL evaluates:

```text
NOT
↓
AND
↓
OR
```

Because of this, using parentheses is recommended.

Good:

```sql
WHERE (
    category = 'Electronics'
    OR category = 'Furniture'
)
AND stock > 10;
```

This makes your intent clear and avoids mistakes.

---

# Real-World Examples

Products available for sale:

```sql
SELECT *
FROM products
WHERE stock > 0;
```

Electronics above ₹5000:

```sql
SELECT *
FROM products
WHERE category = 'Electronics'
    AND price > 5000;
```

Products from Electronics or Furniture:

```sql
SELECT *
FROM products
WHERE category = 'Electronics'
    OR category = 'Furniture';
```

Products excluding Accessories:

```sql
SELECT *
FROM products
WHERE NOT category = 'Accessories';
```

---
