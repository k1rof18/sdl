{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.ProjectDriver where

import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectEntity = ProjectEntity {project_id :: UUID, title :: String, client_id :: UUID}
  deriving (Show)

instance FromRow ProjectEntity where
  fromRow = ProjectEntity <$> field <*> field <*> field

list :: IO [ProjectEntity]
list = do
  connection <- conn
  result <- query_ connection "SELECT p.project_id, r.title, r.client_id FROM projects p JOIN recruits r ON p.project_id = r.recruit_id"
  return result
