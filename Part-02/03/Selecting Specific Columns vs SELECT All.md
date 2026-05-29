# Selecting Specific Columns vs `SELECT *`

In PostgreSQL, `SELECT` is used to retrieve data from a table.

There are two common ways:

- `SELECT *`
- selecting only required columns

Choosing the correct approach is important for performance and readability.

---

# Why Avoid `SELECT *` in Real Applications

`SELECT *` returns every column from the table.

Example:

```sql
SELECT * FROM products;
```

This works fine for small learning projects.

But in real-world applications:

- tables can have many columns
- some columns may contain large data
- fetching unnecessary data slows applications
- APIs become inefficient

Imagine a production table with:

```text
100+
500+
1000+ columns
```

If your frontend only needs:

```text
name
price
```

then fetching everything is wasteful.

---

# Select All Example

```sql
SELECT * FROM products;
```

Meaning:

```text
Return all columns from the products table
```

Example output:

| id  | name         | category    | price | stock | sku           | description              |
| --- | ------------ | ----------- | ----- | ----- | ------------- | ------------------------ |
| 1   | Laptop Stand | electronics | 5000  | 23    | ELEC-IP15-002 | Laptop stand description |

---

# Selecting Specific Columns

Instead of fetching everything:

```sql
SELECT name, price
FROM products;
```

This returns only required data.

Example output:

| name         | price |
| ------------ | ----- |
| Laptop Stand | 5000  |

Benefits:

- faster queries
- less memory usage
- cleaner API responses
- better performance

---

# Using Aliases with `AS`

Aliases rename column names in query output.

Syntax:

```sql
column_name AS alias_name
```

---

# Complete Example

```sql
SELECT
    name AS product_name,
    price AS selling_price,
    stock AS available_quantity
FROM products;
```

---

# Understanding Aliases

## `name AS product_name`

```sql
name AS product_name
```

Original column:

```text
name
```

Output becomes:

```text
product_name
```

---

## `price AS selling_price`

```sql
price AS selling_price
```

Output column:

```text
selling_price
```

Makes the result more readable.

---

## `stock AS available_quantity`

```sql
stock AS available_quantity
```

Output column:

```text
available_quantity
```

More descriptive than just:

```text
stock
```

---

# Example Output

| product_name | selling_price | available_quantity |
| ------------ | ------------- | ------------------ |
| Laptop Stand | 5000.00       | 23                 |

Notice:

Database column names remain unchanged.

Only query output changes.

---

# Why Aliases Are Useful

Aliases improve:

- readability
- frontend API naming
- report generation
- analytics queries

Example:

Without alias:

```text
price
```

With alias:

```text
selling_price
```

Much clearer in business applications.

---

# Important Syntax Fix

Your original query missed commas.

Wrong:

```sql
SELECT
    name AS product_name
    price AS selling_price
```

Correct:

```sql
SELECT
    name AS product_name,
    price AS selling_price
```

Each selected column must be separated by commas.

---

# Best Practice

Prefer:

```sql
SELECT name, price
FROM products;
```

Instead of:

```sql
SELECT *
FROM products;
```

Especially in:

- production applications
- APIs
- dashboards
- large databases

---
