{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.RecruitDriver where

import Data.UUID (UUID)
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data RecruitDriverEntity = RecruitDriverEntity
  { _title :: String,
    _recruitType :: String
  }
  deriving (Show)

instance FromRow RecruitDriverEntity where
  fromRow = RecruitDriverEntity <$> field <*> field

list :: IO [RecruitDriverEntity]
list = do
  connection <- conn
  query_
    connection
    "WITH pr AS (SELECT client_id, title FROM recruits r JOIN projects p ON p.project_id = r.recruit_id), \
    \ pc AS (SELECT client_id, title FROM recruits r JOIN competitions c ON c.competition_id = r.recruit_id) \
    \ SELECT title, 'project' as recruit_type FROM pr UNION SELECT title, 'competition' as recruit_type FROM pc"
