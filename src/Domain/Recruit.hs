module Domain.Recruit (RecruitType (..), Recruit (..), toRecruitType) where

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
    recruitType :: RecruitType
  }
  deriving (Show, Eq)