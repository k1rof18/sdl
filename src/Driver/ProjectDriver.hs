{-# LANGUAGE OverloadedStrings #-}

module Driver.ProjectDriver where

import Data.Maybe (listToMaybe)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data ProjectEntity = ProjectEntity {recruit_id :: UUID, title :: String, client_id :: UUID}
  deriving (Show)

instance FromRow ProjectEntity where
  fromRow = ProjectEntity <$> field <*> field <*> field

list :: IO [ProjectEntity]
list = do
  connection <- conn
  result <- query_ connection "SELECT p.recruit_id, r.title, r.client_id FROM projects p JOIN recruits r ON p.recruit_id = r.recruit_id"
  return result
