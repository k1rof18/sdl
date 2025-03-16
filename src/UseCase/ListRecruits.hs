module UseCase.ListRecruits (exec) where

import Domain.Recruit (Recruit)
import Port.RecruitPort (RecruitPort (..))

exec :: (RecruitPort m) => m [Recruit]
exec = list