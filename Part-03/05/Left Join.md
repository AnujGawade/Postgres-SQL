# LEFT JOIN

`LEFT JOIN` is used when you want to keep **all rows from the left table**, even if there is no matching row in the right table.

Unlike `INNER JOIN`:

```text
INNER JOIN
    ↓
Only matching rows
```

`LEFT JOIN`:

```text
LEFT JOIN
    ↓
All rows from the left table
+
Matching rows from the right table
```

If no match exists:

```text
NULL is returned for the right table columns.
```

---

# Why Use LEFT JOIN?

In real-world applications, relationships are often optional.

Example:

```text
Posts
    ↓
Comments
```

Some posts may have:

```text
100 comments
```

Some posts may have:

```text
0 comments
```

If we use:

```sql
INNER JOIN
```

Posts without comments disappear.

If we use:

```sql
LEFT JOIN
```

Every post remains visible.

---

# Understanding Left and Right Tables

Query:

```sql
FROM posts
LEFT JOIN comments
```

---

## Left Table

```text
posts
```

All rows from this table will be returned.

---

## Right Table

```text
comments
```

Only matching rows will be returned.

If no match exists:

```text
NULL
```

is returned.

---

# Relationship

```text
posts.id
        ↓
comments.post_id
```

One post can have:

```text
Many comments
```

This is a:

```text
One-to-Many Relationship
```

---

# Complete SQL for This Lesson

```sql
SELECT
    posts.title AS post_title,
    comments.body AS comment_body
FROM posts
LEFT JOIN comments
    ON posts.id = comments.post_id
ORDER BY posts.title;
```

---

# Understanding the Query

## SELECT

```sql
SELECT
    posts.title AS post_title,
    comments.body AS comment_body
```

Returns:

- post title
- comment text

---

# Aliases

```sql
posts.title AS post_title
```

Output column:

```text
post_title
```

---

```sql
comments.body AS comment_body
```

Output column:

```text
comment_body
```

Makes the result easier to understand.

---

# FROM

```sql
FROM posts
```

Start with:

```text
posts table
```

---

# LEFT JOIN

```sql
LEFT JOIN comments
```

Join:

```text
posts
+
comments
```

while keeping every post.

---

# ON Clause

```sql
ON posts.id = comments.post_id
```

Matching condition:

```text
posts.id
=
comments.post_id
```

PostgreSQL uses this to connect related rows.

---

# Example Data

Posts:

| id  | title                        |
| --- | ---------------------------- |
| p1  | PostgreSQL Joins Explained   |
| p2  | Indexes for Beginners        |
| p3  | Backend APIs with PostgreSQL |

---

Comments:

| post_id | body                     |
| ------- | ------------------------ |
| p1      | Very clear explanation   |
| p3      | Please add more examples |

---

# Result of LEFT JOIN

| post_title                   | comment_body             |
| ---------------------------- | ------------------------ |
| Backend APIs with PostgreSQL | Please add more examples |
| Indexes for Beginners        | NULL                     |
| PostgreSQL Joins Explained   | Very clear explanation   |

Notice:

```text
Indexes for Beginners
```

has no comment.

But it still appears.

Why?

Because:

```text
LEFT JOIN keeps all rows from posts.
```

---

# Why NULL Appears

For:

```text
Indexes for Beginners
```

No matching comment exists.

PostgreSQL returns:

```text
NULL
```

for:

```text
comments.body
```

This indicates:

```text
No related record found.
```

---

# Difference Between INNER JOIN and LEFT JOIN

## INNER JOIN

```sql
SELECT ...
FROM posts
INNER JOIN comments
    ON posts.id = comments.post_id;
```

Result:

| post_title                   | comment_body             |
| ---------------------------- | ------------------------ |
| PostgreSQL Joins Explained   | Very clear explanation   |
| Backend APIs with PostgreSQL | Please add more examples |

Posts without comments disappear.

---

## LEFT JOIN

```sql
SELECT ...
FROM posts
LEFT JOIN comments
    ON posts.id = comments.post_id;
```

Result:

| post_title                   | comment_body             |
| ---------------------------- | ------------------------ |
| PostgreSQL Joins Explained   | Very clear explanation   |
| Backend APIs with PostgreSQL | Please add more examples |
| Indexes for Beginners        | NULL                     |

All posts remain.

---

# Finding Posts Without Comments

A very common use case.

```sql
SELECT
    posts.title
FROM posts
LEFT JOIN comments
    ON posts.id = comments.post_id
WHERE comments.id IS NULL;
```

Meaning:

```text
Show posts that have no comments.
```

---

# Example Result

| title                 |
| --------------------- |
| Indexes for Beginners |

Because:

```text
No matching comment exists.
```

---

# ORDER BY

```sql
ORDER BY posts.title;
```

Sorts posts alphabetically.

Example:

```text
Backend APIs with PostgreSQL
Indexes for Beginners
PostgreSQL Joins Explained
```

---

# Real-World Examples

Customers and Orders:

```text
Show all customers
Even if they never ordered anything
```

---

Products and Reviews:

```text
Show all products
Even if they have no reviews
```

---

Users and Posts:

```text
Show all users
Even if they never wrote a post
```

---

Posts and Comments:

```text
Show all posts
Even if nobody commented
```

---
