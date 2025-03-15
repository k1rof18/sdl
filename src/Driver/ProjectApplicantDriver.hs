{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.ProjectApplicantDriver where

import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectApplicantEntity = ProjectApplicantEntity
  { apply_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID
  }
  deriving (Show)

instance FromRow ProjectApplicantEntity where
  fromRow = ProjectApplicantEntity <$> field <*> field <*> field

list :: String -> String -> IO [ProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.apply_id, pw.applicant_id, pw.project_id \
    \ FROM project_applies pw JOIN recruits r ON r.recruit_id = pw.project_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO [ProjectApplicantEntity]
