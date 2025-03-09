{-# LANGUAGE OverloadedStrings #-}

module Driver.RecruitDriver where

import Data.Maybe (listToMaybe)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow

data Recruit = Recruit {recruit_id :: UUID, title :: String}
  deriving (Show)

-- データベースからの行を Recruit 型に変換するためのインスタンス
instance FromRow Recruit where
  fromRow = Recruit <$> field <*> field

getById :: Connection -> String -> IO (Maybe Recruit)
getById conn id = do
  -- recruit_id によってデータを検索し、結果を Maybe 型で返す
  result <- query conn "SELECT recruit_id, title FROM recruits WHERE recruit_id = ?" (Only id) :: IO [Recruit]
  return $ listToMaybe result -- 1件だけ取得するため Maybe 型に変換
