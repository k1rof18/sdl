{-# LANGUAGE OverloadedStrings #-}

module Driver.RecruitDriver where

import Data.Maybe (listToMaybe)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data RecruitEntity = RecruitEntity {recruit_id :: UUID, title :: String}
  deriving (Show)

instance FromRow RecruitEntity where
  fromRow = RecruitEntity <$> field <*> field

getById :: String -> IO (Maybe RecruitEntity)
getById id = do
  conn <- conn
  result <- query conn "SELECT recruit_id, title FROM recruits WHERE recruit_id = ?" (Only id) :: IO [RecruitEntity]
  return $ listToMaybe result
