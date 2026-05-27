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