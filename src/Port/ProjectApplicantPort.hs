{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Port.ProjectApplicantPort where

import Domain.Client (ClientId)
import Domain.ProjectApplicant (ProjectApplicant)
import Domain.Recruit (RecruitId)

class (Monad m) => ProjectApplicantPort m where
  list :: ClientId -> RecruitId -> m [ProjectApplicant]
