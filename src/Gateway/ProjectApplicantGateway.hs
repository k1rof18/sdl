{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.ProjectApplicantGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (ProjectId (..))
import Domain.ProjectApplicant (ProjectApplicant (..), ProjectApplicantId (..), WorkerId (..))
import Domain.Recruit (RecruitId (..))
import Driver.ProjectApplicantDriver (ProjectApplicantEntity (..), list)
import Port.ProjectApplicantPort (ProjectApplicantPort (..))

newtype ProjectApplicantGateway m a = ProjectApplicantGateway {runProjectApplicantGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => ProjectApplicantPort (ProjectApplicantGateway m) where
  list (ClientId client_id) (RecruitId recruit_id) = ProjectApplicantGateway $ do
    recruit <- liftIO $ Driver.ProjectApplicantDriver.list client_id recruit_id
    return $ map toDomain recruit
    where
      toDomain value =
        ProjectApplicant
          { projectApplicantId = ProjectApplicantId $ toString (Driver.ProjectApplicantDriver.project_applicant_id value),
            projectId = ProjectId $ toString (Driver.ProjectApplicantDriver.project_id value),
            workerId = WorkerId $ toString (Driver.ProjectApplicantDriver.worker_id value),
            estimatedEndDate = Driver.ProjectApplicantDriver.estimated_end_date value
          }
