{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.ProjectWorkerPort where

import Domain.Client (ClientId)
import Domain.ProjectWorker (ProjectWorker)
import Domain.Recruit (RecruitId)

class (Monad m) => ProjectWorkerPort m where
  list :: ClientId -> RecruitId -> m [ProjectWorker]
