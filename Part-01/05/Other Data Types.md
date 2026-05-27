# UUID and JSONB Data Types

PostgreSQL supports advanced data types beyond basic strings and numbers.

In this lesson, we learned:

- `UUID` for globally unique identifiers
- `JSONB` for storing structured JSON data
- extracting JSON values
- filtering JSON data

These are commonly used in modern applications.

Examples:

- user IDs
- event tracking
- analytics
- metadata storage
- flexible schemas

---

## Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.app_events;

CREATE TABLE basics.app_events (

    -- UUID
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    event_name TEXT NOT NULL,

    -- JSONB
    metadata JSONB DEFAULT '{}'::jsonb,

    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO basics.app_events (event_name, metadata)
VALUES
(
    'sign_up',
    '{"browser":"chrome"}'
),
(
    'sign_in',
    '{"user":"sangam"}'
);

SELECT * FROM basics.app_events;

SELECT
    event_name,
    metadata ->> 'browser' AS browser
FROM basics.app_events
WHERE metadata ? 'browser';
```

---

# Dropping Existing Table

```sql
DROP TABLE IF EXISTS basics.app_events;
```

Deletes the table if it already exists.

This helps avoid:

```text
table already exists
```

errors while practicing.

---

# Creating Table

```sql
CREATE TABLE basics.app_events (
```

Creates a new table inside the `basics` schema.

---

# Column Breakdown

## `id UUID PRIMARY KEY DEFAULT gen_random_uuid()`

```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
```

---

### UUID

UUID stands for:

```text
Universally Unique Identifier
```

Example:

```text
550e8400-e29b-41d4-a716-446655440000
```

Unlike integers:

```text
1
2
3
4
```

UUID values are long unique identifiers.

Benefits:

- globally unique
- safer for distributed systems
- harder to guess
- better for public APIs

Example:

Bad:

```text
/api/users/1
/api/users/2
```

Easy to predict.

Better:

```text
/api/users/550e8400-e29b-41d4-a716-446655440000
```

Hard to guess.

---

### `gen_random_uuid()`

```sql
DEFAULT gen_random_uuid()
```

Automatically generates a UUID.

So when inserting:

```sql
INSERT INTO basics.app_events (event_name)
VALUES ('sign_up');
```

PostgreSQL creates:

```text
id = random UUID
```

automatically.

---

### PRIMARY KEY

Means:

- unique identifier
- cannot be NULL
- no duplicate values

---

# `event_name TEXT NOT NULL`

```sql
event_name TEXT NOT NULL
```

Stores event names.

Examples:

```text
sign_up
sign_in
purchase
logout
```

`NOT NULL` means the event must have a name.

Invalid:

```text
NULL
```

---

# `metadata JSONB DEFAULT '{}'::jsonb`

```sql
metadata JSONB DEFAULT '{}'::jsonb
```

---

## JSONB

`JSONB` stores JSON data in PostgreSQL.

Example:

```json
{
  "browser": "chrome"
}
```

or:

```json
{
  "user": "sangam",
  "device": "mobile"
}
```

Useful when data structure changes often.

Examples:

- event metadata
- user preferences
- analytics payloads
- API responses

---

### Why JSONB instead of TEXT?

TEXT:

```text
"{browser: chrome}"
```

Just plain text.

PostgreSQL cannot query inside it easily.

JSONB:

Structured JSON.

PostgreSQL understands it.

You can:

- search keys
- extract values
- filter JSON fields
- index JSON data

---

## Default Empty JSON

```sql
DEFAULT '{}'::jsonb
```

`{}` means empty JSON object.

Example:

```json
{}
```

`::jsonb` means convert it into JSONB type.

So if metadata is omitted:

```sql
INSERT INTO basics.app_events (event_name)
VALUES ('logout');
```

Stored:

```json
{}
```

instead of NULL.

---

# `created_at TIMESTAMP DEFAULT NOW()`

Stores event creation time.

Automatically filled using:

```sql
NOW()
```

Example:

```text
2026-05-27 11:45:22
```

---

# Inserting Data

```sql
INSERT INTO basics.app_events (event_name, metadata)
VALUES
(
    'sign_up',
    '{"browser":"chrome"}'
),
(
    'sign_in',
    '{"user":"sangam"}'
);
```

This inserts multiple rows.

---

## Row 1

```sql
(
    'sign_up',
    '{"browser":"chrome"}'
)
```

Stored as:

```json
event_name: sign_up
metadata: {
  "browser": "chrome"
}
```

---

## Row 2

```sql
(
    'sign_in',
    '{"user":"sangam"}'
)
```

Stored as:

```json
event_name: sign_in
metadata: {
  "user": "sangam"
}
```

UUID and timestamp are auto-generated.

---

# Selecting All Data

```sql
SELECT * FROM basics.app_events;
```

Returns:

```text
id
event_name
metadata
created_at
```

Example:

```text
550e8400... | sign_up | {"browser":"chrome"} | 2026-05-27
```

---

# Extracting JSON Values

```sql
SELECT
    event_name,
    metadata ->> 'browser' AS browser
FROM basics.app_events;
```

---

## `->>`

This extracts a JSON value as text.

Example:

JSON:

```json
{
  "browser": "chrome"
}
```

Query:

```sql
metadata ->> 'browser'
```

Result:

```text
chrome
```

---

### Difference between `->` and `->>`

`->`

Returns JSON

Example:

```json
"chrome"
```

`->>`

Returns plain text

Example:

```text
chrome
```

Use:

- `->` when working with JSON
- `->>` when you need plain values

---

# Filtering JSON Data

```sql
WHERE metadata ? 'browser'
```

`?` checks whether a key exists.

Meaning:

Does metadata contain:

```text
browser
```

Example:

This matches:

```json
{
  "browser": "chrome"
}
```

This does NOT match:

```json
{
  "user": "sangam"
}
```

So result:

```text
Only rows containing browser key
```

---

# Final Query Result

```sql
SELECT
    event_name,
    metadata ->> 'browser' AS browser
FROM basics.app_events
WHERE metadata ? 'browser';
```

Output:

```text
sign_up | chrome
```

Because only `sign_up` has:

```json
browser
```

---

# Key Concepts Learned

In this lesson you learned:

- UUID
- `gen_random_uuid()`
- JSONB
- default JSON values
- inserting JSON data
- querying JSON
- `->`
- `->>`
- JSON key existence check (`?`)
- filtering JSON data
- advanced PostgreSQL data types
