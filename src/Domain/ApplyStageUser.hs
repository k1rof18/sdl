module Domain.ApplyStageUser where

import Data.Time.Calendar (Day (..))
import Domain.ProjectApplicant (PrivateInfo)
import Domain.Worker (WorkerId)

data UserAllInfo = UserAllInfo
  { workerId :: WorkerId
  }
  deriving (Show, Eq)

data ProjectInfo = ProjectInfo
  { estimatedEndDate :: Day
  }

toApplyStageUser userAllInfo projectInfo = ApplyStageUser (workerId userAllInfo) (estimatedEndDate projectInfo)

data StageUser
  = ApplyStageUser WorkerId Day
  | FirstStageUser WorkerId Day PrivateInfo
  deriving (Show, Eq)
