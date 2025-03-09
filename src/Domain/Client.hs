module Domain.Client where

newtype ClientId = ClientId String
  deriving (Show, Eq, Ord)

data Client = Client
  { clientId :: ClientId
  }