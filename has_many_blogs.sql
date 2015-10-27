-- must be connected to another database and user to create/ drop desired ones;
\c franpham franpham;

DROP DATABASE IF EXISTS demo_blogs;

DROP USER IF EXISTS blog_user;

CREATE USER blog_user WITH ENCRYPTED PASSWORD 'ImBlogging';

CREATE DATABASE demo_blogs OWNER blog_user;

\c demo_blogs blog_user localhost 5432;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(90) NOT NULL,
  first_name VARCHAR(90),
  last_name VARCHAR(90),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()

);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(180),
  url VARCHAR(510),
  "content" TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  users_id INTEGER REFERENCES users
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  body VARCHAR(510),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  posts_id INTEGER REFERENCES posts,
  users_id INTEGER REFERENCES users
);

-- INDEXES ARE DROPPED WHEN DATABASE IS DROPPED;
CREATE INDEX username_usersIndex ON users (username);
CREATE INDEX title_postsIndex ON posts (title);
CREATE INDEX content_postsIndex ON posts USING gin(to_tsvector('english'::regconfig, "content"));
CREATE INDEX body_cmntsIndex ON comments USING gin(to_tsvector('english'::regconfig, body));
