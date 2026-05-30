# UPDATE with Calculations and Bulk Updates

The `UPDATE` statement can do much more than simply replace values.

It can:

- update multiple rows at once
- perform calculations
- update values based on existing data
- automate business rules

In this lesson, we learned how to:

- increase prices by a percentage
- update all matching records
- deactivate products based on stock quantity

---

# Complete SQL for This Lesson

```sql
-- Check existing data

SELECT
    name,
    category,
    price,
    is_active
FROM products
WHERE category = 'Accessories';

-- Increase accessory prices by 10%

UPDATE products
SET price = ROUND(price * 1.10, 2)
WHERE category = 'Accessories';

-- Verify changes

SELECT
    name,
    category,
    price,
    is_active
FROM products
WHERE category = 'Accessories';

-- Deactivate out-of-stock products

UPDATE products
SET is_active = FALSE
WHERE stock = 0;
```

---

# Step 1: Verify Existing Data

```sql
SELECT
    name,
    category,
    price,
    is_active
FROM products
WHERE category = 'Accessories';
```

Before updating data, it's a good practice to inspect the records.

This helps:

- confirm matching rows exist
- see current values
- avoid accidental updates

---

# Example Result

| name      | category    | price |
| --------- | ----------- | ----- |
| USB Cable | Accessories | 500   |
| Charger   | Accessories | 1000  |

---

# Step 2: Increase Prices by 10%

```sql
UPDATE products
SET price = ROUND(price * 1.10, 2)
WHERE category = 'Accessories';
```

---

# Understanding the Formula

```sql
price * 1.10
```

Means:

```text
Current Price + 10%
```

---

## Example

Current price:

```text
1000
```

Calculation:

```text
1000 × 1.10
=
1100
```

New price:

```text
1100
```

---

Another example:

```text
500 × 1.10
=
550
```

---

# Why ROUND()?

```sql
ROUND(price * 1.10, 2)
```

Syntax:

```sql
ROUND(number, decimal_places)
```

---

## Example

Without rounding:

```text
1100.456789
```

With:

```sql
ROUND(value, 2)
```

Result:

```text
1100.46
```

Perfect for:

- prices
- money
- invoices
- financial calculations

---

# Bulk Update

Notice:

```sql
WHERE category = 'Accessories'
```

This updates:

```text
ALL accessory products
```

not just one row.

This is called:

```text
Bulk Update
```

---

# Example Before Update

| name      | price |
| --------- | ----- |
| USB Cable | 500   |
| Charger   | 1000  |

---

# Example After Update

| name      | price |
| --------- | ----- |
| USB Cable | 550   |
| Charger   | 1100  |

Every matching row was updated.

---

# Step 3: Verify Updated Data

```sql
SELECT
    name,
    category,
    price,
    is_active
FROM products
WHERE category = 'Accessories';
```

Purpose:

```text
Verify changes were applied correctly.
```

---

# Step 4: Deactivate Out-of-Stock Products

```sql
UPDATE products
SET is_active = FALSE
WHERE stock = 0;
```

---

# Understanding the Query

Condition:

```sql
WHERE stock = 0
```

Meaning:

```text
Find products with no inventory.
```

Then:

```sql
SET is_active = FALSE
```

Meaning:

```text
Mark those products as inactive.
```

---

# Example Before Update

| name     | stock | is_active |
| -------- | ----- | --------- |
| Laptop   | 10    | true      |
| Mouse    | 0     | true      |
| Keyboard | 0     | true      |

---

# Example After Update

| name     | stock | is_active |
| -------- | ----- | --------- |
| Laptop   | 10    | true      |
| Mouse    | 0     | false     |
| Keyboard | 0     | false     |

---

# Real-World Business Logic

This is a common e-commerce rule:

```text
If stock reaches zero,
hide the product from customers.
```

Instead of manually updating each product:

```sql
UPDATE products
SET is_active = FALSE
WHERE stock = 0;
```

One query handles everything.

---

# UPDATE Using Existing Values

A powerful feature of SQL is:

```sql
SET price = price * 1.10
```

Notice:

```text
New value depends on old value.
```

PostgreSQL reads the existing value and calculates a new one.

This is very common for:

- discounts
- tax calculations
- salary increases
- inventory adjustments
- reward points

---

# Real Examples

Apply 20% discount:

```sql
UPDATE products
SET price = ROUND(price * 0.80, 2);
```

---

Increase salary by 5%:

```sql
UPDATE employees
SET salary = salary * 1.05;
```

---

Reduce stock by 1:

```sql
UPDATE products
SET stock = stock - 1
WHERE id = 10;
```

---
