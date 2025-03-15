{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Domain.Worker where

newtype WorkerId = WorkerId String
  deriving (Show, Eq, Ord)
