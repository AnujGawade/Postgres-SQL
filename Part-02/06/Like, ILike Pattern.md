# LIKE and ILIKE Operators

`LIKE` and `ILIKE` are used for pattern matching in PostgreSQL.

They help when you don't know the exact value and want to search for data that follows a pattern.

Common use cases:

- Product search
- User search
- Email search
- Search bars
- Autocomplete features

---

# Why Use Pattern Matching?

Imagine an e-commerce website.

User searches:

```text
galaxy
```

Possible products:

```text
Samsung Galaxy S24
Galaxy Buds Pro
Galaxy Watch
```

Instead of matching the exact product name, we can search for anything containing:

```text
galaxy
```

---

# LIKE Operator

```sql
WHERE column LIKE pattern
```

`LIKE` performs:

```text
Case-Sensitive Pattern Matching
```

Meaning:

```text
Galaxy ≠ galaxy
```

Example:

```sql
SELECT name
FROM products
WHERE name LIKE '%Galaxy%';
```

Matches:

```text
Samsung Galaxy S24
```

May NOT match:

```text
samsung galaxy s24
```

because the case is different.

---

# ILIKE Operator

```sql
WHERE column ILIKE pattern
```

`ILIKE` performs:

```text
Case-Insensitive Pattern Matching
```

Meaning:

```text
Galaxy
GALAXY
galaxy
GaLaXy
```

are treated the same.

Example:

```sql
SELECT name
FROM products
WHERE name ILIKE '%galaxy%';
```

Matches:

```text
Samsung Galaxy S24
GALAXY Buds
galaxy watch
```

---

# Wildcards

Pattern matching uses special wildcard characters.

---

## `%` Wildcard

```text
% = zero or more characters
```

Think:

```text
Anything can appear here
```

---

### Starts With

```sql
WHERE name LIKE 'Wooden%'
```

Meaning:

```text
Starts with Wooden
```

Matches:

```text
Wooden Chair
Wooden Table
Wooden Desk
```

Does NOT match:

```text
Premium Wooden Chair
```

because it does not start with:

```text
Wooden
```

---

### Ends With

```sql
WHERE name LIKE '%Chair'
```

Matches:

```text
Wooden Chair
Office Chair
Gaming Chair
```

---

### Contains

```sql
WHERE name LIKE '%Chair%'
```

Matches:

```text
Wooden Chair
Office Chair
Chair Cushion
```

Anything containing:

```text
Chair
```

---

# `_` Wildcard

```text
_ = exactly one character
```

Example:

```sql
WHERE name LIKE 'A_'
```

Matches:

```text
AB
AC
A1
```

Does NOT match:

```text
ABC
A
```

Because `_` expects exactly one character.

---

# Example 1: Products Starting with "Wooden"

```sql
SELECT
    name,
    price
FROM products
WHERE name LIKE 'Wooden%';
```

---

## Meaning

Return products where:

```text
Name starts with Wooden
```

---

## Example Data

| name          | price |
| ------------- | ----- |
| Wooden Chair  | 2000  |
| Wooden Table  | 5000  |
| Plastic Chair | 1000  |

Result:

| name         | price |
| ------------ | ----- |
| Wooden Chair | 2000  |
| Wooden Table | 5000  |

---

# Example 2: Products Containing "galaxy"

```sql
SELECT
    name,
    price
FROM products
WHERE name ILIKE '%galaxy%';
```

---

## Meaning

Find products where the name contains:

```text
galaxy
```

Anywhere in the text.

Case does not matter.

---

## Example Data

| name               | price |
| ------------------ | ----- |
| Samsung Galaxy S24 | 85000 |
| Galaxy Buds Pro    | 12000 |
| iPhone 15          | 70000 |

Result:

| name               | price |
| ------------------ | ----- |
| Samsung Galaxy S24 | 85000 |
| Galaxy Buds Pro    | 12000 |

---

# Real-World Search Examples

Search products containing:

```sql
SELECT *
FROM products
WHERE name ILIKE '%iphone%';
```

---

Search products starting with:

```sql
SELECT *
FROM products
WHERE name ILIKE 'Samsung%';
```

---

Search products ending with:

```sql
SELECT *
FROM products
WHERE name ILIKE '%Pro';
```

---

# LIKE vs ILIKE

| Operator | Case Sensitive |
| -------- | -------------- |
| LIKE     | Yes            |
| ILIKE    | No             |

Examples:

```sql
WHERE name LIKE '%galaxy%'
```

Only matches:

```text
galaxy
```

---

```sql
WHERE name ILIKE '%galaxy%'
```

Matches:

```text
galaxy
Galaxy
GALAXY
GaLaXy
```

---

# Why ILIKE Is Commonly Used

Most search bars should not care about letter case.

Users may type:

```text
iphone
IPHONE
iPhone
```

All should return the same results.

That's why PostgreSQL applications often use:

```sql
ILIKE
```

for search functionality.

---
