{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.ProjectWorkerDriver where

import Data.UUID (UUID)
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectWorkerDriverEntity = ProjectWorkerDriverEntity
  { worker_id :: UUID,
    budget :: Int,
    project_stage :: String,
    user_name :: String
  }
  deriving (Show)

instance FromRow ProjectWorkerDriverEntity where
  fromRow = ProjectWorkerDriverEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [ProjectWorkerDriverEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pa.applicant_id as worker_id, pa.budget, CAST(ls.stage AS TEXT) AS project_stage, u.name as user_name \
    \ FROM project_applies pa \
    \ join users u on u.user_id = pa.applicant_id \
    \ JOIN ( \
    \ SELECT apply_id, stage \
    \ from project_applicant_stage_histories \
    \ order by staged_at desc limit 1 \
    \ ) ls ON ls.apply_id = pa.apply_id \
    \ join recruits r on r.recruit_id = pa.project_id \
    \ WHERE r.client_id = ? AND pa.project_id = ?"
    (cli_id, rec_id) ::
    IO [ProjectWorkerDriverEntity]
