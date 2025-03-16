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
  { _recruit_id :: UUID,
    _title :: String,
    _recruitType :: String,
    _stage :: String
  }
  deriving (Show)

instance FromRow RecruitDriverEntity where
  fromRow = RecruitDriverEntity <$> field <*> field <*> field <*> field

list :: IO [RecruitDriverEntity]
list = do
  connection <- conn
  query_
    connection
    "WITH pr AS (SELECT recruit_id, client_id, title FROM recruits r JOIN projects p ON p.project_id = r.recruit_id), \
    \ pc AS (SELECT recruit_id, client_id, title FROM recruits r JOIN competitions c ON c.competition_id = r.recruit_id) \
    \ SELECT recruit_id, title, 'project' as recruit_type, 'first' as stage FROM pr UNION SELECT recruit_id, title, 'competition' as recruit_type, 'apply' as stage FROM pc"
