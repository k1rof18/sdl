module UseCase.ListProjectWorkers (exec) where

import Domain.ProjectWorker (ClientId, ProjectId, ProjectWorkerInFlow, toProjectWorkerInFlow)
import Port.ProjectWorkerPort (ProjectWorkerPort (..))

exec :: (ProjectWorkerPort m) => ClientId -> ProjectId -> m [ProjectWorkerInFlow]
exec clientId recruitId =
  list clientId recruitId
    >>= \w -> return $ fmap toProjectWorkerInFlow w
