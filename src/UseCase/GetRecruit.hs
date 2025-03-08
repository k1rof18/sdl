{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module UseCase.GetRecruit where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Control.Monad.RWS (MonadState (put))
import Domain.Recruit (Recruit (recruitId), RecruitId (..))
import Port.RecruitPort (RecruitPort (..))
import Text.Printf (printf)

exec :: (RecruitPort m, MonadIO m) => RecruitId -> m (Maybe Recruit)
exec recruitId = do
  liftIO $ print "====== exec called ======="
  liftIO $ putStrLn $ printf "RecruitId: %s" (show recruitId)
  find recruitId