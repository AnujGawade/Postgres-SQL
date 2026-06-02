# Indexes

An **Index** helps PostgreSQL find rows faster.

Without an index, PostgreSQL may need to scan every row in a table to find matching data.

With an index, PostgreSQL can jump much closer to the data it needs.

Indexes are one of the most important tools for improving database query performance.

---

# Real-World Analogy

Think about a book.

Without an index page:

```text
Read page 1
Read page 2
Read page 3
...
until you find the topic
```

This is similar to:

```text
Full Table Scan
```

---

With an index page:

```text
Look up the topic
Go directly to the page number
```

This is similar to:

```text
Database Index
```

---

# Why Indexes Matter

Imagine:

```text
posts table
```

contains:

```text
10 rows
100 rows
1,000 rows
100,000 rows
1,000,000 rows
```

As the table grows, searching becomes slower.

Without an index:

```text
PostgreSQL may inspect every row.
```

With an index:

```text
PostgreSQL can locate matching rows much faster.
```

---

# Viewing Data

```sql
SELECT
    id,
    title,
    status,
    user_id,
    views
FROM posts;
```

Returns all post records.

No filtering is happening here.

---

# Example Query

Suppose an API endpoint exists:

```text
/posts?status=published
```

Query:

```sql
SELECT
    id,
    title,
    status
FROM posts
WHERE status = 'published';
```

---

# What Happens Without an Index?

PostgreSQL may perform:

```text
Sequential Scan
```

Meaning:

```text
Check row 1
Check row 2
Check row 3
...
until the end
```

This becomes expensive on large tables.

---

# Creating an Index

```sql
CREATE INDEX IF NOT EXISTS idx_posts_status
ON posts(status);
```

---

# Understanding the Name

```text
idx_posts_status
```

Common naming convention:

```text
idx
    ↓
Index

posts
    ↓
Table Name

status
    ↓
Column Name
```

---

# Meaning

```sql
ON posts(status)
```

Create an index on:

```text
posts.status
```

Now PostgreSQL can find:

```text
published
draft
```

much faster.

---

# Example Query Using the Index

```sql
SELECT
    id,
    title,
    status
FROM posts
WHERE status = 'published';
```

This query can benefit from:

```sql
idx_posts_status
```

---

# Sorting and Filtering Together

Query:

```sql
SELECT
    title,
    status,
    views
FROM posts
WHERE status = 'published'
ORDER BY views DESC;
```

---

# Problem

PostgreSQL must:

### Step 1

Find:

```text
published posts
```

### Step 2

Sort them by:

```text
views DESC
```

---

# Composite Index

To optimize both operations:

```sql
CREATE INDEX IF NOT EXISTS idx_posts_status_views
ON posts(status, views DESC);
```

---

# What Is a Composite Index?

A composite index contains:

```text
Multiple Columns
```

Instead of:

```sql
(status)
```

we create:

```sql
(status, views)
```

---

# Benefit

The index helps PostgreSQL:

```text
Filter by status
AND
Sort by views
```

using the same index.

---

# Visual Example

Index:

```text
status     views
----------------
published  180
published  100
draft      40
```

PostgreSQL can retrieve sorted results faster.

---

# Another Common Query

Suppose your API is:

```text
/users/:id/posts
```

Meaning:

```text
Get all posts written by a user.
```

---

# Query

```sql
SELECT
    title,
    status,
    views
FROM posts
WHERE user_id = (
    SELECT id
    FROM users
    WHERE name = 'rahul'
);
```

---

# What Happens Here?

### Inner Query

```sql
SELECT id
FROM users
WHERE name = 'rahul';
```

Returns:

```text
User UUID
```

---

### Outer Query

```sql
SELECT ...
FROM posts
WHERE user_id = ...
```

Finds posts belonging to that user.

---

# Why Index user_id?

Without an index:

```text
PostgreSQL scans every post.
```

Looking for:

```text
Matching user_id
```

---

# Create Index

```sql
CREATE INDEX IF NOT EXISTS idx_posts_user_id
ON posts(user_id);
```

---

# Benefit

Queries like:

```sql
WHERE user_id = ...
```

become much faster.

Especially when:

```text
posts table
```

contains:

```text
Thousands
Millions
of rows
```

---

# Types of Indexes Learned

## Single Column Index

```sql
CREATE INDEX idx_posts_status
ON posts(status);
```

Indexes one column.

Useful for:

```sql
WHERE status = 'published'
```

---

## Composite Index

```sql
CREATE INDEX idx_posts_status_views
ON posts(status, views DESC);
```

Indexes multiple columns.

Useful for:

```sql
WHERE status = 'published'
ORDER BY views DESC
```

---

## Foreign Key Search Index

```sql
CREATE INDEX idx_posts_user_id
ON posts(user_id);
```

Useful for:

```sql
WHERE user_id = ...
```

---

# Important Trade-Off

Indexes make:

```text
SELECT
```

faster.

But they also make:

```text
INSERT
UPDATE
DELETE
```

slightly slower.

Why?

Because PostgreSQL must update the index whenever data changes.

---

# Rule of Thumb

Create indexes on columns that are frequently used in:

```sql
WHERE
```

```sql
JOIN
```

```sql
ORDER BY
```

```sql
GROUP BY
```

Avoid indexing every column.

Too many indexes can slow down writes.

---

# Real-World Examples

Find users by email:

```sql
CREATE INDEX idx_users_email
ON users(email);
```

---

Find products by category:

```sql
CREATE INDEX idx_products_category
ON products(category);
```

---

Find orders by customer:

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
```

---
