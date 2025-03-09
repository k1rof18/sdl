module Main (main) where

import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple
import Domain.Recruit (RecruitId (..))
import Driver.RecruitDriver (getById)
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import UseCase.GetRecruit (exec)

getRecruit recruitId = do
  print $ RecruitId recruitId
  let gateway = runRecruitGateway
  result <- gateway $ exec (RecruitId recruitId)
  case result of
    Just recruit -> liftIO $ putStrLn $ "Found recruit: " ++ show recruit
    Nothing -> liftIO $ putStrLn "Recruit not found"

main :: IO ()
main = do
  conn <-
    connect
      defaultConnectInfo
        { connectHost = "localhost",
          connectDatabase = "mydb",
          connectUser = "myuser",
          connectPassword = "mypassword"
        }

  print "========================"
  maybeRecruit <- getById conn "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45" -- d20fa5f5-7b96-1ff1-d8b3-f7565aeecbb7
  case maybeRecruit of
    Just recruit -> print recruit -- Recruit が見つかった場合、表示
    Nothing -> putStrLn "Recruit not found" -- Recruit が見つからない場合、メッセージ表示
  print "========================"
  getRecruit "1"
  getRecruit "2"
