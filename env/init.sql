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

CREATE TYPE RecruitStage AS ENUM ('apply', 'first', 'second');
