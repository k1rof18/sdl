CREATE DATABASE mydb;

\c mydb;

CREATE TABLE clients (
  client_id UUID PRIMARY KEY
);

CREATE TABLE recruits (
  recruit_id UUID PRIMARY KEY,
  title TEXT NOT NULL,
  client_id UUID NOT NULL REFERENCES clients(client_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE projects (
  project_id UUID REFERENCES recruits(recruit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    PRIMARY KEY
);

CREATE TABLE worker_privates (
  worker_id UUID PRIMARY KEY REFERENCES workers(worker_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  name TEXT NOT NULL,
  birth_date DATE
);

CREATE TABLE worker_profiles (
  worker_id UUID PRIMARY KEY REFERENCES workers(worker_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  selfIntroduction TEXT
);

CREATE TABLE project_applicants (
  project_applicant_id UUID PRIMARY KEY,
  applicant_id UUID REFERENCES workers(worker_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  project_id UUID REFERENCES projects(project_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  estimated_end_date DATE,
  UNIQUE (applicant_id, project_id)
);

-- 以下はサンプルデータ
INSERT INTO clients (client_id) VALUES
('CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('D2BC191E-DB64-46BC-AE16-916A7E53839A');

INSERT INTO recruits (recruit_id, title, client_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'Software Engineer', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'Product Manager', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'Designer', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'Sales', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b', 'Marketing', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a', 'Customer Success', 'CF71705D-DE27-40FE-9181-E190E0A65EB6'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49', 'Finance', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48', 'HR', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47', 'Legal', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46', 'Operations', 'D2BC191E-DB64-46BC-AE16-916A7E53839A'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45', 'Data Scientist', 'D2BC191E-DB64-46BC-AE16-916A7E53839A');

INSERT INTO projects (project_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a');

INSERT INTO projects (project_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45');

INSERT INTO workers (worker_id) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45');

INSERT INTO project_applicants (project_applicant_id, applicant_id, project_id, estimated_end_date) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', '2021-12-31'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', '2021-12-31'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', '2021-12-31'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', '2021-12-31');

INSERT INTO worker_privates (worker_id, name, birth_date) VALUES
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f', 'Alice', '1990-01-01'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4e', 'Bob', '1990-01-02'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d', 'Charlie', '1990-01-03'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4c', 'David', '1990-01-04'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4b', 'Eve', '1990-01-05'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4a', 'Frank', '1990-01-06'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b49', 'Grace', '1990-01-07'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b48', 'Hank', '1990-01-08'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b47', 'Ivy', '1990-01-09'),
('f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b46', 'Jack', '1990-01-10');

-- CREATE TABLE workers (
--   worker_id UUID PRIMARY KEY
-- );

CREATE TABLE users (
	user_id UUID PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE project_status_histories (
  project_id UUID PRIMARY KEY
    REFERENCES projects(project_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage recruit_stage NOT NULL DEFAULT 'apply',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE project_applicant_stage_histories (
  apply_id UUID PRIMARY KEY
    REFERENCES project_applicants(project_applicant_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage recruit_stage NOT NULL DEFAULT 'apply',
  staged_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE recruit_stage AS ENUM ('apply', 'first', 'second');
