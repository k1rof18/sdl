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

CREATE TABLE project_applicants (
  project_applicant_id UUID PRIMARY KEY,
  applicant_id UUID REFERENCES users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  project_id UUID REFERENCES projects(project_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  estimated_end_date DATE,
  UNIQUE (applicant_id, project_id)
);

------------------------------------------------------

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
