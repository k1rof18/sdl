{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO)
import Domain.Recruit (Recruit (..), RecruitId (..))
import Port.RecruitPort (RecruitPort (..))

newtype RecruitGateway m a = RecruitGateway {runRecruitGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => RecruitPort (RecruitGateway m) where
  find recruitId = RecruitGateway $ do
    if recruitId == RecruitId "1"
      then
        return $
          Just $
            Recruit
              { recruitId = RecruitId "1",
                title = "Software Engineer"
              }
      else return Nothing
