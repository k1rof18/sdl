CREATE DATABASE mydb;

\c mydb;

CREATE TABLE users (
	user_id UUID PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE recruits (
  recruit_id UUID PRIMARY KEY,
  client_id UUID NOT NULL REFERENCES users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE projects (
  project_id UUID PRIMARY KEY
    REFERENCES recruits(recruit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  title TEXT NOT NULL
);

CREATE TABLE project_applies (
  apply_id UUID PRIMARY KEY,
  applicant_id UUID REFERENCES users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  project_id UUID REFERENCES projects(project_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  budget INT
);

CREATE TABLE project_status_histories (
  project_id UUID
    REFERENCES projects(project_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage RecruitStage NOT NULL DEFAULT 'apply',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE project_applicant_stage_histories (
  apply_id UUID
    REFERENCES project_applies(apply_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage RecruitStage NOT NULL DEFAULT 'apply',
  staged_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE RecruitStage AS ENUM ('apply', 'first', 'second');
