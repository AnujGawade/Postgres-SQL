# COUNT DISTINCT - Counting Unique Values

Sometimes we don't want to count every row.

Instead, we want to count only:

```text
Unique values
```

PostgreSQL provides:

```sql
COUNT(DISTINCT column)
```

This is commonly used in:

- Analytics
- Dashboards
- Reporting
- User Statistics
- Sales Reports
- Many-to-Many Relationships

---

# Why COUNT(DISTINCT) Is Needed

Imagine a table contains:

| post_id |
| ------- |
| p1      |
| p1      |
| p2      |
| p3      |
| p3      |

Using:

```sql
COUNT(post_id)
```

Result:

```text
5
```

Because every row is counted.

---

Using:

```sql
COUNT(DISTINCT post_id)
```

Result:

```text
3
```

Because only unique values are counted.

---

# What DISTINCT Does

```sql
DISTINCT
```

Removes duplicate values before calculation.

Example:

Before:

```text
sql
sql
sql
backend
backend
```

After:

```text
sql
backend
```

Duplicates are removed.

---

# Goal of This Query

We want to answer:

```text
How many unique posts
are connected to each tag?
```

Example:

```text
sql
 ├── PostgreSQL Joins Explained
 └── Indexes for Beginners

backend
 └── Backend APIs with PostgreSQL
```

Expected result:

```text
sql     → 2 posts
backend → 1 post
```

---

# Complete SQL for This Lesson

```sql
SELECT
    t.name AS tag_name,
    COUNT(DISTINCT p.id) AS total_unique_posts
FROM tags AS t
LEFT JOIN post_tags AS pt
    ON t.id = pt.tag_id
LEFT JOIN posts AS p
    ON pt.post_id = p.id
GROUP BY t.id, t.name
ORDER BY total_unique_posts DESC;
```

---

# Understanding the Query

## SELECT

```sql
SELECT
    t.name AS tag_name,
    COUNT(DISTINCT p.id) AS total_unique_posts
```

Returns:

- tag name
- number of unique posts connected to that tag

---

# COUNT(DISTINCT p.id)

```sql
COUNT(DISTINCT p.id)
```

Meaning:

```text
Count unique post IDs
for each tag
```

Duplicate post IDs are counted only once.

---

# Why DISTINCT Is Important

Imagine data accidentally looks like:

| tag | post   |
| --- | ------ |
| sql | Post A |
| sql | Post A |
| sql | Post B |

Without DISTINCT:

```sql
COUNT(p.id)
```

Result:

```text
3
```

---

With DISTINCT:

```sql
COUNT(DISTINCT p.id)
```

Result:

```text
2
```

Correct unique count.

---

# FROM

```sql
FROM tags AS t
```

Start with:

```text
tags table
```

---

# First LEFT JOIN

```sql
LEFT JOIN post_tags AS pt
    ON t.id = pt.tag_id
```

Connect:

```text
tags
    ↓
post_tags
```

Relationship:

```text
tags.id
=
post_tags.tag_id
```

---

# Second LEFT JOIN

```sql
LEFT JOIN posts AS p
    ON pt.post_id = p.id
```

Connect:

```text
post_tags
    ↓
posts
```

Relationship:

```text
post_tags.post_id
=
posts.id
```

---

# Relationship Flow

```text
tags
   ↓
post_tags
   ↓
posts
```

PostgreSQL follows the chain to find:

```text
Which posts belong to each tag
```

---

# Why LEFT JOIN?

```sql
LEFT JOIN
```

ensures:

```text
All tags appear
```

even if a tag has:

```text
0 posts
```

---

# Example Data

Tags:

| id  | name     |
| --- | -------- |
| t1  | sql      |
| t2  | backend  |
| t3  | database |

---

Post Tags:

| post_id | tag_id |
| ------- | ------ |
| p1      | t1     |
| p2      | t1     |
| p3      | t2     |

---

Posts:

| id  | title                        |
| --- | ---------------------------- |
| p1  | PostgreSQL Joins Explained   |
| p2  | Indexes for Beginners        |
| p3  | Backend APIs with PostgreSQL |

---

# Grouping

```sql
GROUP BY t.id, t.name
```

Creates one group per tag.

---

## Group 1

```text
sql
 ├── p1
 └── p2
```

Count:

```text
2
```

---

## Group 2

```text
backend
 └── p3
```

Count:

```text
1
```

---

## Group 3

```text
database
```

Count:

```text
0
```

Because no posts are connected.

---

# Result

| tag_name | total_unique_posts |
| -------- | ------------------ |
| sql      | 2                  |
| backend  | 1                  |
| database | 0                  |

---

# ORDER BY

```sql
ORDER BY total_unique_posts DESC;
```

Sort by:

```text
Highest count first
```

Result:

```text
2
1
0
```

---

# COUNT vs COUNT(DISTINCT)

### COUNT

```sql
COUNT(p.id)
```

Counts:

```text
Every matching row
```

Duplicates included.

---

### COUNT(DISTINCT)

```sql
COUNT(DISTINCT p.id)
```

Counts:

```text
Unique values only
```

Duplicates removed.

---

# Real-World Examples

Unique customers:

```sql
SELECT COUNT(DISTINCT customer_id)
FROM orders;
```

---

Unique products sold:

```sql
SELECT COUNT(DISTINCT product_id)
FROM order_items;
```

---

Unique visitors:

```sql
SELECT COUNT(DISTINCT user_id)
FROM page_views;
```

---

Unique posts per tag:

```sql
SELECT
    tag_name,
    COUNT(DISTINCT post_id)
```

---

# Why COUNT(DISTINCT) Is Important

Without it:

```text
Duplicates inflate numbers.
```

With it:

```text
Statistics remain accurate.
```

This is critical for:

- dashboards
- reporting
- analytics
- KPI calculations

---
