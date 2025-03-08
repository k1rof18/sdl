{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveFunctor #-}

module UseCaseTest.GetRecruitSpec (spec) where

import Test.Hspec
import UseCase.GetRecruit (exec)
import Domain.Recruit (Recruit(..), RecruitId(..), Skill(..))
import Port.RecruitPort (RecruitPort(..))
import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.IORef

newtype MockRecruitGateway a = MockRecruitGateway { runMockRecruitGateway :: IO a }
  deriving (Functor, Applicative, Monad, MonadIO)

instance RecruitPort MockRecruitGateway where
  find recruitId = MockRecruitGateway $ do
    if recruitId == RecruitId "1"
      then return $ Just $ Recruit (RecruitId "1") "Software Engineer" "We are looking for a FP software engineer" [Haskell, Clojure]
      else return Nothing

spec :: Spec
spec = do
  describe "GetRecruit" $ do
    it "should return a recruit when it exists" $ do
      let result = runMockRecruitGateway $ exec (RecruitId "1")
      recruit <- result
      recruit `shouldBe` Just (Recruit (RecruitId "1") "Software Engineer" "We are looking for a FP software engineer" [Haskell, Clojure])

    it "should return Nothing when recruit doesn't exist" $ do
      let result = runMockRecruitGateway $ exec (RecruitId "non-exist")
      recruit <- result
      recruit `shouldBe` Nothing

    it "should call find method of RecruitPort" $ do
      callCount <- newIORef 0
      
      let mockFind recruitId = MockRecruitGateway $ do
            liftIO $ modifyIORef callCount (+1)
            if recruitId == RecruitId "1"
              then return $ Just $ Recruit (RecruitId "1") "Software Engineer" "We are looking for a FP software engineer" [Haskell, Clojure]
              else return Nothing
      
      let mockGateway = MockRecruitGateway { runMockRecruitGateway = runMockRecruitGateway $ mockFind (RecruitId "1") }
      
      _ <- runMockRecruitGateway mockGateway
      
      count <- readIORef callCount
      count `shouldBe` 1
