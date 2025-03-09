{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListProjects where

import Domain.Project (Project (..), ProjectId (..))
import Port.ProjectPort (ProjectPort (..))

exec :: (ProjectPort m) => m [Project]
exec = list
