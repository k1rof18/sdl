{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Gateway.ProjectWorkerGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.ProjectWorker (ClientId (..), ProjectId (..), ProjectWorker (..), WorkerId (..))
import Domain.Stage (Stage (FirstStage), toStage)
import Driver.ProjectWorkerDriver (ProjectWorkerDriverEntity (..), list)
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

newtype ProjectWorkerGateway m a = ProjectWorkerGateway {runProjectWorkerGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => ProjectWorkerPort (ProjectWorkerGateway m) where
  list (ClientId client_id) (ProjectId recruit_id) = ProjectWorkerGateway $ do
    recruit <- liftIO $ Driver.ProjectWorkerDriver.list client_id recruit_id
    return $ map toDomain recruit
    where
      toDomain value =
        ProjectWorker
          { _workerId = WorkerId $ toString $ worker_id value,
            _projectId = ProjectId recruit_id,
            _workerName = user_name value,
            _budget = budget value,
            _stage = toStage $ project_stage value
          }
