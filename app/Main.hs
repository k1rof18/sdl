module Main (main) where

import Control.Monad.IO.Class (liftIO)
import Domain.Recruit (RecruitId (..))
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import UseCase.GetRecruit (exec)

main :: IO ()
main = do
  print $ RecruitId "1"
  let gateway = runRecruitGateway
  result <- gateway $ exec (RecruitId "1")
  case result of
    Just recruit -> liftIO $ putStrLn $ "Found recruit: " ++ show recruit
    Nothing -> liftIO $ putStrLn "Recruit not found"
