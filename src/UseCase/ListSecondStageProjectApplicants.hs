{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.ListSecondStageProjectApplicants where

import Domain.Client (ClientId)
import Domain.Project (ProjectId)
import Domain.SecondStageProjectApplicant (SecondStageProjectApplicant (..))
import Port.SecondStageProjectApplicantPort (SecondStageProjectApplicantPort (..))

exec :: (SecondStageProjectApplicantPort m) => ClientId -> ProjectId -> m [SecondStageProjectApplicant]
exec = list