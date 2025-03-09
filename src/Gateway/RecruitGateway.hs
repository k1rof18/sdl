{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Recruit (Recruit (..), RecruitId (..))
import Driver.RecruitDriver (RecruitEntity (..), getById)
import Port.RecruitPort (RecruitPort (..))

newtype RecruitGateway m a = RecruitGateway {runRecruitGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => RecruitPort (RecruitGateway m) where
  find (RecruitId recruitId) = RecruitGateway $ do
    recruit <- liftIO $ getById recruitId
    case recruit of
      Nothing -> return Nothing
      Just value ->
        return $
          Just
            Recruit
              { recruitId = RecruitId $ toString (Driver.RecruitDriver.recruit_id value),
                Domain.Recruit.title = Driver.RecruitDriver.title value
              }