-- FOREIGN KEYS
-- Foreign key is a column that points to the primary key of another table.

-- user.id is a primary key of users table but in posts table.
-- posts.user_id is a foreign key
-- Means every post created must belong to an existing user.

SELECT id, name
FROM users;

SELECT id, user_id, title
FROM posts;