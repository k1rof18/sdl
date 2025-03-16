module Domain.Stage (Stage (..)) where

data Stage
  = ApplyStage
  | FirstStage
  deriving (Show, Eq)