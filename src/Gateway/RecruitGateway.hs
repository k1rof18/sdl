{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Recruit (Recruit (..), RecruitId (..))
import Driver.RecruitDriver (RecruitEntity (..), getById)
import Port.RecruitPort (RecruitPort (..))

newtype RecruitGateway m a = RecruitGateway {runRecruitGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => RecruitPort (RecruitGateway m) where
  find (RecruitId rec_id) = RecruitGateway $ do
    recruit <- liftIO $ getById rec_id
    case recruit of
      Nothing -> return Nothing
      Just value ->
        return $
          Just
            Recruit
              { recruitId = RecruitId $ toString (Driver.RecruitDriver.recruit_id value),
                Domain.Recruit.title = Driver.RecruitDriver.title value,
                clientId = ClientId $ toString (Driver.RecruitDriver.client_id value)
              }
