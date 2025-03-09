{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.ProjectWorkerPort where

import Domain.Client (ClientId)
import Domain.ProjectWorker (ProjectWorker)

class (Monad m) => ProjectWorkerPort m where
  list :: ClientId -> m [ProjectWorker]
