{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module UseCase.GetRecruit where

import Control.Monad.RWS (MonadState (put))
import Domain.Recruit (Recruit (recruitId), RecruitId (..))
import Port.RecruitPort (RecruitPort (..))

exec :: (RecruitPort m) => RecruitId -> m (Maybe Recruit)
exec recruitId = do
  find recruitId