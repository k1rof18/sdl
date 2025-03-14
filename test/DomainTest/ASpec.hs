{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module DomainTest.ASpec (spec) where

import Data.Time.Calendar (fromGregorian)
import Domain.ApplyStageUser
  ( ProjectInfo (..),
    ProjectStage (ApplyStage, FirstStage),
    StageUser (ApplyStageUser, FirstStageUser),
    UserAllInfo (..),
    toProjectUser,
  )
import Domain.ProjectApplicant (PrivateInfo (..))
import Domain.Worker (WorkerId (WorkerId))
import Test.Hspec (Spec, describe, it, shouldBe)

projectInfo :: ProjectStage -> ProjectInfo
projectInfo = ProjectInfo (fromGregorian 2022 1 1)

spec :: Spec
spec = do
  describe "応募者の情報を選考段階に応じて絞ることができる" $ do
    let userAllInfo :: UserAllInfo
        userAllInfo =
          UserAllInfo
            { workerId = WorkerId "1",
              privateInfo = PrivateInfo "nickname" (fromGregorian 2022 1 1)
            }

    it "応募段階では、応募者のIDと完了予定日を閲覧できること" $ do
      let actual :: StageUser
          actual = toProjectUser userAllInfo (projectInfo ApplyStage)

      let expected :: StageUser
          expected = ApplyStageUser (WorkerId "1") (fromGregorian 2022 1 1)
      expected `shouldBe` actual

    it "1次選考段階では、応募者のID、完了予定日、ニックネームを閲覧できること" $ do
      let actual :: StageUser
          actual = toProjectUser userAllInfo (projectInfo FirstStage)

      let expected :: StageUser
          expected = FirstStageUser (WorkerId "1") (fromGregorian 2022 1 1) (PrivateInfo "nickname" (fromGregorian 2022 1 1))
      expected `shouldBe` actual