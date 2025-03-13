{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module DomainTest.ASpec (spec) where

import Data.Time.Calendar (fromGregorian)
import Domain.ApplyStageUser (ProjectInfo (..), StageUser (ApplyStageUser), UserAllInfo (..), toApplyStageUser)
import Domain.Worker (WorkerId (WorkerId))
import Test.Hspec (Spec, describe, it, shouldBe)

spec :: Spec
spec = do
  describe "応募者の情報を選考段階に応じて絞ることができる" $ do
    it "応募段階では、応募者のIDと完了予定日を閲覧できること" $ do
      let actual :: StageUser
          actual =
            toApplyStageUser
              (UserAllInfo {workerId = WorkerId "1"})
              (ProjectInfo {estimatedEndDate = (fromGregorian 2022 1 1)})

      let expected :: StageUser
          expected = ApplyStageUser (WorkerId "1") ((fromGregorian 2022 1 1))
      expected `shouldBe` actual
