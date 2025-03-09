CREATE DATABASE mydb;

\c mydb;

CREATE TABLE recruits (
  recruit_id UUID PRIMARY KEY,
  title TEXT NOT NULL
);

-- 以下はサンプルデータ
INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'Software Engineer');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'Product Manager');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'Designer');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'Sales');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b', 'Marketing');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a', 'Customer Success');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49', 'Finance');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48', 'HR');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47', 'Legal');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46', 'Operations');

INSERT INTO recruits (recruit_id, title)
VALUES ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45', 'Data Scientist');