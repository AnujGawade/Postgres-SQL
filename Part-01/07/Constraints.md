# Database Constraints

Constraints are rules applied at the database level to protect data integrity.

Even if your backend performs validations, database constraints are still essential.

> Backend validations are good, but database constraints are stronger because they directly protect the data at the database level.

Why?

Because backend code can fail, bugs can happen, APIs can be bypassed, but the database will still enforce its rules.

---

## Constraints Learned

In this lesson:

- `NOT NULL`
- `UNIQUE`
- `DEFAULT`
- `CHECK`
- `PRIMARY KEY`

---

## Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.accounts;

CREATE TABLE basics.accounts (

    id SERIAL PRIMARY KEY,

    full_name TEXT NOT NULL,

    email TEXT NOT NULL UNIQUE,

    is_active BOOLEAN DEFAULT true,

    age INTEGER CHECK (age >= 18),

    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO basics.accounts (email, age)
VALUES ('missing@gmail.com', 19);

-- This fails because full_name is required

INSERT INTO basics.accounts (full_name, email, age)
VALUES ('anuj gawade', 'anuj@gmail.com', 19);

SELECT * FROM basics.accounts;
```

---

# Table Structure

```sql
CREATE TABLE basics.accounts (
```

Creates a new table inside the `basics` schema.

Columns:

- id
- full_name
- email
- is_active
- age
- created_at

---

# Constraint Breakdown

## PRIMARY KEY

```sql
id SERIAL PRIMARY KEY
```

Combines:

- `SERIAL`
- `PRIMARY KEY`

### SERIAL

Auto-generates:

```text
1
2
3
4
```

Automatically increments for each new row.

---

### PRIMARY KEY

Rules:

- unique
- cannot be NULL
- identifies each row

Example:

Valid:

```text
1
2
3
```

Invalid:

```text
1
1
NULL
```

---

# NOT NULL

```sql
full_name TEXT NOT NULL
```

Meaning:

This field is required.

Database rejects inserts where:

```text
full_name = NULL
```

Example:

Wrong:

```sql
INSERT INTO basics.accounts (email, age)
VALUES ('missing@gmail.com', 19);
```

Why?

Because:

```text
full_name
```

was not provided.

PostgreSQL error:

```text
ERROR: null value in column "full_name" violates not-null constraint
```

Meaning:

Database refused to save incomplete data.

---

# UNIQUE

```sql
email TEXT NOT NULL UNIQUE
```

Rules:

- email must exist
- no duplicates allowed

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

Second insert fails.

Why?

Because duplicate emails can cause identity conflicts.

Common use cases:

- email
- username
- phone number
- external IDs

---

# DEFAULT

```sql
is_active BOOLEAN DEFAULT true
```

Meaning:

If no value is provided:

```text
true
```

is inserted automatically.

Example:

```sql
INSERT INTO basics.accounts (full_name, email, age)
VALUES ('Anuj', 'anuj@gmail.com', 19);
```

Stored:

```text
is_active = true
```

Automatically.

---

Another example:

```sql
created_at TIMESTAMP DEFAULT NOW()
```

If omitted:

Current timestamp is inserted automatically.

Example:

```text
2026-05-27 22:15:30
```

---

# CHECK

```sql
age INTEGER CHECK (age >= 18)
```

Rule:

Age must be:

```text
18 or greater
```

Valid:

```text
18
21
45
```

Invalid:

```text
15
10
17
```

Example:

Wrong:

```sql
INSERT INTO basics.accounts (full_name, email, age)
VALUES ('Rahul', 'rahul@gmail.com', 15);
```

Database rejects it.

Why?

Because:

```sql
age >= 18
```

must be true.

---

# Testing Constraint Failure

Example query:

```sql
INSERT INTO basics.accounts (email, age)
VALUES ('missing@gmail.com', 19);
```

Fails because:

```text
full_name
```

is required.

Error:

```text
ERROR: null value in column "full_name" violates not-null constraint
```

This is expected behavior.

Database protection working correctly.

---

# Successful Insert

```sql
INSERT INTO basics.accounts (full_name, email, age)
VALUES ('anuj gawade', 'anuj@gmail.com', 19);
```

This succeeds because:

- full_name exists
- email exists
- email is unique
- age >= 18
- defaults handle remaining fields

Generated automatically:

```text
id
is_active
created_at
```

---

# View Data

```sql
SELECT * FROM basics.accounts;
```

Example output:

```text
id | full_name   | email            | is_active | age | created_at
---+-------------+------------------+-----------+-----+-------------------
1  | anuj gawade | anuj@gmail.com   | true      | 19  | 2026-05-27 ...
```

---

# Why Constraints Matter

Without constraints:

Problems:

- missing names
- duplicate emails
- invalid ages
- bad production data
- inconsistent records

Backend validation helps.

But database constraints are final protection.

Think:

Backend = security guard at entrance

Database constraints = vault lock

Even if someone gets past backend validation:

Database still protects the data.

---
