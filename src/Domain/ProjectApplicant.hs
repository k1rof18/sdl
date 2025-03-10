module Domain.ProjectApplicant where

import Data.Time.Calendar (Day)
import Domain.Project (ProjectId)

newtype ProjectApplicantId = ProjectApplicantId String
  deriving (Show, Eq, Ord)

newtype WorkerId = WorkerId String
  deriving (Show, Eq, Ord)

data ProjectApplicant = ProjectApplicant
  { projectApplicantId :: ProjectApplicantId,
    projectId :: ProjectId,
    workerId :: WorkerId,
    estimatedEndDate :: Day
  }
  deriving (Show, Eq)
