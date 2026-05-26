# Creating a New Database

### First Database

> This is only for learning purposes. In real-world production applications, dropping databases casually is not recommended.

Drop the database if it already exists:

```sql
DROP DATABASE IF EXISTS postgresql_part1;
```

Create a new database:

```sql
CREATE DATABASE postgresql_part1;
```

## Running a SQL File in PostgreSQL

Use the following command to run a .sql file:

```Bash
psql -U postgres -d postgres -f DIR_PATH
```

### Explanation

- psql → PostgreSQL command-line tool
- -U postgres → Login as the postgres user
- -d postgres → Connect to the postgres database
- -f DIR_PATH → Execute the SQL file located at the given path

Example:

```bash
psql -U postgres -d postgres -f    C:\Users\Anuj\Desktop\setup.sql
```

## Connecting to PostgreSQL from Terminal

To connect to a specific database:

```Bash
psql -U postgres -d DATABASE_NAME
```

Example:

```bash
psql -U postgres -d postgresql_part1
```

## Avoid Entering Password Every Time

By default, PostgreSQL asks for your password every time you connect.

### Windows CMD

```Bash
set PGPASSWORD=YOUR_PASSWORD
```

### Mac OS

```Bash
export PGPASSWORD=YOUR_PASSWORD
```

## Useful PostgreSQL Commands

### See Current Database

```sql
SELECT current_database();
```

### See Current User

```sql
SELECT current_user;
```

### See Postgres Version

```sql
SELECT version();
```

### See All Databases

```sql
\list
```

OR

```sql
\l
```

### See All Tables in Current Database

```sql
\dt
```

### Turn Off Pager (Useful on Windows)

```sql
\pset pager off
```

### Switch to Another Database

```sql
\c DATABASE_NAME
```

Example:

```sql
\c postgres
```

### Exit PostgreSQL

```sql
\q
```

OR

```sql
exit
```
