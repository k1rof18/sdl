{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Domain.Client where

newtype ClientId = ClientId String
  deriving (Show, Eq, Ord)

data Client = Client
  { clientId :: ClientId
  }