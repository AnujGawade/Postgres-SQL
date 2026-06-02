-- TABLE ALAISES

-- alaises is going to make our queries shorter and easier to read

-- posts.title
-- I want to write instead like p.title


-- users.name instead I want u.name

SELECT 
  p.title AS post_title,
  p.status,
  p.views,
  u.name AS author_name,
  c.body AS comment_body
FROM posts AS p
INNER JOIN users AS u
  ON p.user_id = u.id 
LEFT JOIN comments AS c
  ON p.id = c.post_id
ORDER BY p.views DESC;