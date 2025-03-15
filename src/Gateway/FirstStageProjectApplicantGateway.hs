{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Gateway.FirstStageProjectApplicantGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (ProjectId (..))
import Domain.ProjectApplicant (FirstStageProjectApplicant (..), PrivateInfo (..), ProjectApplicant (..), ProjectApplicantId (..))
import Domain.Worker (WorkerId (..))
import Driver.FirstStageProjectApplicantDriver (FirstStageProjectApplicantEntity (..), list)
import Port.FirstStageProjectApplicantPort (FirstStageProjectApplicantPort (..))

newtype FirstStageProjectApplicantGateway m a = FirstStageProjectApplicantGateway {runFirstStageProjectApplicantGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => FirstStageProjectApplicantPort (FirstStageProjectApplicantGateway m) where
  list (ClientId c) (ProjectId p) = FirstStageProjectApplicantGateway $ do
    recruit <-
      liftIO $
        Driver.FirstStageProjectApplicantDriver.list c p

    return $ map toDomain recruit
    where
      toDomain value =
        FirstStageProjectApplicant
          { projectApplicant =
              ProjectApplicant
                { projectApplicantId = ProjectApplicantId $ toString (Driver.FirstStageProjectApplicantDriver.project_applicant_id value),
                  projectId = ProjectId $ toString (Driver.FirstStageProjectApplicantDriver.project_id value),
                  workerId = WorkerId $ toString (Driver.FirstStageProjectApplicantDriver.worker_id value),
                  estimatedEndDate = Driver.FirstStageProjectApplicantDriver.estimated_end_date value
                },
            privateInfo =
              PrivateInfo
                { nickname = Driver.FirstStageProjectApplicantDriver.name value,
                  birthDay = Driver.FirstStageProjectApplicantDriver.birth_date value
                }
          }