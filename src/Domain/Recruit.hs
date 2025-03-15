{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Domain.Recruit where

import Domain.Client (ClientId)

newtype RecruitId = RecruitId String
  deriving (Show, Eq, Ord)

data Recruit = Recruit
  { recruitId :: RecruitId,
    clientId :: ClientId
  }
  deriving (Show, Eq)
