{-# OPTIONS_GHC -Wno-missing-export-lists #-}
{-# OPTIONS_GHC -Wno-partial-fields #-}

module Domain.ProjectApplicant where

import Domain.Project (ProjectId)
import Domain.Worker (WorkerId)

newtype ApplyId = ApplyId String
  deriving (Show, Eq, Ord)

data PrivateInfo = PrivateInfo
  { nickname :: String
  }
  deriving (Show, Eq)

data Profile = Profile
  { selfIntroduction :: String
  }
  deriving (Show, Eq)

data ProjectApplicant = ProjectApplicant
  { applyId :: ApplyId,
    projectId :: ProjectId,
    workerId :: WorkerId
  }
  deriving (Show, Eq)

data FirstStageProjectApplicant = FirstStageProjectApplicant
  { projectApplicant :: ProjectApplicant,
    privateInfo :: PrivateInfo
  }
  deriving (Show, Eq)
