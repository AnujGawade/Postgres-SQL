# Table Aliases

Table aliases are short names given to tables inside a query.

They make queries:

- shorter
- easier to read
- easier to write
- especially useful when working with JOINs

Instead of repeatedly writing:

```sql
posts.title
```

we can write:

```sql
p.title
```

This makes complex queries much cleaner.

---

# Why Use Table Aliases?

Without aliases:

```sql
SELECT
    posts.title,
    posts.status,
    posts.views,
    users.name
FROM posts
INNER JOIN users
    ON posts.user_id = users.id;
```

This works perfectly.

But in large queries with multiple joins:

```text
posts
users
comments
tags
post_tags
```

the query becomes long and harder to read.

Aliases solve this problem.

---

# Alias Syntax

```sql
FROM posts AS p
```

Meaning:

```text
posts
↓
p
```

For the rest of the query:

```sql
posts.title
```

can be written as:

```sql
p.title
```

---

# Using AS

```sql
FROM posts AS p
```

`AS` means:

```text
Give this table a temporary name.
```

---

# Short Form

PostgreSQL also allows:

```sql
FROM posts p
```

This is equivalent to:

```sql
FROM posts AS p
```

Both are correct.

---

# Common Alias Naming

| Table     | Alias |
| --------- | ----- |
| posts     | p     |
| users     | u     |
| comments  | c     |
| tags      | t     |
| post_tags | pt    |

These short names are commonly used in SQL queries.

---

# Complete SQL for This Lesson

```sql
SELECT
    p.title AS post_title,
    p.status,
    p.views,
    u.name AS author_name,
    c.body AS comment_body
FROM posts AS p
INNER JOIN users AS u
    ON p.user_id = u.id
LEFT JOIN comments AS c
    ON p.id = c.post_id
ORDER BY p.views DESC;
```

---

# Understanding the Aliases

## Posts Table

```sql
FROM posts AS p
```

Alias:

```text
p
```

Now:

```sql
posts.title
```

becomes:

```sql
p.title
```

---

## Users Table

```sql
INNER JOIN users AS u
```

Alias:

```text
u
```

Now:

```sql
users.name
```

becomes:

```sql
u.name
```

---

## Comments Table

```sql
LEFT JOIN comments AS c
```

Alias:

```text
c
```

Now:

```sql
comments.body
```

becomes:

```sql
c.body
```

---

# SELECT Clause

```sql
SELECT
    p.title AS post_title,
    p.status,
    p.views,
    u.name AS author_name,
    c.body AS comment_body
```

Returns:

- post title
- post status
- post views
- author name
- comment body

---

# Column Aliases

Notice we are using aliases for columns too.

Example:

```sql
p.title AS post_title
```

Output column:

```text
post_title
```

---

```sql
u.name AS author_name
```

Output column:

```text
author_name
```

---

```sql
c.body AS comment_body
```

Output column:

```text
comment_body
```

This makes result sets more descriptive.

---

# INNER JOIN with Aliases

```sql
INNER JOIN users AS u
    ON p.user_id = u.id
```

Equivalent to:

```sql
INNER JOIN users
    ON posts.user_id = users.id
```

Much shorter and easier to read.

---

# LEFT JOIN with Aliases

```sql
LEFT JOIN comments AS c
    ON p.id = c.post_id
```

Equivalent to:

```sql
LEFT JOIN comments
    ON posts.id = comments.post_id
```

Again, shorter and cleaner.

---

# Result Example

| post_title                   | status    | views | author_name | comment_body             |
| ---------------------------- | --------- | ----- | ----------- | ------------------------ |
| Backend APIs with PostgreSQL | published | 180   | Sudhanshu   | Please add more examples |
| PostgreSQL Joins Explained   | published | 100   | Anuj        | Very clear explanation   |
| Indexes for Beginners        | draft     | 40    | Anuj        | NULL                     |

Notice:

```text
Indexes for Beginners
```

has no comment.

Because:

```sql
LEFT JOIN comments
```

keeps the post and returns:

```text
NULL
```

for comment data.

---

# ORDER BY

```sql
ORDER BY p.views DESC;
```

Sort by:

```text
views
```

from highest to lowest.

Example:

```text
180
100
40
```

---

# Why Aliases Are Useful

Benefits:

### Shorter Queries

Instead of:

```sql
posts.title
users.name
comments.body
```

we write:

```sql
p.title
u.name
c.body
```

---

### Easier to Read

Especially when queries contain:

```text
3+
4+
5+ tables
```

---

### Easier Maintenance

Complex JOIN queries become much easier to understand.

---

# Real-World Example

Large query without aliases:

```sql
SELECT
    posts.title,
    users.name,
    comments.body
```

Large query with aliases:

```sql
SELECT
    p.title,
    u.name,
    c.body
```

Most professional SQL developers use aliases for joined tables.

---
