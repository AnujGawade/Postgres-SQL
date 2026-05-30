# Building a Relational Database for Joins

In this lesson, we created a small blogging system database that demonstrates real-world relationships between tables.

The goal is to prepare data for learning:

- One-to-Many relationships
- Many-to-Many relationships
- Foreign Keys
- JOIN queries
- Relational database design

This setup will be used in upcoming JOIN lessons.

---

# Database Structure

We created 5 tables:

```text
users
posts
comments
tags
post_tags
```

Relationship overview:

```text
users
  │
  └── posts
          │
          └── comments

posts
  │
  └── post_tags
          │
          └── tags
```

---

# Complete SQL for This Lesson

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TABLE IF EXISTS post_tags;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL
);

CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL REFERENCES users(id),

    title TEXT NOT NULL,

    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (status IN ('draft', 'published')),

    views INTEGER NOT NULL DEFAULT 0
        CHECK (views >= 0)
);

CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    post_id UUID NOT NULL REFERENCES posts(id),

    body TEXT NOT NULL
);

CREATE TABLE tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name TEXT NOT NULL UNIQUE
);

CREATE TABLE post_tags (
    post_id UUID NOT NULL REFERENCES posts(id),

    tag_id UUID NOT NULL REFERENCES tags(id),

    PRIMARY KEY (post_id, tag_id)
);
```

---

# Enabling pgcrypto Extension

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

Required for:

```sql
gen_random_uuid()
```

This function generates UUID values automatically.

Example:

```text
550e8400-e29b-41d4-a716-446655440000
```

---

# Users Table

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL
);
```

Stores application users.

Example:

| id   | name      |
| ---- | --------- |
| uuid | Anuj      |
| uuid | Sudhanshu |

---

# Posts Table

```sql
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL REFERENCES users(id),

    title TEXT NOT NULL,

    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (status IN ('draft', 'published')),

    views INTEGER NOT NULL DEFAULT 0
        CHECK (views >= 0)
);
```

Stores blog posts.

---

# Foreign Key

```sql
user_id UUID NOT NULL REFERENCES users(id)
```

This creates a relationship.

Meaning:

```text
Each post belongs to a user.
```

---

# One-to-Many Relationship

```text
One User
    ↓
Many Posts
```

Example:

```text
Anuj
 ├── PostgreSQL Joins Explained
 └── Indexes for Beginners
```

---

# Status Constraint

```sql
CHECK (
    status IN ('draft', 'published')
)
```

Allowed:

```text
draft
published
```

Rejected:

```text
active
completed
pending
```

---

# Views Constraint

```sql
CHECK (views >= 0)
```

Prevents negative views.

Valid:

```text
0
10
100
```

Invalid:

```text
-5
```

---

# Comments Table

```sql
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    post_id UUID NOT NULL REFERENCES posts(id),

    body TEXT NOT NULL
);
```

Stores comments for posts.

---

# Relationship

```text
One Post
    ↓
Many Comments
```

Example:

```text
PostgreSQL Joins Explained
 ├── Great article
 ├── Very clear explanation
 └── Helpful examples
```

---

# Tags Table

```sql
CREATE TABLE tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name TEXT NOT NULL UNIQUE
);
```

Stores available tags.

Examples:

```text
sql
backend
postgresql
database
```

---

# UNIQUE Constraint

```sql
name TEXT UNIQUE
```

Prevents duplicate tags.

Valid:

```text
sql
backend
```

Invalid:

```text
sql
sql
```

---

# Post Tags Table

```sql
CREATE TABLE post_tags (
    post_id UUID NOT NULL REFERENCES posts(id),

    tag_id UUID NOT NULL REFERENCES tags(id),

    PRIMARY KEY (post_id, tag_id)
);
```

This table connects:

```text
posts
↔
tags
```

---

# Many-to-Many Relationship

A post can have many tags.

A tag can belong to many posts.

Example:

```text
Post A
 ├── sql
 └── backend

Post B
 └── sql
```

Relationship:

```text
posts
   ↔
post_tags
   ↔
tags
```

---

# Composite Primary Key

```sql
PRIMARY KEY (post_id, tag_id)
```

Prevents duplicate mappings.

Invalid:

```text
same post
same tag
```

being inserted twice.

---

# Inserting Users

```sql
INSERT INTO users (name)
VALUES
    ('Anuj'),
    ('Sudhanshu');
```

Creates two users.

---

# Inserting Posts

```sql
INSERT INTO posts (...)
SELECT ...
FROM users
WHERE name = 'Anuj';
```

Interesting concept:

Instead of manually finding UUIDs:

```sql
SELECT id
FROM users
```

PostgreSQL fetches the user's ID automatically.

This is a common production pattern.

---

# Sample Posts

```text
PostgreSQL Joins Explained
Indexes for Beginners
Backend APIs with PostgreSQL
```

---

# Inserting Comments

```sql
INSERT INTO comments (...)
SELECT id
FROM posts
WHERE title = ...
```

Each comment belongs to a post.

---

# Important Typo

You have:

```sql
WHERE title = 'PostgreSQL Joins Explains'
```

But actual title is:

```sql
'PostgreSQL Joins Explained'
```

Because of this typo:

```sql
No comment will be inserted.
```

Correct:

```sql
WHERE title = 'PostgreSQL Joins Explained';
```

---

# Inserting Tags

```sql
INSERT INTO tags (name)
VALUES
    ('sql'),
    ('backend');
```

Creates reusable tags.

---

# Connecting Posts and Tags

```sql
INSERT INTO post_tags (...)
SELECT ...
FROM posts p, tags t
WHERE ...
```

Creates relationships such as:

```text
PostgreSQL Joins Explained
    ↓
sql
```

and

```text
Backend APIs with PostgreSQL
    ↓
backend
```

---

# Why This Database Is Useful

This structure allows us to learn:

### One-to-Many

```text
users → posts
posts → comments
```

---

### Many-to-Many

```text
posts ↔ tags
```

---

### Foreign Keys

```sql
REFERENCES users(id)

REFERENCES posts(id)

REFERENCES tags(id)
```

---

### JOIN Queries

Upcoming lessons can easily demonstrate:

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN
```

using this dataset.

---
