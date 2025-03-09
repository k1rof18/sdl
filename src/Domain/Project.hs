module Domain.Project where

newtype ProjectId = ProjectId String
  deriving (Show, Eq, Ord)

data Project = Project
  { projectId :: ProjectId,
    title :: String
  }
  deriving (Show, Eq)
