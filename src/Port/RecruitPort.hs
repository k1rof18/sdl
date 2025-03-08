{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module Port.RecruitPort where

import Domain.Recruit (Recruit, RecruitId)

class (Monad m) => RecruitPort m where
  find :: RecruitId -> m (Maybe Recruit)
