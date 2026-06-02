# Subqueries (Query Inside Another Query)

A **Subquery** is a query written inside another query.

Think of it as:

```text
One query
    ↓
provides data
    ↓
to another query
```

PostgreSQL executes the:

```text
Inner Query First
        ↓
Then
        ↓
Outer Query
```

Subqueries are very useful when a query depends on a value that must be calculated dynamically.

---

# Why Use Subqueries?

Imagine a posts table:

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Indexes for Beginners        | 40    |
| Backend APIs with PostgreSQL | 180   |

Suppose we want to know:

```text
Which posts are performing
better than the average post?
```

The average is not known beforehand.

We first need PostgreSQL to calculate:

```text
Average views
```

Then compare every post against it.

This is where a subquery helps.

---

# What Is a Subquery?

Example:

```sql
SELECT AVG(views)
FROM posts;
```

This query returns:

```text
106.67
```

Now we can use that result inside another query.

```sql
SELECT *
FROM posts
WHERE views > 106.67;
```

Instead of manually writing:

```text
106.67
```

we let PostgreSQL calculate it automatically.

---

# Complete SQL for This Lesson

```sql
SELECT
    title,
    status,
    views
FROM posts
WHERE views > (
    SELECT AVG(views)
    FROM posts
);
```

---

# Understanding the Query

## Outer Query

```sql
SELECT
    title,
    status,
    views
FROM posts
```

Returns:

- title
- status
- views

from the posts table.

---

# WHERE Clause

```sql
WHERE views > (...)
```

Meaning:

```text
Only return posts
whose views are greater
than some calculated value.
```

That value comes from the subquery.

---

# Inner Query (Subquery)

```sql
SELECT AVG(views)
FROM posts
```

This query runs first.

---

# Step 1: Calculate Average Views

Example data:

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Indexes for Beginners        | 40    |
| Backend APIs with PostgreSQL | 180   |

Calculation:

```text
(100 + 40 + 180)
÷
3
```

Result:

```text
106.67
```

---

# Step 2: Substitute the Result

PostgreSQL internally treats the query like:

```sql
SELECT
    title,
    status,
    views
FROM posts
WHERE views > 106.67;
```

---

# Step 3: Evaluate Each Row

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Indexes for Beginners        | 40    |
| Backend APIs with PostgreSQL | 180   |

Check:

```text
100 > 106.67 ❌
40 > 106.67 ❌
180 > 106.67 ✅
```

---

# Final Result

| title                        | status    | views |
| ---------------------------- | --------- | ----- |
| Backend APIs with PostgreSQL | published | 180   |

Only this post performs above average.

---

# Execution Order

PostgreSQL processes the query like this:

### Step 1

Run inner query:

```sql
SELECT AVG(views)
FROM posts;
```

Result:

```text
106.67
```

---

### Step 2

Run outer query:

```sql
SELECT
    title,
    status,
    views
FROM posts
WHERE views > 106.67;
```

---

### Step 3

Return matching rows.

---

# Visual Representation

```text
Outer Query
      │
      ▼
WHERE views >
      │
      ▼
Subquery
      │
      ▼
AVG(views)
      │
      ▼
106.67
```

---

# Why Subqueries Are Powerful

Without subqueries:

You would need:

```sql
SELECT AVG(views)
FROM posts;
```

Then manually copy the result.

Then run:

```sql
SELECT *
FROM posts
WHERE views > 106.67;
```

Two separate queries.

With a subquery:

```sql
SELECT ...
WHERE views > (
    SELECT AVG(...)
);
```

Everything happens automatically.

---

# Real-World Examples

Products more expensive than average:

```sql
SELECT *
FROM products
WHERE price >
(
    SELECT AVG(price)
    FROM products
);
```

---

Employees earning above average salary:

```sql
SELECT *
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);
```

---

Customers with above-average orders:

```sql
SELECT *
FROM customers
WHERE total_orders >
(
    SELECT AVG(total_orders)
    FROM customers
);
```

---

# Types of Subqueries

This lesson uses:

```text
Scalar Subquery
```

Because it returns:

```text
One Value
```

Example:

```sql
SELECT AVG(views)
FROM posts;
```

Result:

```text
106.67
```

A single value.

---

# Benefits of Subqueries

- dynamic calculations
- cleaner SQL
- no hardcoded values
- reusable logic
- powerful analytics queries

---
