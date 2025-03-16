module UseCase.ListApplyingRecruits (exec) where

import Domain.Recruit (FilteredStageRecruit, toFilteredStageRecruits, toRecruitIn)
import Domain.Stage (Stage (ApplyStage))
import Port.RecruitPort (RecruitPort (..))

exec :: (RecruitPort m) => m [FilteredStageRecruit]
exec = do
  toFilteredStageRecruits ApplyStage . map toRecruitIn <$> list
