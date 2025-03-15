{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}

module Gateway.SecondStageProjectApplicantGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (ProjectId (..))
import Domain.ProjectApplicant (ApplyId (..), PrivateInfo (..), Profile (..), ProjectApplicant (..))
import Domain.SecondStageProjectApplicant (SecondStageProjectApplicant (..))
import Domain.Worker (WorkerId (..))
import Driver.SecondStageProjectApplicantDriver (SecondStageProjectApplicantEntity (..), list)
import Port.SecondStageProjectApplicantPort (SecondStageProjectApplicantPort (..))

newtype SecondStageProjectApplicantGateway m a = SecondStageProjectApplicantGateway {runSecondStageProjectApplicantGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => SecondStageProjectApplicantPort (SecondStageProjectApplicantGateway m) where
  list (ClientId c) (ProjectId p) = SecondStageProjectApplicantGateway $ do
    recruit <-
      liftIO $
        Driver.SecondStageProjectApplicantDriver.list c p

    return $ map toDomain recruit
    where
      toDomain value =
        SecondStageProjectApplicant
          { projectApplicant =
              ProjectApplicant
                { applyId = ApplyId $ toString (apply_id value),
                  projectId = ProjectId $ toString (project_id value),
                  workerId = WorkerId $ toString (worker_id value)
                },
            privateInfo =
              PrivateInfo
                { nickname = name value
                },
            profile = Profile "XXX"
          }