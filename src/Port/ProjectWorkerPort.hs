module Port.ProjectWorkerPort (ProjectWorkerPort, list) where

import Domain.ProjectWorker (ClientId, ProjectId, ProjectWorker)

class (Monad m) => ProjectWorkerPort m where
  list :: ClientId -> ProjectId -> m [ProjectWorker]
