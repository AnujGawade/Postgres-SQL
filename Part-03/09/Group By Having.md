# GROUP BY and HAVING Clause

`GROUP BY` and `HAVING` are used when we want to analyze data in groups rather than row by row.

They are commonly used in:

- Reports
- Dashboards
- Analytics
- CRM Systems
- Sales Reports
- User Activity Tracking

---

# Why GROUP BY Is Needed

Without grouping:

```sql
SELECT *
FROM posts;
```

Result:

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Indexes for Beginners        | 40    |
| Backend APIs with PostgreSQL | 180   |

This shows individual rows.

Sometimes we want answers like:

```text
How many posts did each author write?
How many views does each author have?
Which authors are most active?
```

For this we use:

```sql
GROUP BY
```

---

# What GROUP BY Does

```sql
GROUP BY
```

Creates groups of rows that share the same value.

Example:

Posts:

| author    | title                        |
| --------- | ---------------------------- |
| Anuj      | PostgreSQL Joins Explained   |
| Anuj      | Indexes for Beginners        |
| Sudhanshu | Backend APIs with PostgreSQL |

Grouping by:

```sql
GROUP BY author
```

Creates:

```text
Group 1
Anuj
 ├── PostgreSQL Joins Explained
 └── Indexes for Beginners

Group 2
Sudhanshu
 └── Backend APIs with PostgreSQL
```

Now aggregate functions can calculate values for each group.

---

# WHERE vs HAVING

This is one of the most important SQL concepts.

---

## WHERE

Filters rows **before grouping**.

```sql
WHERE status = 'published'
```

Meaning:

```text
Filter rows first
Then create groups
```

---

## HAVING

Filters groups **after grouping**.

```sql
HAVING COUNT(*) >= 2
```

Meaning:

```text
Create groups first
Then filter groups
```

---

# Rule to Remember

```text
WHERE
    ↓
Rows

GROUP BY
    ↓
Groups

HAVING
    ↓
Filtered Groups
```

---

# Goal of This Query

Find authors and show:

- total posts
- total views

Then filter authors based on how many posts they have written.

---

# Complete SQL for This Lesson

```sql
SELECT
    u.name AS author_name,
    COUNT(p.id) AS total_posts,
    SUM(p.views) AS total_views
FROM users AS u
LEFT JOIN posts AS p
    ON u.id = p.user_id
GROUP BY u.id, u.name
HAVING COUNT(p.id) = 1
ORDER BY total_posts DESC;
```

---

# Understanding the Query

## SELECT

```sql
SELECT
    u.name AS author_name,
    COUNT(p.id) AS total_posts,
    SUM(p.views) AS total_views
```

Returns:

- author name
- number of posts
- total views

---

# COUNT(p.id)

```sql
COUNT(p.id)
```

Counts how many posts belong to each author.

Example:

```text
Anuj
 ├── Post 1
 └── Post 2
```

Result:

```text
2
```

---

# SUM(p.views)

```sql
SUM(p.views)
```

Adds together all views for that author's posts.

Example:

```text
100 + 40
```

Result:

```text
140
```

---

# LEFT JOIN

```sql
FROM users AS u
LEFT JOIN posts AS p
    ON u.id = p.user_id
```

Relationship:

```text
users
    ↓
posts
```

This keeps all users, even if they have no posts.

---

# Why LEFT JOIN?

Suppose:

Users:

```text
Anuj
Sudhanshu
Rahul
```

Posts:

```text
Anuj → 2 posts
Sudhanshu → 1 post
Rahul → 0 posts
```

With:

```sql
LEFT JOIN
```

Rahul still appears.

---

# GROUP BY

```sql
GROUP BY u.id, u.name
```

Groups rows by user.

Why both columns?

Because PostgreSQL requires:

```text
Every non-aggregated selected column
must appear in GROUP BY.
```

---

# Example Groups

### Group 1

```text
Anuj
 ├── PostgreSQL Joins Explained
 └── Indexes for Beginners
```

---

### Group 2

```text
Sudhanshu
 └── Backend APIs with PostgreSQL
```

---

# HAVING Clause

```sql
HAVING COUNT(p.id) = 1
```

Meaning:

```text
Only keep authors
who have exactly 1 post.
```

---

# Important Note

Your comment says:

```text
Find Authors who have written at least 2 posts
```

But your query uses:

```sql
HAVING COUNT(p.id) = 1
```

These do not match.

---

## Current Query

```sql
HAVING COUNT(p.id) = 1
```

Returns:

```text
Authors with exactly 1 post.
```

Example:

```text
Sudhanshu
```

---

## To Find Authors With At Least 2 Posts

Use:

```sql
HAVING COUNT(p.id) >= 2
```

This matches the comment.

Example:

```text
Anuj
```

---

# ORDER BY

```sql
ORDER BY total_posts DESC;
```

Sorts authors by:

```text
Highest number of posts first.
```

---

# Example Data

Posts:

| author    | views |
| --------- | ----- |
| Anuj      | 100   |
| Anuj      | 40    |
| Sudhanshu | 180   |

---

# Grouped Result

| author_name | total_posts | total_views |
| ----------- | ----------- | ----------- |
| Anuj        | 2           | 140         |
| Sudhanshu   | 1           | 180         |

---

# Applying HAVING COUNT(p.id) = 1

Result:

| author_name | total_posts | total_views |
| ----------- | ----------- | ----------- |
| Sudhanshu   | 1           | 180         |

---

# Applying HAVING COUNT(p.id) >= 2

Result:

| author_name | total_posts | total_views |
| ----------- | ----------- | ----------- |
| Anuj        | 2           | 140         |

---

# Real-World Examples

Customers with more than 5 orders:

```sql
GROUP BY customer_id
HAVING COUNT(*) > 5;
```

---

Products sold at least 100 times:

```sql
GROUP BY product_id
HAVING COUNT(*) >= 100;
```

---

Authors with more than 1000 views:

```sql
GROUP BY author_id
HAVING SUM(views) > 1000;
```

---

# Execution Order

PostgreSQL processes this query roughly in this order:

```text
FROM
    ↓
JOIN
    ↓
WHERE
    ↓
GROUP BY
    ↓
HAVING
    ↓
SELECT
    ↓
ORDER BY
```

Understanding this order makes complex SQL much easier.

---
