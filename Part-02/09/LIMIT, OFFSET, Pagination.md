# LIMIT and OFFSET - Pagination

When working with large datasets, we usually don't want to return every row.

Instead, we return data in smaller chunks.

PostgreSQL provides:

- `LIMIT`
- `OFFSET`

These are commonly used for:

- pagination
- APIs
- product listings
- search results
- dashboards

---

# Why LIMIT Is Important

Imagine an e-commerce website with:

```text
100,000 products
```

If a user opens:

```text
/products
```

Returning all 100,000 rows would be slow and inefficient.

Instead:

```text
Show only the first few products.
```

This is where `LIMIT` helps.

---

# LIMIT

```sql
LIMIT number
```

Meaning:

```text
Return only this many rows.
```

---

# Example

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5;
```

---

## Understanding the Query

### ORDER BY

```sql
ORDER BY name ASC
```

Sort products alphabetically.

---

### LIMIT

```sql
LIMIT 5
```

Return only:

```text
First 5 rows
```

after sorting.

---

# Example Data

| name     |
| -------- |
| AirPods  |
| Camera   |
| Charger  |
| Keyboard |
| Laptop   |
| Mobile   |
| Mouse    |

Query:

```sql
LIMIT 5
```

Result:

| name     |
| -------- |
| AirPods  |
| Camera   |
| Charger  |
| Keyboard |
| Laptop   |

Only five rows returned.

---

# OFFSET

```sql
OFFSET number
```

Meaning:

```text
Skip this many rows.
```

---

# Example

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 5;
```

---

## Understanding the Query

### OFFSET 5

Skip:

```text
First 5 rows
```

### LIMIT 5

Then return:

```text
Next 5 rows
```

---

# Example Data

Sorted products:

| Position | Name     |
| -------- | -------- |
| 1        | AirPods  |
| 2        | Camera   |
| 3        | Charger  |
| 4        | Keyboard |
| 5        | Laptop   |
| 6        | Mobile   |
| 7        | Monitor  |
| 8        | Mouse    |
| 9        | Printer  |
| 10       | Speaker  |

Query:

```sql
LIMIT 5 OFFSET 5
```

Result:

| name    |
| ------- |
| Mobile  |
| Monitor |
| Mouse   |
| Printer |
| Speaker |

Because:

```text
Skip first 5
Return next 5
```

---

# Pagination Example

## Page 1

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 0;
```

Meaning:

```text
Start from row 1
Return 5 rows
```

---

## Page 2

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 5;
```

Meaning:

```text
Skip first 5 rows
Return next 5 rows
```

---

## Page 3

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 10;
```

Meaning:

```text
Skip first 10 rows
Return next 5 rows
```

---

# Visual Representation

Assume:

```text
Rows 1 - 20
```

### Page 1

```text
LIMIT 5 OFFSET 0

Rows:
1
2
3
4
5
```

---

### Page 2

```text
LIMIT 5 OFFSET 5

Rows:
6
7
8
9
10
```

---

### Page 3

```text
LIMIT 5 OFFSET 10

Rows:
11
12
13
14
15
```

---

# Practical API Example

Most APIs accept:

```text
page
limit
```

Example:

```text
/products?page=1&limit=5
```

```text
/products?page=2&limit=5
```

```text
/products?page=3&limit=5
```

---

# Calculating OFFSET

Formula:

```text
(page - 1) * limit
```

---

## Page 1

```text
(1 - 1) * 5
= 0
```

```sql
OFFSET 0
```

---

## Page 2

```text
(2 - 1) * 5
= 5
```

```sql
OFFSET 5
```

---

## Page 3

```text
(3 - 1) * 5
= 10
```

```sql
OFFSET 10
```

---

# Real Backend Example

If:

```text
page = 3
limit = 5
```

Backend calculates:

```text
offset = (3 - 1) * 5
```

Result:

```text
offset = 10
```

Query:

```sql
SELECT
    name,
    price
FROM products
ORDER BY name ASC
LIMIT 5 OFFSET 10;
```

---

# Why ORDER BY Is Important With Pagination

Avoid:

```sql
SELECT *
FROM products
LIMIT 5;
```

Because PostgreSQL does not guarantee row order.

Correct:

```sql
SELECT *
FROM products
ORDER BY id
LIMIT 5;
```

This ensures consistent pagination results.

---

# Common Use Cases

Product listing:

```sql
LIMIT 20
```

Search results:

```sql
LIMIT 10
```

Admin dashboard:

```sql
LIMIT 50
```

API pagination:

```sql
LIMIT 10 OFFSET 20
```

---
