# Data Types

Data types define what kind of data a column can store.

Choosing the correct data type helps:

- keep data accurate
- improve performance
- reduce storage usage
- prevent invalid data

In this lesson, we create a `products_basic` table to understand common PostgreSQL data types.

---

## Complete SQL for This Lesson

```sql
DROP TABLE IF EXISTS basics.products_basic;

CREATE TABLE basics.products_basic (

    id SERIAL PRIMARY KEY,

    -- String with max length of 100 characters
    name VARCHAR(100) NOT NULL,

    -- Long text content
    description TEXT,

    -- Whole number
    stock INTEGER DEFAULT 0,

    -- Larger whole number
    total_views BIGINT DEFAULT 0,

    -- Exact decimal values
    -- 10 = total digits
    -- 2 = digits after decimal
    price NUMERIC(10, 2),

    -- true / false
    is_active BOOLEAN DEFAULT true
);

INSERT INTO basics.products_basic
(name, description, stock, total_views, price, is_active)
VALUES
(
    'Product 1',
    'This is product description',
    100,
    1200,
    2455.65,
    true
);

SELECT * FROM basics.products_basic;

SELECT id, name, price, is_active
FROM basics.products_basic
WHERE is_active = true;
```

---

## Dropping Existing Table

```sql
DROP TABLE IF EXISTS basics.products_basic;
```

This means:

- delete the `products_basic` table
- only if it already exists
- avoids errors if the table is missing

---

## Creating Table

```sql
CREATE TABLE basics.products_basic (
```

Creates a new table inside the `basics` schema.

---

# Column Breakdown

## `id SERIAL PRIMARY KEY`

```sql
id SERIAL PRIMARY KEY
```

### `SERIAL`

Creates an auto-incrementing integer.

Example:

```text
1
2
3
4
5
```

Every new row gets the next number automatically.

---

### `PRIMARY KEY`

Means:

- uniquely identifies each row
- cannot be NULL
- no duplicates allowed

---

## `name VARCHAR(100) NOT NULL`

```sql
name VARCHAR(100) NOT NULL
```

### `VARCHAR(100)`

Variable-length string.

Maximum:

```text
100 characters
```

Valid:

```text
Laptop
Wireless Mouse
Gaming Keyboard
```

Invalid:

More than 100 characters.

Use when you know the maximum length.

---

### `NOT NULL`

Means this field is required.

Invalid:

```text
NULL
```

---

## `description TEXT`

```sql
description TEXT
```

Used for long text.

No fixed character limit like `VARCHAR`.

Good for:

- product descriptions
- blog content
- comments
- notes

Example:

```text
High performance gaming laptop with RTX graphics.
```

---

## `stock INTEGER DEFAULT 0`

```sql
stock INTEGER DEFAULT 0
```

### `INTEGER`

Stores whole numbers.

Examples:

```text
0
10
500
9999
```

Used for:

- stock quantity
- age
- count
- order quantity

---

### `DEFAULT 0`

If no value is provided:

PostgreSQL automatically inserts:

```text
0
```

Example:

```sql
INSERT INTO basics.products_basic (name)
VALUES ('Monitor');
```

Stored:

```text
stock = 0
```

---

## `total_views BIGINT DEFAULT 0`

```sql
total_views BIGINT DEFAULT 0
```

### `BIGINT`

Stores much larger whole numbers than INTEGER.

Use when values may become huge.

Example:

```text
1000000
50000000
99999999999
```

Good for:

- view counts
- analytics
- transaction counters

---

## `price NUMERIC(10, 2)`

```sql
price NUMERIC(10, 2)
```

Used for exact decimal numbers.

Perfect for money.

### Meaning:

```sql
NUMERIC(10, 2)
```

- 10 = total digits allowed
- 2 = digits after decimal

Examples:

Valid:

```text
99.99
2455.65
100000.00
```

Invalid:

```text
12345678901.99
```

Because it exceeds allowed digits.

Why not FLOAT?

Because FLOAT can have rounding inaccuracies.

For currency, always prefer:

```sql
NUMERIC
```

---

## `is_active BOOLEAN DEFAULT true`

```sql
is_active BOOLEAN DEFAULT true
```

Stores:

```text
true
false
```

Useful for:

- active/inactive products
- enabled/disabled settings
- published/unpublished records

Default:

```text
true
```

If omitted:

```sql
INSERT INTO basics.products_basic (name)
VALUES ('Laptop');
```

Stored:

```text
is_active = true
```

---

# Inserting Data

```sql
INSERT INTO basics.products_basic
(name, description, stock, total_views, price, is_active)
VALUES
(
    'Product 1',
    'This is product description',
    100,
    1200,
    2455.65,
    true
);
```

This inserts a new row.

Mapping:

```text
name         → Product 1
description  → This is product description
stock        → 100
total_views  → 1200
price        → 2455.65
is_active    → true
```

Auto-generated:

```text
id → 1
```

---

# Selecting Data

## Select All Columns

```sql
SELECT * FROM basics.products_basic;
```

`*` means:

**all columns**

Returns:

```text
id
name
description
stock
total_views
price
is_active
```

---

## Select Specific Columns

```sql
SELECT id, name, price, is_active
FROM basics.products_basic;
```

Returns only selected columns.

Example:

```text
1 | Product 1 | 2455.65 | true
```

More efficient than fetching everything.

---

# Filtering Data

```sql
SELECT id, name, price, is_active
FROM basics.products_basic
WHERE is_active = true;
```

### `WHERE`

Filters rows.

Only returns rows matching the condition.

Condition:

```sql
is_active = true
```

Meaning:

Only show active products.

Example:

If data:

```text
Product A → true
Product B → false
Product C → true
```

Result:

```text
Product A
Product C
```

---

# Key Concepts Learned

In this lesson you learned:

- PostgreSQL data types
- VARCHAR
- TEXT
- INTEGER
- BIGINT
- NUMERIC
- BOOLEAN
- DEFAULT values
- INSERT INTO
- SELECT \*
- Selecting specific columns
- WHERE filtering
- Auto-increment primary keys
