-- One query inside another query

-- runs the inner query
-- outer query

-- Which posts are performing better than average

SELECT 
    title,
    status,
    views
FROM posts
WHERE views > (
    SELECT AVG(views) FROM posts
);