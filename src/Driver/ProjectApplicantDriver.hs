{-# LANGUAGE OverloadedStrings #-}

module Driver.ProjectApplicantDriver where

import Data.Time.Calendar (Day)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectApplicantEntity = ProjectApplicantEntity
  { project_applicant_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID,
    estimated_end_date :: Day
  }
  deriving (Show)

instance FromRow ProjectApplicantEntity where
  fromRow = ProjectApplicantEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [ProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.project_applicant_id, pw.applicant_id, pw.project_id, pw.estimated_end_date \
    \ FROM project_applicants pw JOIN recruits r ON r.recruit_id = pw.project_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO [ProjectApplicantEntity]
