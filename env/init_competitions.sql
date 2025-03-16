CREATE TABLE competitions (
  competition_id UUID PRIMARY KEY
    REFERENCES recruits(recruit_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  title TEXT NOT NULL
);

CREATE TABLE competition_applies (
  apply_id UUID PRIMARY KEY,
  applicant_id UUID REFERENCES users(user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  competition_id UUID REFERENCES competitions(competition_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  file_path TEXT NOT NULL
);

CREATE TABLE competition_status_histories (
  competition_id UUID
    REFERENCES competitions(competition_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage RecruitStage NOT NULL DEFAULT 'apply',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE competition_applicant_stage_histories (
  apply_id UUID
    REFERENCES competition_applies(apply_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  stage RecruitStage NOT NULL DEFAULT 'apply',
  staged_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
