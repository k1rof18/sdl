{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Gateway.RecruitGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Recruit (Recruit (..), RecruitType (Project), toRecruitType)
import Domain.Stage (toStage)
import Driver.RecruitDriver (RecruitDriverEntity (..), list)
import Port.RecruitPort (RecruitPort (..))

newtype RecruitGateway m a = RecruitGateway {runRecruitGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => RecruitPort (RecruitGateway m) where
  list = RecruitGateway $ do
    recruits <- liftIO Driver.RecruitDriver.list
    return $ map toDomain recruits
    where
      toDomain value =
        Recruit
          { recruitId = toString $ _recruit_id value,
            title = _title value,
            recruitType = toRecruitType (_recruitType value),
            stage = toStage (_stage value)
          }
