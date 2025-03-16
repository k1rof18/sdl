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
  listProjectWorker "11111111-1111-1111-1111-111111111111" "44444444-4444-4444-4444-444444444444"
