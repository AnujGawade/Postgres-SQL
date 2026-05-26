# First Table

A table always belongs inside a schema.

In this example, the `students` table will be created inside the `basics` schema.

> This is only for learning purposes. In real-world production applications, dropping tables casually is not recommended.

---

## Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.students;

CREATE TABLE basics.students (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    age INTEGER CHECK (age >= 18),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO basics.students (name, email, age)
VALUES
    ('Anuj', 'anuj@example.com', 24),
    ('Rahul', 'rahul@example.com', 22),
    ('Priya', 'priya@example.com', 26),
    ('Sneha', 'sneha@example.com', 21),
    ('Amit', 'amit@example.com', 28);
```

---

## Dropping an Existing Table

```sql
DROP TABLE IF EXISTS basics.students;
```

This means:

- `DROP TABLE` → delete a table
- `IF EXISTS` → only delete it if the table already exists (prevents errors)
- `basics.students` → the `students` table inside the `basics` schema

In simple terms:

**Delete the `students` table from the `basics` schema if it exists.**

---

## Creating Table

```sql
CREATE TABLE basics.students (

    -- Auto-incrementing integer
    -- 1 → 2 → 3 → ...
    -- Primary key uniquely identifies each row
    id SERIAL PRIMARY KEY,

    -- String/text data
    -- Required field
    -- PostgreSQL will reject rows without a name
    name TEXT NOT NULL,

    -- Email must be unique
    -- No two students can have the same email
    email TEXT NOT NULL UNIQUE,

    -- Only allow students age 18 or above
    age INTEGER CHECK (age >= 18),

    -- Automatically stores creation timestamp
    created_at TIMESTAMP DEFAULT NOW()

);
```

---

## Column Breakdown

### `id SERIAL PRIMARY KEY`

- `SERIAL` creates an auto-incrementing integer
- Values are generated automatically

Example:

```text
1
2
3
4
```

`PRIMARY KEY` means:

- Each row must have a unique ID
- Cannot be NULL
- Used to identify records uniquely

---

### `name TEXT NOT NULL`

- `TEXT` stores string values
- `NOT NULL` makes the field mandatory

Valid:

```text
Anuj
Rahul
Priya
```

Invalid:

```text
NULL
```

PostgreSQL rejects rows where `name` is missing.

---

### `email TEXT NOT NULL UNIQUE`

- Stores email addresses
- Required field
- `UNIQUE` prevents duplicate values

Valid:

```text
anuj@gmail.com
rahul@gmail.com
```

Invalid:

```text
anuj@gmail.com
anuj@gmail.com
```

PostgreSQL will reject duplicate emails.

---

### `age INTEGER CHECK (age >= 18)`

- Stores numeric age
- `CHECK` enforces validation rules

Allowed:

```text
18
21
30
```

Rejected:

```text
16
12
```

Because the condition requires:

```sql
age >= 18
```

This ensures only valid data enters the table.

---

### `created_at TIMESTAMP DEFAULT NOW()`

Stores when the row was created.

`NOW()` automatically inserts the current timestamp.

Example:

```text
2026-05-26 21:15:43
```

So you don't need to manually provide it.

---

## Inserting Data into Table

Once the table is created, records can be inserted using `INSERT INTO`.

```sql
INSERT INTO basics.students (name, email, age)
VALUES
    ('Anuj', 'anuj@example.com', 24),
    ('Rahul', 'rahul@example.com', 22),
    ('Priya', 'priya@example.com', 26),
    ('Sneha', 'sneha@example.com', 21),
    ('Amit', 'amit@example.com', 28);
```

---

## Understanding INSERT INTO

### `INSERT INTO basics.students`

This tells PostgreSQL:

**Insert new data into the `students` table inside the `basics` schema.**

---

### `(name, email, age)`

Specifies which columns will receive values.

```sql
(name, email, age)
```

This means:

- first value → `name`
- second value → `email`
- third value → `age`

Notice we did NOT include:

- `id`
- `created_at`

Because PostgreSQL handles them automatically.

---

### `VALUES`

Contains the actual data to insert.

Single row:

```sql
VALUES ('Anuj', 'anuj@example.com', 24);
```

Multiple rows:

```sql
VALUES
    ('Anuj', 'anuj@example.com', 24),
    ('Rahul', 'rahul@example.com', 22),
    ('Priya', 'priya@example.com', 26);
```

This is called **bulk insert**.

It is faster than inserting one row at a time.

---

## What Happens Automatically?

For this row:

```sql
('Anuj', 'anuj@example.com', 24)
```

PostgreSQL creates:

```text
id         → 1
name       → Anuj
email      → anuj@example.com
age        → 24
created_at → current timestamp
```

Next row:

```text
id → 2
```

Then:

```text
id → 3
```

And so on.

---

## Viewing Inserted Data

To see all records:

```sql
SELECT * FROM basics.students;
```

Example output:

```text
 id | name  |       email         | age |      created_at
----+-------+---------------------+-----+-------------------------
 1  | Anuj  | anuj@example.com    | 24  | 2026-05-26 21:15:43
 2  | Rahul | rahul@example.com   | 22  | 2026-05-26 21:15:43
```

---

## Why Use Constraints?

Constraints help keep data clean and reliable.

Examples:

- No missing names
- No duplicate emails
- No underage students
- Every row has a unique identifier
- Automatic timestamps

Without constraints, bad data can easily enter the database.

---

## Key Concepts Learned

In this lesson you learned:

- Creating tables
- Defining columns
- Data types
- Primary keys
- Auto-incrementing IDs
- Required fields (`NOT NULL`)
- Unique values (`UNIQUE`)
- Validation rules (`CHECK`)
- Default values (`DEFAULT`)
- Inserting records
- Bulk inserting multiple rows
- Querying data with `SELECT`
