{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO, liftIO) -- liftIO をインポート
import Data.Maybe (isNothing)
import Domain.Recruit (Recruit (..), RecruitId (..))
import Driver.RecruitDriver (getById)
import Port.RecruitPort (RecruitPort (..))

newtype RecruitGateway m a = RecruitGateway {runRecruitGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => RecruitPort (RecruitGateway m) where
  find (RecruitId recruitId) = RecruitGateway $ do
    r <- liftIO $ getById recruitId
    if isNothing r
      then return Nothing
      else return $ Just $ Recruit {recruitId = RecruitId "1", title = "Software Engineer"}
