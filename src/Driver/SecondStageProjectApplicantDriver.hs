{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.SecondStageProjectApplicantDriver where

import Data.Time.Calendar (Day)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data SecondStageProjectApplicantEntity = SecondStageProjectApplicantEntity
  { project_applicant_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID,
    estimated_end_date :: Day,
    name :: String,
    birth_date :: Day,
    selfintroduction :: String
  }
  deriving (Show)

instance FromRow SecondStageProjectApplicantEntity where
  fromRow = SecondStageProjectApplicantEntity <$> field <*> field <*> field <*> field <*> field <*> field <*> field

list :: String -> String -> IO [SecondStageProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.project_applicant_id, pw.applicant_id, pw.project_id, pw.estimated_end_date, wpri.name, wpri.birth_date, wpro.selfintroduction \
    \ FROM project_applicants pw \
    \ INNER JOIN second_stage_project_applicants fspa ON pw.project_applicant_id = fspa.project_applicant_id \
    \ INNER JOIN recruits r ON r.recruit_id = pw.project_id \
    \ INNER JOIN worker_privates wpri ON wpri.worker_id = pw.applicant_id \
    \ INNER JOIN worker_profiles wpro ON wpro.worker_id = pw.applicant_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO
      [SecondStageProjectApplicantEntity]
