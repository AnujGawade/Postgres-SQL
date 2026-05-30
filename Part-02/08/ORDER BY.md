# ORDER BY Clause - Sorting Data

The `ORDER BY` clause is used to sort query results.

By default, PostgreSQL does not guarantee the order of returned rows.

If you want data in a specific order, you must use:

```sql
ORDER BY
```

Common use cases:

- cheapest to expensive products
- newest to oldest records
- alphabetical sorting
- leaderboard rankings
- reports and dashboards

---

# Why Sorting Matters

Imagine an e-commerce website.

Without sorting:

```sql
SELECT name, price
FROM products;
```

Results may appear in any order.

Users usually want:

```text
Cheapest first
Most expensive first
Newest first
Highest rated first
```

That's where `ORDER BY` helps.

---

# ORDER BY ASC

```sql
SELECT
    name,
    price
FROM products
ORDER BY price ASC;
```

---

## ASC Meaning

```text
Ascending Order
```

Smallest → Largest

Examples:

Numbers:

```text
10
50
100
500
```

Alphabet:

```text
A
B
C
D
```

---

## Example Data

| name     | price |
| -------- | ----- |
| Laptop   | 50000 |
| Mouse    | 500   |
| Keyboard | 1500  |

Query:

```sql
ORDER BY price ASC
```

Result:

| name     | price |
| -------- | ----- |
| Mouse    | 500   |
| Keyboard | 1500  |
| Laptop   | 50000 |

Cheapest products appear first.

---

# ORDER BY DESC

```sql
SELECT
    name,
    price
FROM products
ORDER BY price DESC;
```

---

## DESC Meaning

```text
Descending Order
```

Largest → Smallest

Examples:

Numbers:

```text
500
100
50
10
```

Alphabet:

```text
Z
Y
X
A
```

---

## Example Data

| name     | price |
| -------- | ----- |
| Laptop   | 50000 |
| Mouse    | 500   |
| Keyboard | 1500  |

Result:

| name     | price |
| -------- | ----- |
| Laptop   | 50000 |
| Keyboard | 1500  |
| Mouse    | 500   |

Most expensive products appear first.

---

# Sorting by Text Columns

You can also sort alphabetically.

Example:

```sql
SELECT
    name,
    category
FROM products
ORDER BY category ASC;
```

Result:

```text
Accessories
Electronics
Furniture
```

Alphabetical order.

---

# Sorting by Multiple Columns

PostgreSQL allows sorting by more than one column.

Example:

```sql
SELECT
    name,
    category,
    price
FROM products
ORDER BY category ASC, price DESC;
```

---

# Understanding the Query

## First Sort

```sql
ORDER BY category ASC
```

Sorts all products alphabetically by category.

Example:

```text
Accessories
Electronics
Furniture
```

---

## Second Sort

```sql
price DESC
```

Inside each category:

Sort products from highest price to lowest price.

---

# Example Data

| name    | category    | price |
| ------- | ----------- | ----- |
| Charger | Accessories | 500   |
| Cable   | Accessories | 200   |
| Laptop  | Electronics | 50000 |
| Mouse   | Electronics | 500   |
| Chair   | Furniture   | 3000  |
| Table   | Furniture   | 2000  |

---

# Result

| name    | category    | price |
| ------- | ----------- | ----- |
| Charger | Accessories | 500   |
| Cable   | Accessories | 200   |
| Laptop  | Electronics | 50000 |
| Mouse   | Electronics | 500   |
| Chair   | Furniture   | 3000  |
| Table   | Furniture   | 2000  |

Notice:

### Category Sorting

```text
Accessories
Electronics
Furniture
```

Alphabetically.

### Price Sorting Inside Category

Accessories:

```text
500
200
```

Electronics:

```text
50000
500
```

Furniture:

```text
3000
2000
```

Highest price appears first within each category.

---

# Default Sorting Behavior

If you don't specify:

```sql
ASC
```

PostgreSQL assumes:

```sql
ASC
```

Example:

```sql
ORDER BY price
```

is equivalent to:

```sql
ORDER BY price ASC
```

---

# Combining WHERE and ORDER BY

Real-world example:

```sql
SELECT
    name,
    price
FROM products
WHERE category = 'Electronics'
ORDER BY price DESC;
```

Meaning:

```text
Only Electronics products
Sorted from most expensive to cheapest
```

---

# Common Business Examples

Cheapest products:

```sql
ORDER BY price ASC
```

Most expensive products:

```sql
ORDER BY price DESC
```

Newest products:

```sql
ORDER BY created_at DESC
```

Alphabetical products:

```sql
ORDER BY name ASC
```

---

# Key Concepts Learned

In this lesson you learned:

- `ORDER BY`
- ascending sorting (`ASC`)
- descending sorting (`DESC`)
- sorting numeric values
- sorting text values
- sorting multiple columns
- category-based sorting
- price-based sorting
- combining sorting with filtering
