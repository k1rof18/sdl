{-# OPTIONS_GHC -Wno-partial-fields #-}

module Domain.ProjectWorker
  ( ProjectId (..),
    WorkerId (..),
    ClientId (..),
    Stage (..),
    ProjectWorkerInFlow (..),
    ProjectWorker (..),
    toProjectWorkerInFlow,
  )
where

newtype ProjectId = ProjectId String deriving (Show, Eq)

newtype WorkerId = WorkerId String deriving (Show, Eq)

newtype ClientId = ClientId String deriving (Show, Eq)

data Stage
  = ApplyStage
  | FirstStage
  deriving (Show, Eq)

data ProjectWorkerInFlow
  = ApplyStageWorker {w_id :: WorkerId}
  | FirstStageWorker {w_id :: WorkerId, w_name :: String}
  deriving (Show, Eq)

data ProjectWorker = ProjectWorker
  { _workerId :: WorkerId,
    _projectId :: ProjectId,
    _worker_name :: String,
    _budget :: Int,
    _stage :: Stage
  }
  deriving (Show, Eq)

toProjectWorkerInFlow :: ProjectWorker -> ProjectWorkerInFlow
toProjectWorkerInFlow wk =
  case _stage wk of
    ApplyStage -> ApplyStageWorker (_workerId wk)
    FirstStage -> FirstStageWorker (_workerId wk) (_worker_name wk)