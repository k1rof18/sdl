{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Domain.ProjectApplicant where

import Data.Time.Calendar (Day)
import Domain.Project (ProjectId)
import Domain.Worker (WorkerId)

newtype ProjectApplicantId = ProjectApplicantId String
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
  { projectApplicantId :: ProjectApplicantId,
    projectId :: ProjectId,
    workerId :: WorkerId
  }
  deriving (Show, Eq)

data FirstStageProjectApplicant = FirstStageProjectApplicant
  { projectApplicant :: ProjectApplicant,
    privateInfo :: PrivateInfo
  }
  deriving (Show, Eq)
