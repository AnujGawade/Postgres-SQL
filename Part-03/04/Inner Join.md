# INNER JOIN

`INNER JOIN` is one of the most commonly used JOINs in PostgreSQL.

It returns:

```text
Only the matching rows
from both tables.
```

If a row does not have a matching value in the other table:

```text
It is excluded from the result.
```

---

# Why Do We Need INNER JOIN?

Data in relational databases is stored across multiple tables.

Example:

Users table:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |

Posts table:

| id     | user_id | title                        |
| ------ | ------- | ---------------------------- |
| post-1 | uuid-1  | PostgreSQL Joins Explained   |
| post-2 | uuid-2  | Backend APIs with PostgreSQL |

Notice:

```text
users
```

contains:

```text
name
```

and

```text
posts
```

contains:

```text
title
status
views
```

To see both together, we need a JOIN.

---

# Complete SQL for This Lesson

```sql
SELECT
    users.name AS author_name,
    posts.title AS post_title,
    posts.status,
    posts.views
FROM posts
INNER JOIN users
    ON posts.user_id = users.id
WHERE posts.status = 'published'
ORDER BY posts.views DESC;
```

---

# Understanding the Query

## SELECT

```sql
SELECT
    users.name AS author_name,
    posts.title AS post_title,
    posts.status,
    posts.views
```

Returns:

- author name
- post title
- post status
- view count

---

# Using Aliases

```sql
users.name AS author_name
```

Output column becomes:

```text
author_name
```

---

```sql
posts.title AS post_title
```

Output column becomes:

```text
post_title
```

Aliases make result sets easier to read.

---

# FROM

```sql
FROM posts
```

Start with the posts table.

---

# INNER JOIN

```sql
INNER JOIN users
```

Combine:

```text
posts
+
users
```

---

# ON Clause

```sql
ON posts.user_id = users.id
```

This is the matching condition.

Meaning:

```text
Find rows where:

posts.user_id
=
users.id
```

---

# Visual Example

Users:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |

Posts:

| title                        | user_id |
| ---------------------------- | ------- |
| PostgreSQL Joins Explained   | uuid-1  |
| Backend APIs with PostgreSQL | uuid-2  |

Matching:

```text
uuid-1 = uuid-1
uuid-2 = uuid-2
```

Rows are joined together.

---

# Result After INNER JOIN

| author_name | post_title                   |
| ----------- | ---------------------------- |
| Anuj        | PostgreSQL Joins Explained   |
| Sudhanshu   | Backend APIs with PostgreSQL |

Only matching rows are returned.

---

# Why It's Called INNER JOIN

Think of two circles:

```text
users       posts
   ○──────○
```

INNER JOIN returns:

```text
Only the overlapping part
```

The rows that exist in both tables through the join condition.

---

# WHERE Clause

```sql
WHERE posts.status = 'published'
```

Filter the joined result.

Only return posts where:

```text
status = published
```

---

# Example Data

| title                        | status    |
| ---------------------------- | --------- |
| PostgreSQL Joins Explained   | published |
| Indexes for Beginners        | draft     |
| Backend APIs with PostgreSQL | published |

Result:

| title                        |
| ---------------------------- |
| PostgreSQL Joins Explained   |
| Backend APIs with PostgreSQL |

Draft posts are excluded.

---

# ORDER BY

```sql
ORDER BY posts.views DESC;
```

Sort the results by:

```text
views
```

in descending order.

---

# DESC Meaning

```text
Highest → Lowest
```

---

# Example Data

| title                        | views |
| ---------------------------- | ----- |
| PostgreSQL Joins Explained   | 100   |
| Backend APIs with PostgreSQL | 180   |

Result:

| title                        | views |
| ---------------------------- | ----- |
| Backend APIs with PostgreSQL | 180   |
| PostgreSQL Joins Explained   | 100   |

Most viewed posts appear first.

---

# Complete Result Example

| author_name | post_title                   | status    | views |
| ----------- | ---------------------------- | --------- | ----- |
| Sudhanshu   | Backend APIs with PostgreSQL | published | 180   |
| Anuj        | PostgreSQL Joins Explained   | published | 100   |

Explanation:

```text
Only matching users and posts
Only published posts
Sorted by views descending
```

---

# What INNER JOIN Excludes

Suppose:

Users:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |
| uuid-3 | Rahul     |

Posts:

| user_id |
| ------- |
| uuid-1  |
| uuid-2  |

Rahul has no posts.

Result:

```text
Rahul is excluded.
```

Because:

```text
No matching post exists.
```

Similarly:

If a post references a user that doesn't exist:

```text
That post is excluded.
```

---

# Real-World Examples

Customers and Orders:

```text
customers.id
        ↓
orders.customer_id
```

Show orders with customer names.

---

Products and Reviews:

```text
products.id
        ↓
reviews.product_id
```

Show products with reviews.

---

Posts and Comments:

```text
posts.id
        ↓
comments.post_id
```

Show posts with comments.

---
