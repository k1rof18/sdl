{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListFirstStageProjectApplicants where

import Domain.Client (ClientId)
import Domain.Project (ProjectId)
import Domain.ProjectApplicant (FirstStageProjectApplicant (..))
import Port.FirstStageProjectApplicantPort (FirstStageProjectApplicantPort (..))

exec :: (FirstStageProjectApplicantPort m) => ClientId -> ProjectId -> m [FirstStageProjectApplicant]
exec = list