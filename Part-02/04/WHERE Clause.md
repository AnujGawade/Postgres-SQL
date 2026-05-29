# WHERE Clause - Filtering Data

The `WHERE` clause is used to filter rows based on a condition.

Instead of returning all records, PostgreSQL only returns rows that match the specified condition.

This is one of the most commonly used parts of SQL because real applications rarely need all data.

---

# Real-World Example

Suppose you have an E-commerce website.

API Endpoint:

```text
/products?category=electronics
```

Users only want products from the Electronics category.

Instead of fetching all products and filtering in code, the database can do it directly.

---

# Filter by Category

```sql
SELECT
    name,
    category,
    price
FROM products
WHERE category = 'electronics';
```

---

## Understanding the Query

### SELECT

```sql
SELECT
    name,
    category,
    price
```

Returns only these columns.

---

### FROM

```sql
FROM products
```

Fetch data from the `products` table.

---

### WHERE

```sql
WHERE category = 'electronics'
```

Only return rows where:

```text
category = electronics
```

---

## Example Data

| id  | name   | category    | price |
| --- | ------ | ----------- | ----- |
| 1   | Laptop | electronics | 50000 |
| 2   | Chair  | furniture   | 2000  |
| 3   | Mobile | electronics | 25000 |

Query:

```sql
WHERE category = 'electronics'
```

Result:

| name   | category    | price |
| ------ | ----------- | ----- |
| Laptop | electronics | 50000 |
| Mobile | electronics | 25000 |

---

# Comparison Operators

The `WHERE` clause commonly uses comparison operators.

| Operator | Meaning               |
| -------- | --------------------- |
| =        | equal to              |
| !=       | not equal to          |
| >        | greater than          |
| <        | less than             |
| >=       | greater than or equal |
| <=       | less than or equal    |

---

# Find Products Where Price > 1000

```sql
SELECT *
FROM products
WHERE price > 1000;
```

---

## Meaning

Only return products whose price is greater than:

```text
1000
```

---

## Example Data

| name   | price |
| ------ | ----- |
| Mouse  | 500   |
| Chair  | 2000  |
| Laptop | 50000 |

Result:

| name   | price |
| ------ | ----- |
| Chair  | 2000  |
| Laptop | 50000 |

Because:

```text
500 > 1000 ❌
2000 > 1000 ✅
50000 > 1000 ✅
```

---

# Find Products That Are Not Active

Assuming the table contains:

```sql
is_active BOOLEAN
```

Query:

```sql
SELECT *
FROM products
WHERE is_active = false;
```

---

## Meaning

Return products that are inactive.

Example:

| name        | is_active |
| ----------- | --------- |
| Laptop      | true      |
| Mobile      | true      |
| Old Monitor | false     |

Result:

| name        | is_active |
| ----------- | --------- |
| Old Monitor | false     |

---

# Boolean Filtering Shortcut

PostgreSQL also allows:

Active products:

```sql
SELECT *
FROM products
WHERE is_active;
```

Equivalent to:

```sql
WHERE is_active = true
```

---

Inactive products:

```sql
SELECT *
FROM products
WHERE NOT is_active;
```

Equivalent to:

```sql
WHERE is_active = false
```

---

# Combining Business Logic

Examples from real applications:

Electronics products:

```sql
SELECT *
FROM products
WHERE category = 'electronics';
```

Expensive products:

```sql
SELECT *
FROM products
WHERE price > 1000;
```

Inactive products:

```sql
SELECT *
FROM products
WHERE is_active = false;
```

---

# Why Filtering Matters

Without filtering:

```sql
SELECT *
FROM products;
```

Database returns every product.

With filtering:

```sql
SELECT *
FROM products
WHERE category = 'electronics';
```

Database only returns relevant data.

Benefits:

- faster queries
- less network traffic
- better API performance
- cleaner application logic

---
