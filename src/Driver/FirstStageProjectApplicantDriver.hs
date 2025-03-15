{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.FirstStageProjectApplicantDriver where

import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data FirstStageProjectApplicantEntity = FirstStageProjectApplicantEntity
  { apply_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID,
    name :: String
  }
  deriving (Show)

instance FromRow FirstStageProjectApplicantEntity where
  fromRow = FirstStageProjectApplicantEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [FirstStageProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.apply_id, pw.applicant_id, pw.project_id, u.name \
    \ FROM project_applies pw \
    \ INNER JOIN project_applicant_stage_histories fspa ON pw.apply_id = fspa.apply_id \
    \ INNER JOIN recruits r ON r.recruit_id = pw.project_id \
    \ INNER JOIN users u ON u.user_id = pw.applicant_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO
      [FirstStageProjectApplicantEntity]
