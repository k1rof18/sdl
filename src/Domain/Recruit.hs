module Domain.Recruit where

newtype RecruitId = RecruitId String
  deriving (Show, Eq, Ord)

data Recruit = Recruit
  { recruitId :: RecruitId,
    title :: String
  }
  deriving (Show, Eq)
