{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.ProjectWorkerGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (ProjectId (..))
import Domain.ProjectWorker (ProjectWorker (..), ProjectWorkerId (..), WorkerId (..))
import Domain.Recruit (RecruitId (..))
import Driver.ProjectDriver (ProjectEntity (client_id))
import Driver.ProjectWorkerDriver (ProjectWorkerEntity (..), list)
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

newtype ProjectWorkerGateway m a = ProjectWorkerGateway {runProjectWorkerGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => ProjectWorkerPort (ProjectWorkerGateway m) where
  list (ClientId client_id) (RecruitId recruit_id) = ProjectWorkerGateway $ do
    recruit <- liftIO $ Driver.ProjectWorkerDriver.list client_id recruit_id
    return $ map toDomain recruit
    where
      toDomain value =
        ProjectWorker
          { projectWorkerId = ProjectWorkerId $ toString (Driver.ProjectWorkerDriver.project_worker_id value),
            projectId = ProjectId $ toString (Driver.ProjectWorkerDriver.recruit_id value),
            workerId = WorkerId $ toString (Driver.ProjectWorkerDriver.worker_id value),
            estimatedEndDate = Driver.ProjectWorkerDriver.estimated_end_date value
          }
