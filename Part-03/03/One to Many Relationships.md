# One-to-Many Relationship

A **One-to-Many Relationship** means:

```text
One parent row
        ↓
Can have many child rows
```

But:

```text
One child row
        ↓
Can belong to only one parent row
```

This is one of the most common relationships in relational databases.

---

# Real-World Example

Blog Application:

```text
One User
    ↓
Many Posts
```

Example:

```text
Anuj
 ├── PostgreSQL Joins Explained
 ├── Indexes for Beginners
 └── Database Constraints
```

A user can write many posts.

However:

```text
One Post
```

can belong to only:

```text
One User
```

---

# Parent Table and Child Table

### Parent Table

```text
users
```

Stores the original user information.

---

### Child Table

```text
posts
```

Stores posts created by users.

---

# Relationship Structure

```text
users.id
        ↓
posts.user_id
```

---

# Understanding the Foreign Key

```sql
posts.user_id
```

is a:

```text
Foreign Key
```

that references:

```sql
users.id
```

which is the:

```text
Primary Key
```

of the users table.

---

# Visual Representation

Users:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |

---

Posts:

| id     | user_id | title                        |
| ------ | ------- | ---------------------------- |
| post-1 | uuid-1  | PostgreSQL Joins Explained   |
| post-2 | uuid-1  | Indexes for Beginners        |
| post-3 | uuid-2  | Backend APIs with PostgreSQL |

Notice:

```text
posts.user_id
```

stores:

```text
users.id
```

values.

---

# Important Concept

```sql
users.id
```

is the original user identifier.

Example:

```text
uuid-1
```

---

```sql
posts.user_id
```

stores that identifier.

Example:

```text
uuid-1
```

This creates the relationship.

Think:

```text
posts.user_id
        ↓
Points to
        ↓
users.id
```

---

# Why We Need JOINs

Information is stored in separate tables.

Users table:

```text
name
```

Posts table:

```text
title
status
user_id
```

Suppose we want:

```text
Author Name
Post Title
Post Status
```

Data exists across two tables.

We use:

```sql
JOIN
```

to combine them.

---

# Show All Posts With Their Authors

```sql
SELECT
    users.name AS author_name,
    posts.title AS post_title,
    posts.status
FROM users
INNER JOIN posts
    ON users.id = posts.user_id
ORDER BY users.name, posts.title;
```

---

# Understanding the Query

## SELECT

```sql
SELECT
    users.name AS author_name,
    posts.title AS post_title,
    posts.status
```

Returns:

- author name
- post title
- post status

---

# Aliases

```sql
users.name AS author_name
```

Output column:

```text
author_name
```

---

```sql
posts.title AS post_title
```

Output column:

```text
post_title
```

Aliases improve readability.

---

# FROM

```sql
FROM users
```

Start with the users table.

---

# INNER JOIN

```sql
INNER JOIN posts
```

Combine:

```text
users
+
posts
```

---

# ON Clause

```sql
ON users.id = posts.user_id
```

This is the matching condition.

Meaning:

```text
Find rows where:

users.id
=
posts.user_id
```

---

# Visual Join Example

Users:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |

Posts:

| title                        | user_id |
| ---------------------------- | ------- |
| PostgreSQL Joins Explained   | uuid-1  |
| Indexes for Beginners        | uuid-1  |
| Backend APIs with PostgreSQL | uuid-2  |

Matching:

```text
uuid-1 = uuid-1
uuid-2 = uuid-2
```

Rows are combined.

---

# Result

| author_name | post_title                   | status    |
| ----------- | ---------------------------- | --------- |
| Anuj        | Indexes for Beginners        | draft     |
| Anuj        | PostgreSQL Joins Explained   | published |
| Sudhanshu   | Backend APIs with PostgreSQL | published |

---

# ORDER BY

```sql
ORDER BY users.name, posts.title;
```

Sorting happens in two levels.

---

## First Sort

```sql
users.name
```

Sort by author name.

```text
Anuj
Sudhanshu
```

---

## Second Sort

```sql
posts.title
```

Within each author, sort posts alphabetically.

Example:

```text
Indexes for Beginners
PostgreSQL Joins Explained
```

---

# Why INNER JOIN Works Here

`INNER JOIN` only returns matching rows.

Meaning:

```text
Users that have posts
```

and

```text
Posts that belong to users
```

If no match exists:

```text
Row is excluded
```

---

# Relationship Summary

```text
users
    ↓
   id
    ↓
posts
 user_id
```

One User:

```text
Anuj
```

Many Posts:

```text
PostgreSQL Joins Explained
Indexes for Beginners
```

This is a classic:

```text
One-to-Many Relationship
```

---

# Real-World Examples

Customers → Orders

```text
customers.id
        ↓
orders.customer_id
```

---

Products → Reviews

```text
products.id
        ↓
reviews.product_id
```

---

Posts → Comments

```text
posts.id
        ↓
comments.post_id
```

---
