module Domain.Worker where

newtype WorkerId = WorkerId String
  deriving (Show, Eq, Ord)
