-- LEFT JOIN

-- Left Join keeps all rows from the left table.
-- Meaning it is going to keep all the rows from the left side table and if the right side table has the matching data then postgres is going to include that data.
-- If it doesn't have any matching data it returns null.

-- posts --> left 
-- comments --> right

-- because not every post is going to have comments
-- some posts will have 100 comments and some will have 0

-- Find posts with 0 posts
SELECT
    posts.title AS post_title,
    comments.body AS comment_body
FROM posts
LEFT JOIN comments
    ON posts.id = comments.post_id
ORDER BY post_title;