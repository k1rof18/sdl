{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.FirstStageProjectApplicantPort where

import Domain.Client (ClientId)
import Domain.Project (ProjectId)
import Domain.ProjectApplicant (FirstStageProjectApplicant)

class (Monad m) => FirstStageProjectApplicantPort m where
  list :: ClientId -> ProjectId -> m [FirstStageProjectApplicant]
