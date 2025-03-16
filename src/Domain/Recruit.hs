{-# LANGUAGE DataKinds #-}

module Domain.Recruit (RecruitType (..), Recruit (..), toRecruitType, toRecruitIn, RecruitIn, toFilteredStageRecruits, FilteredStageRecruit) where

import Domain.Stage (Stage (ApplyStage, FirstStage))

data RecruitType
  = Project
  | Competition
  deriving (Show, Eq)

toRecruitType :: String -> RecruitType
toRecruitType "project" = Project
toRecruitType "competition" = Competition
toRecruitType _ = error "Unknown recruit type"

data Recruit = Recruit
  { recruitId :: String,
    title :: String,
    recruitType :: RecruitType,
    stage :: Stage
  }
  deriving (Show, Eq)

data RecruitIn
  = ApplicationRecruit Recruit
  | FirstStageRecruit Recruit
  deriving (Show, Eq)

data FilteredStageRecruit = FilteredStageRecruit RecruitIn deriving (Show, Eq)

toRecruitIn :: Recruit -> RecruitIn
toRecruitIn recruit =
  case stage recruit of
    FirstStage -> FirstStageRecruit recruit
    _ -> ApplicationRecruit recruit

isStage :: Stage -> RecruitIn -> Bool
isStage st (ApplicationRecruit r) = stage r == st
isStage st (FirstStageRecruit r) = stage r == st

toFilteredStageRecruits :: Stage -> [RecruitIn] -> [FilteredStageRecruit]
toFilteredStageRecruits st recruits =
  map FilteredStageRecruit $ filter (isStage st) recruits