{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Domain.Recruit (Recruit (..), RecruitId (..), Skill (..))
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
                title = "Software Engineer",
                description = "We are looking for a FP software engineer",
                skills = [Haskell, Clojure]
              }
      else return Nothing