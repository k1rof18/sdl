module Port.RecruitPort (RecruitPort, list) where

import Domain.Recruit (Recruit)

class (Monad m) => RecruitPort m where
  list :: m [Recruit]
