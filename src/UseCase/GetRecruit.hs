{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module UseCase.GetRecruit where

import Domain.Recruit (Recruit (..), RecruitId (..))
import Port.RecruitPort (RecruitPort (..))

exec :: (RecruitPort m) => RecruitId -> m (Maybe Recruit)
exec = find