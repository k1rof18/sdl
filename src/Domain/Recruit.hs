module Domain.Recruit where

import Domain.Client (ClientId)

newtype RecruitId = RecruitId String
  deriving (Show, Eq, Ord)

data Recruit = Recruit
  { recruitId :: RecruitId,
    title :: String,
    clientId :: ClientId
  }
  deriving (Show, Eq)
