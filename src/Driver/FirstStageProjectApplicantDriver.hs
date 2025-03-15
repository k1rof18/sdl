{-# LANGUAGE OverloadedStrings #-}

module Driver.FirstStageProjectApplicantDriver where

import Data.Time.Calendar (Day)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data FirstStageProjectApplicantEntity = FirstStageProjectApplicantEntity
  { project_applicant_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID,
    estimated_end_date :: Day,
    name :: String,
    birth_date :: Day
  }
  deriving (Show)

instance FromRow FirstStageProjectApplicantEntity where
  fromRow = FirstStageProjectApplicantEntity <$> field <*> field <*> field <*> field <*> field <*> field

list :: String -> String -> IO [FirstStageProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.project_applicant_id, pw.applicant_id, pw.project_id, pw.estimated_end_date, wp.name, wp.birth_date \
    \ FROM project_applicants pw \
    \ INNER JOIN first_stage_project_applicants fspa ON pw.project_applicant_id = fspa.project_applicant_id \
    \ INNER JOIN recruits r ON r.recruit_id = pw.project_id \
    \ INNER JOIN worker_privates wp ON wp.worker_id = pw.applicant_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO
      [FirstStageProjectApplicantEntity]
