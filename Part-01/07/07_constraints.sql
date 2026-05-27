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