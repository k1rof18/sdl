module Domain.Recruit where

newtype RecruitId = RecruitId String
  deriving (Show, Eq, Ord)

data Skill = Haskell | Clojure | Go | Ruby | TypeScript deriving (Enum, Bounded, Show)

data Recruit = Recruit
  { recruitId :: RecruitId,
    title :: String,
    description :: String,
    skills :: [Skill]
  }
  deriving (Show)