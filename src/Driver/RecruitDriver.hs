{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.RecruitDriver where

import Data.Maybe (listToMaybe)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data RecruitEntity = RecruitEntity {recruit_id :: UUID, client_id :: UUID}
  deriving (Show)

instance FromRow RecruitEntity where
  fromRow = RecruitEntity <$> field <*> field

getById :: String -> IO (Maybe RecruitEntity)
getById rec_id = do
  connection <- conn
  result <- query connection "SELECT recruit_id, client_id FROM recruits WHERE recruit_id = ?" (Only rec_id) :: IO [RecruitEntity]
  return $ listToMaybe result
