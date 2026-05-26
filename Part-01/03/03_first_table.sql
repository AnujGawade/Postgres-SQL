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