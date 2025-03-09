module Domain.Project where

import Domain.Client (ClientId)

newtype ProjectId = ProjectId String
  deriving (Show, Eq, Ord)

data Project = Project
  { projectId :: ProjectId,
    title :: String,
    clientId :: ClientId
  }
  deriving (Show, Eq)
