{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListProjectWorkers where

import Domain.Client (ClientId)
import Domain.ProjectWorker (ProjectWorker (..))
import Domain.Recruit (RecruitId)
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

exec :: (ProjectWorkerPort m) => ClientId -> RecruitId -> m [ProjectWorker]
exec = list
