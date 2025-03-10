{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Gateway.ProjectGateway where

import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.UUID (toString)
import Domain.Client (ClientId (..))
import Domain.Project (Project (..), ProjectId (..))
import Driver.ProjectDriver (ProjectEntity (..), list)
import Port.ProjectPort (ProjectPort (..))

newtype ProjectGateway m a = ProjectGateway {runProjectGateway :: m a}
  deriving (Functor, Applicative, Monad, MonadIO)

instance (MonadIO m) => ProjectPort (ProjectGateway m) where
  list = ProjectGateway $ do
    recruit <- liftIO $ Driver.ProjectDriver.list
    return $ map toDomain recruit
    where
      toDomain value =
        Project
          { projectId = ProjectId $ toString (Driver.ProjectDriver.project_id value),
            Domain.Project.title = Driver.ProjectDriver.title value,
            clientId = ClientId $ toString (Driver.ProjectDriver.client_id value)
          }
