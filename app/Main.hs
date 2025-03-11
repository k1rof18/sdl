module Main (main) where

import Domain.Client (ClientId (ClientId))
import Domain.Project (ProjectId (..))
import Domain.Recruit (RecruitId (..))
import Gateway.FirstStageProjectApplicantGateway (FirstStageProjectApplicantGateway (..), runFirstStageProjectApplicantGateway)
import Gateway.ProjectApplicantGateway (ProjectApplicantGateway (..), runProjectApplicantGateway)
import Gateway.ProjectGateway (ProjectGateway (..), runProjectGateway)
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import Gateway.SecondStageProjectApplicantGateway (SecondStageProjectApplicantGateway (..), runSecondStageProjectApplicantGateway)
import UseCase.GetRecruit (exec)
import UseCase.ListFirstStageProjectApplicants (exec)
import UseCase.ListProjectApplicants (exec)
import UseCase.ListProjects (exec)
import UseCase.ListSecondStageProjectApplicants (exec)

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

listProjectApplicant :: String -> String -> IO ()
listProjectApplicant clientId recruitId = do
  result <- runProjectApplicantGateway $ UseCase.ListProjectApplicants.exec (ClientId clientId) (RecruitId recruitId)
  mapM_ print result
  print "========================"

listFirstStageProjectApplicants :: String -> String -> IO ()
listFirstStageProjectApplicants clientId projectId = do
  result <- runFirstStageProjectApplicantGateway $ UseCase.ListFirstStageProjectApplicants.exec (ClientId clientId) (ProjectId projectId)
  mapM_ print result
  print "========================"

listSecondStageProjectApplicants :: String -> String -> IO ()
listSecondStageProjectApplicants clientId projectId = do
  result <- runSecondStageProjectApplicantGateway $ UseCase.ListSecondStageProjectApplicants.exec (ClientId clientId) (ProjectId projectId)
  mapM_ print result
  print "========================"

main :: IO ()
main = do
  print "========================"
  -- getRecruit "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4d"
  -- getRecruit "d20fa5f5-7b96-1ff1-d8b3-f7565aeecbb7"
  -- listProject
  -- listProjectApplicant "cf71705d-de27-40fe-9181-e190e0a65eb6" "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f"
  -- listFirstStageProjectApplicants "cf71705d-de27-40fe-9181-e190e0a65eb6" "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f"
  listSecondStageProjectApplicants "cf71705d-de27-40fe-9181-e190e0a65eb6" "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b4f"
