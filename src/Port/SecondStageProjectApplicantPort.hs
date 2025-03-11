{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.SecondStageProjectApplicantPort where

import Domain.Client (ClientId)
import Domain.Project (ProjectId)
import Domain.SecondStageProjectApplicant (SecondStageProjectApplicant)

class (Monad m) => SecondStageProjectApplicantPort m where
  list :: ClientId -> ProjectId -> m [SecondStageProjectApplicant]
