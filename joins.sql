
-- SELECT * FROM users;

SELECT * FROM posts WHERE users_id = 100;

SELECT posts.*, first_name, last_name FROM posts INNER JOIN users ON (users.id = posts.users_id) WHERE users.id = 200;

SELECT posts.*, username FROM posts INNER JOIN users ON (users.id = posts.users_id) WHERE first_name = 'Norene' AND last_name = 'Schmitt';

SELECT username FROM users INNER JOIN posts ON (users.id = posts.users_id) WHERE posts.created_at > '2015-01-01 12:00:00+00';

-- SELECT title, "content", username FROM posts INNER JOIN users ON (users.id = posts.users_id) WHERE users.created_at < '2015-01-01 12:00:00+00';

-- SELECT title AS PostTitle, comments.* FROM comments INNER JOIN posts ON (comments.posts_id = posts.id);

SELECT title AS post_title, url AS post_url, body AS comment_body FROM comments INNER JOIN posts ON (comments.posts_id = posts.id) WHERE posts.created_at < '2015-01-01 12:00:00+00';

SELECT title AS post_title, url AS post_url, body AS comment_body FROM comments INNER JOIN posts ON (comments.posts_id = posts.id) WHERE posts.created_at > '2015-01-01 12:00:00+00';

SELECT title AS post_title, url as post_url, body AS comment_body FROM comments INNER JOIN posts ON (comments.posts_id = posts.id)
  WHERE to_tsvector('english'::regconfig, body) @@ to_tsquery('english'::regconfig, 'USB');

SELECT title AS post_title, first_name, last_name, body AS comment_body FROM comments
  INNER JOIN posts ON (comments.posts_id = posts.id)
  INNER JOIN users ON (comments.users_id = users.id)
  WHERE to_tsvector('english'::regconfig, body) @@ to_tsquery('english'::regconfig, 'matrix');

SELECT first_name, last_name, body AS comment_body FROM comments
  INNER JOIN users ON (comments.users_id = users.id)
  INNER JOIN posts ON (comments.users_id = posts.id)
  -- MUST JOIN posts to do a search on its "content" column;
  WHERE to_tsvector('english'::regconfig, body) @@ to_tsquery('english'::regconfig, 'SSL')
  AND to_tsvector('english'::regconfig, "content") @@ to_tsquery('english'::regconfig, 'dolorum');
