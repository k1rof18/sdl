module Domain.SecondStageProjectApplicant where

import Domain.ProjectApplicant (PrivateInfo, Profile, ProjectApplicant)

data SecondStageProjectApplicant = SecondStageProjectApplicant
  { projectApplicant :: ProjectApplicant,
    privateInfo :: PrivateInfo,
    profile :: Profile
  }
  deriving (Show, Eq)
