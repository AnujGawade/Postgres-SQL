# NULL vs Empty String vs Zero

These values may appear similar, but in PostgreSQL they mean completely different things.

Understanding this difference is important because querying them works differently.

---

## Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.value_examples;

CREATE TABLE basics.value_examples (

    id SERIAL PRIMARY KEY,

    nickname TEXT,

    bio TEXT,

    score INTEGER
);

INSERT INTO basics.value_examples (nickname, bio, score)
VALUES
    (NULL, 'learning postgres', 10),
    ('', 'empty nickname', 20),
    ('sangam', '', 0),
    ('john', NULL, NULL);

SELECT * FROM basics.value_examples;

SELECT * FROM basics.value_examples
WHERE nickname IS NULL;

SELECT * FROM basics.value_examples
WHERE nickname = '';

SELECT * FROM basics.value_examples
WHERE score = 0;
```

---

# Understanding the Values

## NULL

```text
NULL = unknown / missing / no value
```

Means:

- value was not provided
- value is missing
- database does not know the value

Example:

```sql
(NULL, 'learning postgres', 10)
```

Stored:

```text
nickname → NULL
```

This does NOT mean empty text.

It means:

**No known value exists.**

---

## Empty String

```text
'' = known string with zero characters
```

Means:

The value exists, but contains nothing.

Example:

```sql
('', 'empty nickname', 20)
```

Stored:

```text
nickname → ''
```

This is NOT NULL.

Because PostgreSQL knows the value.

The value just happens to be empty.

---

## Zero

```text
0 = actual numeric value
```

Means:

A real number.

Example:

```sql
('sangam', '', 0)
```

Stored:

```text
score → 0
```

This does NOT mean missing.

It means:

The score is exactly zero.

---

# Table Structure

```sql
CREATE TABLE basics.value_examples (
    id SERIAL PRIMARY KEY,
    nickname TEXT,
    bio TEXT,
    score INTEGER
);
```

Columns:

- `id` → auto-generated ID
- `nickname` → text value
- `bio` → text value
- `score` → numeric integer

No `NOT NULL` constraints were added.

So NULL values are allowed.

---

# Inserted Data

```sql
INSERT INTO basics.value_examples (nickname, bio, score)
VALUES
    (NULL, 'learning postgres', 10),
    ('', 'empty nickname', 20),
    ('sangam', '', 0),
    ('john', NULL, NULL);
```

Inserted rows:

| nickname | bio               | score |
| -------- | ----------------- | ----- |
| NULL     | learning postgres | 10    |
| ''       | empty nickname    | 20    |
| sangam   | ''                | 0     |
| john     | NULL              | NULL  |

---

# Querying All Data

```sql
SELECT * FROM basics.value_examples;
```

Returns every row.

---

# Finding NULL Values

```sql
SELECT * FROM basics.value_examples
WHERE nickname IS NULL;
```

Important:

NULL cannot be checked using:

```sql
nickname = NULL
```

Wrong ❌

Because NULL means unknown.

Correct:

```sql
IS NULL
```

This returns:

```text
nickname = NULL rows
```

Result:

```text
(NULL, 'learning postgres', 10)
```

---

# Finding Empty String Values

To find empty strings:

```sql
SELECT * FROM basics.value_examples
WHERE nickname = '';
```

Your original query:

```sql
WHERE nickname IS unknown;
```

This is incorrect.

Because empty string is NOT unknown.

Empty string is a known value:

```text
''
```

Correct query:

```sql
WHERE nickname = '';
```

Result:

```text
('', 'empty nickname', 20)
```

---

# Finding Zero Values

```sql
SELECT * FROM basics.value_examples
WHERE score = 0;
```

This finds rows where score is exactly zero.

Result:

```text
('sangam', '', 0)
```

---

# Query Comparison

Find NULL:

```sql
WHERE nickname IS NULL
```

Find empty string:

```sql
WHERE nickname = ''
```

Find zero:

```sql
WHERE score = 0
```

Different values → different query syntax.

---

# Why This Matters

Mistaking these values causes bugs.

Example:

User profile:

- bio = NULL → user never added bio
- bio = '' → user cleared bio
- score = 0 → real score value

Same-looking "empty" values, different meanings.

---

# Key Concepts Learned

In this lesson you learned:

- NULL values
- empty strings
- numeric zero
- querying NULL with `IS NULL`
- querying empty strings
- querying numeric values
- difference between unknown and empty values
