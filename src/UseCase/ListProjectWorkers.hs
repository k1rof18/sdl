{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListProjectWorkers where

import Domain.Client (ClientId)
import Domain.ProjectWorker (ProjectWorkerInFlow, toProjectWorkerInFlow)
import Domain.Recruit (RecruitId)
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

exec :: (ProjectWorkerPort m) => ClientId -> RecruitId -> m [ProjectWorkerInFlow]
exec clientId recruitId =
  list clientId recruitId
    >>= \w -> return $ fmap toProjectWorkerInFlow w
