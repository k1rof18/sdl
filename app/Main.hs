module Main (main) where

import Domain.Recruit (RecruitId (..))
import Gateway.ProjectGateway (ProjectGateway (..), runProjectGateway)
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import UseCase.GetRecruit (exec)
import UseCase.ListProjects (exec)

getRecruit :: String -> IO ()
getRecruit recruitId = do
  result <- runRecruitGateway $ UseCase.GetRecruit.exec (RecruitId recruitId)
  case result of
    Just recruit -> print recruit
    Nothing -> putStrLn "Recruit not found"
  print "========================"

listProject :: IO ()
listProject = do
  result <- runProjectGateway UseCase.ListProjects.exec
  mapM_ print result
  print "========================"

main :: IO ()
main = do
  print "========================"
  getRecruit "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d"
  getRecruit "d20fa5f5-7b96-1ff1-d8b3-f7565aeecbb7"
  listProject
