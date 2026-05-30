# Foreign Keys

A **Foreign Key** is a column that references the **Primary Key** of another table.

Foreign keys create relationships between tables and help maintain data integrity.

They ensure that related records actually exist.

---

# Why Foreign Keys Matter

Imagine a blogging application.

We have:

```text
users
posts
```

A post should always belong to a valid user.

Without foreign keys, someone could accidentally create:

```text
Post
    ↓
User ID = xyz123
```

even if that user doesn't exist.

Foreign keys prevent this problem.

---

# Definition

```text
Primary Key
    ↓
Uniquely identifies a row

Foreign Key
    ↓
References the primary key of another table
```

---

# Example from Our Database

Users table:

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL
);
```

Posts table:

```sql
CREATE TABLE posts (
    id UUID PRIMARY KEY,

    user_id UUID NOT NULL REFERENCES users(id),

    title TEXT NOT NULL
);
```

---

# Understanding the Relationship

```sql
user_id UUID NOT NULL REFERENCES users(id)
```

Meaning:

```text
posts.user_id
    ↓
references
    ↓
users.id
```

---

# Visual Representation

```text
users
--------------------------------------------------
id                                  | name
--------------------------------------------------
uuid-1                              | Anuj
uuid-2                              | Sudhanshu
```

```text
posts
---------------------------------------------------------
id         | user_id      | title
---------------------------------------------------------
post-1     | uuid-1       | PostgreSQL Joins Explained
post-2     | uuid-1       | Indexes for Beginners
post-3     | uuid-2       | Backend APIs with PostgreSQL
```

---

# Relationship Type

```text
One User
    ↓
Many Posts
```

This is called:

```text
One-to-Many Relationship
```

---

# Example

User:

```text
Anuj
```

Can create:

```text
Post 1
Post 2
Post 3
```

But each post belongs to only one user.

---

# Viewing Users

```sql
SELECT
    id,
    name
FROM users;
```

Example output:

| id     | name      |
| ------ | --------- |
| uuid-1 | Anuj      |
| uuid-2 | Sudhanshu |

This table contains the parent records.

---

# Viewing Posts

```sql
SELECT
    id,
    user_id,
    title
FROM posts;
```

Example output:

| id     | user_id | title                        |
| ------ | ------- | ---------------------------- |
| post-1 | uuid-1  | PostgreSQL Joins Explained   |
| post-2 | uuid-1  | Indexes for Beginners        |
| post-3 | uuid-2  | Backend APIs with PostgreSQL |

Notice:

```text
user_id
```

contains values from:

```text
users.id
```

---

# How Foreign Keys Protect Data

Suppose we try:

```sql
INSERT INTO posts (
    user_id,
    title
)
VALUES (
    'random-uuid',
    'New Post'
);
```

If:

```text
random-uuid
```

does not exist in:

```text
users.id
```

PostgreSQL rejects the insert.

Error:

```text
violates foreign key constraint
```

---

# What Foreign Keys Ensure

They guarantee:

- every post belongs to a valid user
- no orphan records
- relationships stay consistent
- invalid references cannot be inserted

---

# Parent Table vs Child Table

### Parent Table

```text
users
```

Contains:

```text
Primary Key
```

Example:

```sql
users.id
```

---

### Child Table

```text
posts
```

Contains:

```text
Foreign Key
```

Example:

```sql
posts.user_id
```

---

# Relationship Summary

```text
users.id
    ↓
posts.user_id
```

Meaning:

```text
Each post belongs to one user.
```

---

# Real-World Examples

Users and Orders:

```text
users.id
    ↓
orders.user_id
```

---

Products and Reviews:

```text
products.id
    ↓
reviews.product_id
```

---

Customers and Payments:

```text
customers.id
    ↓
payments.customer_id
```

---

Posts and Comments:

```text
posts.id
    ↓
comments.post_id
```

---

# Why Foreign Keys Are Important

Without foreign keys:

```text
Invalid references
Missing relationships
Inconsistent data
Orphan records
```

With foreign keys:

```text
Reliable relationships
Data integrity
Consistent database structure
```

---
