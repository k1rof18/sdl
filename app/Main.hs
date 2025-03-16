module Main (main) where

import Domain.ProjectWorker (ClientId (..), ProjectId (..))
import Gateway.ProjectWorkerGateway (ProjectWorkerGateway (..), runProjectWorkerGateway)
import UseCase.ListProjectWorkers (exec)

listProjectWorker :: String -> String -> IO ()
listProjectWorker clientId recruitId = do
  result <- runProjectWorkerGateway $ UseCase.ListProjectWorkers.exec (ClientId clientId) (ProjectId recruitId)
  mapM_ print result

main :: IO ()
main = do
  print "========================"
  listProjectWorker "cf71705d-de27-40fe-9181-e190e0a65eb6" "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f"
