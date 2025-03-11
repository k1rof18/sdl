{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.SecondStageProjectApplicantGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (ProjectId (..))
import Domain.ProjectApplicant (PrivateInfo (..), Profile (..), ProjectApplicant (..), ProjectApplicantId (..))
import Domain.SecondStageProjectApplicant (SecondStageProjectApplicant (..))
import Domain.Worker (WorkerId (..))
import Driver.SecondStageProjectApplicantDriver (SecondStageProjectApplicantEntity (..), list)
import Port.SecondStageProjectApplicantPort (SecondStageProjectApplicantPort (..))

newtype SecondStageProjectApplicantGateway m a = SecondStageProjectApplicantGateway {runSecondStageProjectApplicantGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => SecondStageProjectApplicantPort (SecondStageProjectApplicantGateway m) where
  list (ClientId client_id) (ProjectId project_id) = SecondStageProjectApplicantGateway $ do
    recruit <-
      liftIO $
        Driver.SecondStageProjectApplicantDriver.list
          client_id
          project_id

    return $ map toDomain recruit
    where
      toDomain value =
        SecondStageProjectApplicant
          { projectApplicant =
              ProjectApplicant
                { projectApplicantId = ProjectApplicantId $ toString (Driver.SecondStageProjectApplicantDriver.project_applicant_id value),
                  projectId = ProjectId $ toString (Driver.SecondStageProjectApplicantDriver.project_id value),
                  workerId = WorkerId $ toString (Driver.SecondStageProjectApplicantDriver.worker_id value),
                  estimatedEndDate = Driver.SecondStageProjectApplicantDriver.estimated_end_date value
                },
            privateInfo =
              PrivateInfo
                { nickname = Driver.SecondStageProjectApplicantDriver.name value,
                  birthDay = Driver.SecondStageProjectApplicantDriver.birth_date value
                },
            profile =
              Profile
                { selfIntroduction = Driver.SecondStageProjectApplicantDriver.selfintroduction value
                }
          }