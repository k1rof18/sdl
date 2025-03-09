{-# LANGUAGE OverloadedStrings #-}

module Driver.RecruitDriver where

import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow

-- `FromField UUID` インスタンスを提供

-- ユーザーデータを表す型
data Recruit = Recruit {recruit_id :: UUID, title :: String}
  deriving (Show)

-- データベースからの行を Recruit 型に変換するためのインスタンス
instance FromRow Recruit where
  fromRow = Recruit <$> field <*> field

rrr = do
  -- PostgreSQL に接続
  conn <-
    connect
      defaultConnectInfo
        { connectHost = "localhost",
          connectDatabase = "mydb",
          connectUser = "myuser",
          connectPassword = "mypassword"
        }

  -- `recruits` テーブルのデータを取得
  recruits <- query_ conn "SELECT recruit_id, title FROM recruits" :: IO [Recruit]

  -- 結果を出力
  mapM_ print recruits

  -- 接続を閉じる
  close conn
