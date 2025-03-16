{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Domain.ApplyStageUser where

import Data.Time.Calendar (Day (..))
import Domain.ProjectApplicant (PrivateInfo (..))
import Domain.Worker (WorkerId)

data UserAllInfo = UserAllInfo
  { workerId :: WorkerId,
    privateInfo :: PrivateInfo
  }
  deriving (Show, Eq)

data ProjectStage
  = ApplyStage
  | FirstStage
  deriving (Show, Eq)

data ProjectInfo = ProjectInfo
  { estimatedEndDate :: Day,
    stage :: ProjectStage
  }

toProjectUser :: UserAllInfo -> ProjectInfo -> StageUser
toProjectUser userAllInfo projectInfo =
  case stage projectInfo of
    ApplyStage -> ApplyStageUser (workerId userAllInfo) (estimatedEndDate projectInfo)
    FirstStage ->
      FirstStageUser
        (workerId userAllInfo)
        (estimatedEndDate projectInfo)
        (PrivateInfo "nickname")

data StageUser
  = ApplyStageUser WorkerId Day
  | FirstStageUser WorkerId Day PrivateInfo
  deriving (Show, Eq)
