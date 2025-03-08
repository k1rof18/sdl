module Main (main) where

import Control.Monad.IO.Class (liftIO)
import Domain.Recruit (RecruitId (..))
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
  print $ "========================"
  getRecruit "1"
  getRecruit "2"
