# PostgreSQL Learning Journey

A hands-on PostgreSQL learning repository containing SQL scripts, experiments, and notes as I build database fundamentals.

## Overview

This repository documents my practical PostgreSQL learning through structured modules and exercises.

Topics include:

- PostgreSQL setup
- Database creation
- Schemas
- Data types
- Table creation
- Constraints
- CRUD operations
- Relationships
- Joins
- Indexes
- Functions
- Views
- Transactions
- Triggers
- Performance optimization

---

## Repository Structure

```text
PostgreSQL/
│
├── Part-01/
│   ├── 01/
│   │   ├── 01_first_database.sql
│   │
│   ├── 02/
│   │   ├── 02_first_schema.sql
│   │
│   └── ...
│
├── Part-02/
│   ├── 01/
│   └── ...
│
└── README.md
```

---

## Running SQL Files

Execute SQL files using `psql`:

```bash
psql -U postgres -d postgres -f Part-01/01/01_first_database.sql
```

Example:

```bash
psql -U postgres -d postgres -f Part-01/02/02_first_schema.sql
```

---

## Learning Progress

### Part 01 — PostgreSQL Basics
- [x] PostgreSQL installation
- [x] `psql` setup
- [x] First database creation
- [x] Schema creation
- [ ] Table creation
- [ ] Data types
- [ ] Constraints

### Upcoming
- [ ] Relationships
- [ ] Joins
- [ ] Aggregate functions
- [ ] Indexes
- [ ] Views
- [ ] Transactions
- [ ] Functions
- [ ] Stored procedures
- [ ] Triggers
- [ ] Performance tuning

---

## Requirements

Make sure you have:

- PostgreSQL installed
- `psql` added to PATH
- Git installed

Check installation:

```bash
psql --version
git --version
```

---

## Purpose

This repository helps me:

- Practice PostgreSQL consistently
- Track learning progress
- Build strong SQL/database fundamentals
- Maintain reusable SQL examples
- Create a future backend reference

---

## Notes

This is a personal learning repository, so scripts may evolve as concepts improve.
