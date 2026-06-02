# Many-to-Many Relationship

A **Many-to-Many Relationship** means:

```text
One row in Table A
        ↓
Can be related to many rows in Table B

AND

One row in Table B
        ↓
Can be related to many rows in Table A
```

This type of relationship cannot be implemented directly.

We need a special table called a:

```text
Junction Table
```

or

```text
Bridge Table
```

---

# Real-World Example

Blog Application:

```text
One Post
    ↓
Can have many Tags
```

Example:

```text
PostgreSQL Joins Explained
 ├── sql
 ├── database
 └── backend
```

---

At the same time:

```text
One Tag
    ↓
Can belong to many Posts
```

Example:

```text
sql
 ├── PostgreSQL Joins Explained
 ├── Indexes for Beginners
 └── SQL Performance Tips
```

---

# Why We Need a Junction Table

Suppose we only had:

```text
posts
tags
```

There is no direct way to store:

```text
Many posts
↔
Many tags
```

So we create:

```text
post_tags
```

---

# Database Structure

```text
posts
    ↓
post_tags
    ↓
tags
```

---

# Relationship Mapping

```text
posts.id
        ↓
post_tags.post_id
```

and

```text
tags.id
        ↓
post_tags.tag_id
```

---

# Visual Representation

Posts:

| id  | title                        |
| --- | ---------------------------- |
| p1  | PostgreSQL Joins Explained   |
| p2  | Indexes for Beginners        |
| p3  | Backend APIs with PostgreSQL |

---

Tags:

| id  | name    |
| --- | ------- |
| t1  | sql     |
| t2  | backend |

---

Post Tags:

| post_id | tag_id |
| ------- | ------ |
| p1      | t1     |
| p2      | t1     |
| p3      | t2     |

This table stores relationships.

---

# Understanding post_tags

The table:

```text
post_tags
```

does not store business data.

It stores:

```text
Connections
```

between posts and tags.

Think:

```text
Relationship Table
```

---

# Complete SQL for This Lesson

```sql
SELECT
    posts.title AS post_title,
    tags.name AS tag_name
FROM posts
INNER JOIN post_tags
    ON posts.id = post_tags.post_id
INNER JOIN tags
    ON post_tags.tag_id = tags.id
ORDER BY posts.title, tags.name;
```

---

# Goal of the Query

Return:

```text
Every post
+
Its associated tag
```

Example:

| post_title                   | tag_name |
| ---------------------------- | -------- |
| PostgreSQL Joins Explained   | sql      |
| Indexes for Beginners        | sql      |
| Backend APIs with PostgreSQL | backend  |

---

# Understanding the Query

## SELECT

```sql
SELECT
    posts.title AS post_title,
    tags.name AS tag_name
```

Returns:

- post title
- tag name

---

# Aliases

```sql
posts.title AS post_title
```

Output:

```text
post_title
```

---

```sql
tags.name AS tag_name
```

Output:

```text
tag_name
```

Improves readability.

---

# First JOIN

```sql
INNER JOIN post_tags
    ON posts.id = post_tags.post_id
```

Connect:

```text
posts
↔
post_tags
```

Matching rule:

```text
posts.id
=
post_tags.post_id
```

---

# Visual Example

Posts:

| id  | title                      |
| --- | -------------------------- |
| p1  | PostgreSQL Joins Explained |

Post Tags:

| post_id | tag_id |
| ------- | ------ |
| p1      | t1     |

Match:

```text
p1 = p1
```

Rows are connected.

---

# Second JOIN

```sql
INNER JOIN tags
    ON post_tags.tag_id = tags.id
```

Connect:

```text
post_tags
↔
tags
```

Matching rule:

```text
post_tags.tag_id
=
tags.id
```

---

# Visual Example

Post Tags:

| tag_id |
| ------ |
| t1     |

Tags:

| id  | name |
| --- | ---- |
| t1  | sql  |

Match:

```text
t1 = t1
```

Rows are connected.

---

# Final Relationship

```text
posts
    ↓
post_tags
    ↓
tags
```

PostgreSQL follows the chain:

```text
Post
    ↓
Relationship
    ↓
Tag
```

---

# Result

| post_title                   | tag_name |
| ---------------------------- | -------- |
| Backend APIs with PostgreSQL | backend  |
| Indexes for Beginners        | sql      |
| PostgreSQL Joins Explained   | sql      |

---

# ORDER BY

```sql
ORDER BY posts.title, tags.name;
```

Sorts by:

### First

```text
posts.title
```

Alphabetically.

---

### Then

```text
tags.name
```

Within each post.

---

# Why INNER JOIN Is Used

We only want:

```text
Posts that have tags
```

and

```text
Tags that belong to posts
```

If a post has no tag:

```text
It will not appear.
```

Because:

```text
INNER JOIN only returns matching rows.
```

---

# Real-World Many-to-Many Examples

Students and Courses:

```text
students
    ↔
enrollments
    ↔
courses
```

A student can take many courses.

A course can have many students.

---

Products and Categories:

```text
products
    ↔
product_categories
    ↔
categories
```

---

Users and Roles:

```text
users
    ↔
user_roles
    ↔
roles
```

---

Posts and Tags:

```text
posts
    ↔
post_tags
    ↔
tags
```

---

# Why Junction Tables Are Important

Without a junction table:

```text
Many-to-Many relationships
cannot be represented properly.
```

The junction table:

- stores relationships
- avoids duplication
- keeps data normalized
- makes joins possible

---
