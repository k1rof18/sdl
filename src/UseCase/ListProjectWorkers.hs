{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListProjectWorkers where

import Domain.Client (ClientId)
import Domain.ProjectWorker (ProjectWorker (..))
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

exec :: (ProjectWorkerPort m) => ClientId -> m [ProjectWorker]
exec = list
