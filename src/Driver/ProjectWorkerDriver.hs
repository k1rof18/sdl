{-# LANGUAGE OverloadedStrings #-}

module Driver.ProjectWorkerDriver where

import Data.Time.Calendar (Day)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectWorkerEntity = ProjectWorkerEntity
  { project_worker_id :: UUID,
    worker_id :: UUID,
    recruit_id :: UUID,
    estimated_end_date :: Day
  }
  deriving (Show)

instance FromRow ProjectWorkerEntity where
  fromRow = ProjectWorkerEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [ProjectWorkerEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pw.project_worker_id, pw.worker_id, pw.recruit_id, pw.estimated_end_date \
    \ FROM project_workers pw JOIN recruits r ON r.recruit_id = pw.recruit_id \
    \ WHERE r.client_id = ? AND r.recruit_id = ?"
    (cli_id, rec_id) ::
    IO [ProjectWorkerEntity]