module Domain.ProjectWorker where

import Data.Time.Calendar (Day)
import Domain.Project (ProjectId)

newtype ProjectWorkerId = ProjectWorkerId String
  deriving (Show, Eq, Ord)

newtype WorkerId = WorkerId String
  deriving (Show, Eq, Ord)

data ProjectWorker = ProjectWorker
  { projectWorkerId :: ProjectWorkerId,
    projectId :: ProjectId,
    workerId :: WorkerId,
    estimatedEndDate :: Day
  }
  deriving (Show, Eq)
