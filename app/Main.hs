module Main (main) where

import Domain.Recruit (RecruitId (..))
import Gateway.RecruitGateway (RecruitGateway (..), runRecruitGateway)
import UseCase.GetRecruit (exec)

getRecruit :: String -> IO ()
getRecruit recruitId = do
  let gateway = runRecruitGateway
  result <- gateway $ exec (RecruitId recruitId)
  case result of
    Just recruit -> print recruit -- Recruit が見つかった場合、表示
    Nothing -> putStrLn "Recruit not found" -- Recruit が見つからない場合、メッセージ表示

main :: IO ()
main = do
  print "========================"
  getRecruit "f47b1b3e-7f3b-4b0b-8b3d-3b1b1f3b7b45"
  print "========================"
  getRecruit "d20fa5f5-7b96-1ff1-d8b3-f7565aeecbb7"
