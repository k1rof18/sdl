CREATE DATABASE mydb;

\c mydb;

CREATE TABLE recruits (
  recruit_id UUID PRIMARY KEY,
  title TEXT NOT NULL
);

CREATE TABLE projects (
  recruit_id UUID REFERENCES recruits(recruit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY
);

-- CREATE TABLE comps (
--   recruit_id UUID REFERENCES recruits(recruit_id)
--     ON DELETE CASCADE
--     ON UPDATE CASCADE
--     PRIMARY KEY
-- );

-- 以下はサンプルデータ
INSERT INTO recruits (recruit_id, title) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'Software Engineer'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'Product Manager'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'Designer'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'Sales'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b', 'Marketing'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a', 'Customer Success'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49', 'Finance'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48', 'HR'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47', 'Legal'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46', 'Operations'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45', 'Data Scientist');

INSERT INTO projects (recruit_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a');

-- INSERT INTO comps (recruit_id) VALUES
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46'),
-- ('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45');