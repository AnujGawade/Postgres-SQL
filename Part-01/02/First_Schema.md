# PostgreSQL Notes - Schemas & Extensions

## What is a Schema?

A **schema** is like a folder (or namespace) inside a database that helps organize database objects.

It helps you group things like:

- Tables
- Views
- Functions
- Indexes
- Sequences

Think of the structure like this:

```text
Database
   └── Schema
         └── Table
               └── Rows
```

Example:

```text
postgresql_part1
   ├── public
   │     ├── users
   │     └── orders
   │
   └── basics
         ├── customers
         └── products
```

### Default Schemas

PostgreSQL creates some default schemas automatically.

The most common one is:

- `public`

If you create a table without specifying a schema, PostgreSQL places it inside the `public` schema by default.

Example:

```sql
CREATE TABLE users (
    id INT
);
```

This actually becomes:

```sql
public.users
```

---

## Why Use Schemas?

Schemas help with:

- Organizing tables logically
- Separating application modules
- Avoiding naming conflicts
- Managing permissions more easily

Example:

Instead of:

```text
users
admin_users
customer_users
```

You can organize like:

```text
auth.users
admin.users
customer.users
```

---

## Creating Your Own Schema

```sql
CREATE SCHEMA IF NOT EXISTS basics;
```

### What does `IF NOT EXISTS` do?

This prevents PostgreSQL from throwing an error if the schema already exists.

Without it:

```sql
CREATE SCHEMA basics;
```

If the schema already exists, PostgreSQL throws:

```text
ERROR: schema "basics" already exists
```

With:

```sql
CREATE SCHEMA IF NOT EXISTS basics;
```

PostgreSQL safely skips creation.

This is useful in setup scripts that may run multiple times.

---

## What is an Extension?

An **extension** is an add-on package that adds extra functionality to PostgreSQL.

PostgreSQL supports many extensions for:

- UUID generation
- Full-text search
- GIS / geospatial data
- Performance monitoring
- Cryptographic functions

---

## Creating an Extension

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

### What does `pgcrypto` do?

`pgcrypto` provides cryptographic functions.

One common use is generating UUIDs.

Example:

```sql
SELECT gen_random_uuid();
```

Output:

```text
550e8400-e29b-41d4-a716-446655440000
```

---

## Why UUIDs?

UUIDs are often used as primary keys instead of integers.

Example:

Instead of:

```text
1
2
3
4
```

Use:

```text
550e8400-e29b-41d4-a716-446655440000
```

Advantages:

- Globally unique
- Harder to guess
- Better for distributed systems
- Avoid ID collisions across services

---

## What does `IF NOT EXISTS` do here?

Same idea:

```sql
CREATE EXTENSION IF NOT EXISTS pgcrypto;
```

Prevents this error:

```text
ERROR: extension "pgcrypto" already exists
```

---

## How to See All Schemas in Current Database

```sql
SELECT schema_name
FROM information_schema.schemata
ORDER BY schema_name;
```

Example output:

```text
information_schema
pg_catalog
pg_toast
public
basics
```

---

## What is `information_schema.schemata`?

This is a **system view**.

Breaking it down:

- `information_schema` → built-in schema containing metadata
- `schemata` → view listing all schemas

---

## What is a System View?

A **system view** is a built-in read-only view that provides metadata about the database.

It gives information about:

- Databases
- Schemas
- Tables
- Columns
- Constraints
- Users
- Permissions

Example:

```sql
SELECT * FROM information_schema.tables;
```

Shows all tables.

Example:

```sql
SELECT * FROM information_schema.columns;
```

Shows column details.

Think of system views as PostgreSQL’s internal information dashboard.

---

## Useful Alternative Commands

See all schemas in psql:

```sql
\dn
```

See installed extensions:

```sql
\dx
```
