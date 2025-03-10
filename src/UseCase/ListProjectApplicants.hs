{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListProjectApplicants where

import Domain.Client (ClientId)
import Domain.ProjectApplicant (ProjectApplicant (..))
import Domain.Recruit (RecruitId)
import Port.ProjectApplicantPort (ProjectApplicantPort (..))

exec :: (ProjectApplicantPort m) => ClientId -> RecruitId -> m [ProjectApplicant]
exec = list
