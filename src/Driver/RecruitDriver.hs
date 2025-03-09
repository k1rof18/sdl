{-# LANGUAGE OverloadedStrings #-}

module Driver.RecruitDriver where

import Data.Maybe (listToMaybe)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data Recruit = Recruit {recruit_id :: UUID, title :: String}
  deriving (Show)

instance FromRow Recruit where
  fromRow = Recruit <$> field <*> field

getById :: String -> IO (Maybe Recruit)
getById id = do
  conn <- conn
  result <- query conn "SELECT recruit_id, title FROM recruits WHERE recruit_id = ?" (Only id) :: IO [Recruit]
  return $ listToMaybe result
