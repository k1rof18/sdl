{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.DB where

import Database.PostgreSQL.Simple

conn :: IO Connection
conn = do
  connect
    defaultConnectInfo
      { connectHost = "localhost",
        connectDatabase = "mydb",
        connectUser = "myuser",
        connectPassword = "mypassword"
      }
