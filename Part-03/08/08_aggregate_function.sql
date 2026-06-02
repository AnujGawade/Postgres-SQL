
-- Calculate one result from many rows
-- COUNT() --> Number of rows
-- SUM() --> Total Value
-- AVG() --> Average Value
-- MIN() --> Smallest Value
-- MAX() --> Largest/Max Value

-- Admin Dashboard, reports, analytics, admin Panels

-- Count Rows from the Posts table
SELECT COUNT(*) AS total_posts
FROM posts;

-- Count how many rows has status published
SELECT 
    COUNT(*) AS total_posts,
    COUNT(*) FILTER (WHERE status = 'published') AS published
FROM posts AS p;

-- Sum of all views of all rows
SELECT 
    COUNT(*) AS total_posts,
    COUNT(*) FILTER (WHERE status = 'published') AS published,
    SUM(views) AS total_views,
    AVG(views) AS avg_views,
    MIN(views) AS lowest_views,
    MAX(views) AS highest_views
FROM posts AS p;

