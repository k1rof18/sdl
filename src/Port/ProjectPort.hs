{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.ProjectPort where

import Domain.Project (Project, ProjectId)

class (Monad m) => ProjectPort m where
  list :: m [Project]
