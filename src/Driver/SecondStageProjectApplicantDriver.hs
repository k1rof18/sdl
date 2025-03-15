{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.SecondStageProjectApplicantDriver where

import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data SecondStageProjectApplicantEntity = SecondStageProjectApplicantEntity
  { apply_id :: UUID,
    worker_id :: UUID,
    project_id :: UUID,
    name :: String
  }
  deriving (Show)

instance FromRow SecondStageProjectApplicantEntity where
  fromRow = SecondStageProjectApplicantEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [SecondStageProjectApplicantEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.apply_id, pw.applicant_id, pw.project_id, u.name \
    \ FROM project_applies pw \
    \ INNER JOIN project_applicant_stage_histories pash ON pw.apply_id = pash.apply_id AND pash.stage = 'second' \
    \ INNER JOIN recruits r ON r.recruit_id = pw.project_id \
    \ INNER JOIN users u ON u.user_id = pw.applicant_id \
    \ WHERE r.client_id = ? AND pw.project_id = ?"
    (cli_id, rec_id) ::
    IO
      [SecondStageProjectApplicantEntity]
