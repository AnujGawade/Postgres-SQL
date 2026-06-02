-- INDEXES

-- index helps postgres find rows faster
-- Now let's say we have 1,000 data and we have find something.
-- So Normally Postgres is going to scan all the rows to find the matching data. 
-- But in case of index, it directly jumps closer to the data it needs.
-- In simple terms, In our Normal Book there is a Index page right at the beginning. Which helps us to find particular page or topic without reading or searching for all the pages in the book.
-- Similarly, whenver a database has a index, it helps to find the rows without checking the rest of the data.

SELECT 
    id, 
    title,
    status,
    user_id,
    views
FROM posts;

-- /posts?status=published

SELECT 
    id, 
    title,
    status
FROM posts
WHERE status = 'published';

-- idx_posts_status
-- idx --> index, posts --> table, status --> column 
CREATE INDEX IF NOT EXISTS idx_posts_status
ON posts(status);

SELECT 
    title, 
    status,
    views
FROM posts
WHERE status = 'published'
ORDER BY views DESC;

-- composite index
CREATE INDEX IF NOT EXISTS idx_posts_status_views
ON posts(status, views DESC);

-- /users/:id/posts

SELECT 
    title,
    status,
    views
FROM posts
WHERE user_id = (
    SELECT id
    FROM users
    WHERE name = 'rahul'
);

CREATE INDEX IF NOT EXISTS idx_posts_user_id
ON posts(user_id);