# Aggregate Functions

Aggregate functions calculate a single result from multiple rows.

Instead of returning every row, they summarize data and provide useful statistics.

These functions are heavily used in:

- Admin Dashboards
- Reports
- Analytics
- Business Intelligence
- KPI Tracking
- CRM Systems

---

# Why Aggregate Functions Matter

Imagine a posts table:

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Indexes for Beginners        | 40    |
| Backend APIs with PostgreSQL | 180   |

Instead of looking at every row manually, we can ask:

```text
How many posts exist?
How many are published?
How many total views?
Average views?
Highest viewed post?
Lowest viewed post?
```

Aggregate functions answer these questions.

---

# Aggregate Functions Learned

| Function | Purpose        |
| -------- | -------------- |
| COUNT()  | Number of rows |
| SUM()    | Total value    |
| AVG()    | Average value  |
| MIN()    | Smallest value |
| MAX()    | Largest value  |

---

# COUNT()

Counts rows.

Example:

```sql
SELECT COUNT(*) AS total_posts
FROM posts;
```

---

## Understanding the Query

```sql
COUNT(*)
```

Means:

```text
Count all rows
```

---

### Example Data

| title                        |
| ---------------------------- |
| PostgreSQL Joins Explained   |
| Indexes for Beginners        |
| Backend APIs with PostgreSQL |

Result:

```text
3
```

---

### Using Alias

```sql
AS total_posts
```

Output column becomes:

```text
total_posts
```

---

# Counting Published Posts

```sql
SELECT
    COUNT(*) AS total_posts,
    COUNT(*) FILTER (
        WHERE status = 'published'
    ) AS published
FROM posts AS p;
```

---

# FILTER Clause

```sql
COUNT(*) FILTER (
    WHERE status = 'published'
)
```

Means:

```text
Count only rows
where status = published
```

---

### Example Data

| title                        | status    |
| ---------------------------- | --------- |
| PostgreSQL Joins Explained   | published |
| Indexes for Beginners        | draft     |
| Backend APIs with PostgreSQL | published |

Result:

```text
total_posts = 3
published = 2
```

---

# SUM()

Calculates the total value.

Example:

```sql
SUM(views)
```

---

Query:

```sql
SELECT SUM(views)
FROM posts;
```

---

### Example Data

| views |
| ----- |
| 100   |
| 40    |
| 180   |

Calculation:

```text
100 + 40 + 180
```

Result:

```text
320
```

---

# AVG()

Calculates the average value.

Example:

```sql
AVG(views)
```

---

### Example Data

| views |
| ----- |
| 100   |
| 40    |
| 180   |

Calculation:

```text
(100 + 40 + 180) / 3
```

Result:

```text
106.67
```

---

# MIN()

Returns the smallest value.

Example:

```sql
MIN(views)
```

---

### Example Data

| views |
| ----- |
| 100   |
| 40    |
| 180   |

Result:

```text
40
```

Lowest viewed post.

---

# MAX()

Returns the largest value.

Example:

```sql
MAX(views)
```

---

### Example Data

| views |
| ----- |
| 100   |
| 40    |
| 180   |

Result:

```text
180
```

Highest viewed post.

---

# Complete Dashboard Query

```sql
SELECT
    COUNT(*) AS total_posts,

    COUNT(*) FILTER (
        WHERE status = 'published'
    ) AS published,

    SUM(views) AS total_views,

    AVG(views) AS avg_views,

    MIN(views) AS lowest_views,

    MAX(views) AS highest_views

FROM posts AS p;
```

---

# Understanding Each Metric

## Total Posts

```sql
COUNT(*)
```

Returns:

```text
Total number of posts
```

---

## Published Posts

```sql
COUNT(*) FILTER (
    WHERE status = 'published'
)
```

Returns:

```text
Number of published posts
```

---

## Total Views

```sql
SUM(views)
```

Returns:

```text
Combined views of all posts
```

---

## Average Views

```sql
AVG(views)
```

Returns:

```text
Average views per post
```

---

## Lowest Views

```sql
MIN(views)
```

Returns:

```text
Least viewed post count
```

---

## Highest Views

```sql
MAX(views)
```

Returns:

```text
Most viewed post count
```

---

# Example Result

| total_posts | published | total_views | avg_views | lowest_views | highest_views |
| ----------- | --------- | ----------- | --------- | ------------ | ------------- |
| 3           | 2         | 320         | 106.67    | 40           | 180           |

---

# Why Aggregates Are Important

Without aggregates:

```sql
SELECT *
FROM posts;
```

You get every row.

With aggregates:

```sql
SELECT COUNT(*)
FROM posts;
```

You get a meaningful summary.

This is perfect for:

```text
Admin Dashboards
Reports
Analytics
Statistics
KPIs
```

---

# Real-World Examples

Total users:

```sql
SELECT COUNT(*)
FROM users;
```

---

Total revenue:

```sql
SELECT SUM(amount)
FROM payments;
```

---

Average order value:

```sql
SELECT AVG(total)
FROM orders;
```

---

Highest salary:

```sql
SELECT MAX(salary)
FROM employees;
```

---

Lowest product price:

```sql
SELECT MIN(price)
FROM products;
```

---
