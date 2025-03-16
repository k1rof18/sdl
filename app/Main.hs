module Main (main) where

import Domain.ProjectWorker (ClientId (..), ProjectId (..))
import Gateway.ProjectWorkerGateway (ProjectWorkerGateway (..), runProjectWorkerGateway)
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import UseCase.ListProjectWorkers (exec)
import UseCase.ListRecruits (exec)

listProjectWorker :: String -> String -> IO ()
listProjectWorker clientId recruitId = do
  result <- runProjectWorkerGateway $ UseCase.ListProjectWorkers.exec (ClientId clientId) (ProjectId recruitId)
  mapM_ print result

listRecruit :: IO ()
listRecruit = do
  result <- runRecruitGateway $ UseCase.ListRecruits.exec
  mapM_ print result

main :: IO ()
main = do
  print "========================"
  print "List Recruits"
  listRecruit
  print "========================"
  listProjectWorker "11111111-1111-1111-1111-111111111111" "44444444-4444-4444-4444-444444444444"
  print "========================"
