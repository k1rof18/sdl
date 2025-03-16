module Domain.Stage (Stage (..), toStage) where

data Stage
  = ApplyStage
  | FirstStage
  deriving (Show, Eq)

toStage :: String -> Stage
toStage "apply" = ApplyStage
toStage "first" = FirstStage
toStage _ = error "Unknown stage"