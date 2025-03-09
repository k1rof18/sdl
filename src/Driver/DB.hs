module Driver.DB where

import Database.PostgreSQL.Simple

conn :: IO Connection
conn = do
  c <-
    connect
      defaultConnectInfo
        { connectHost = "localhost",
          connectDatabase = "mydb",
          connectUser = "myuser",
          connectPassword = "mypassword"
        }
  return c