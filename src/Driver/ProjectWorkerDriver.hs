{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Driver.ProjectWorkerDriver where

import Data.ByteString.Char8 (unpack)
import Data.Text (Text, pack)
import Data.UUID (UUID)
import Data.UUID.Orphans ()
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.FromRow
import Driver.DB (conn)

data RecruitStage = Apply | First | Second
  deriving (Show, Eq)

instance FromField RecruitStage where
  fromField f mdata = do
    -- recruit_stage型か確認
    tn <- typename f
    if tn == "recruit_stage"
      then case mdata of
        Just bs -> case unpack bs of
          "apply" -> pure Apply
          "first" -> pure First
          "second" -> pure Second
          _ -> returnError ConversionFailed f "Invalid recruit stage"
        Nothing -> returnError UnexpectedNull f "Expected a recruit_stage, but got NULL"
      else returnError Incompatible f "Expected recruit_stage type"

data ProjectWorkerDriverEntity = ProjectWorkerDriverEntity
  { worker_id :: UUID,
    budget :: Int,
    project_stage :: RecruitStage,
    user_name :: String
  }
  deriving (Show)

instance FromRow ProjectWorkerDriverEntity where
  fromRow = ProjectWorkerDriverEntity <$> field <*> field <*> field <*> field

list :: String -> String -> IO [ProjectWorkerDriverEntity]
list cli_id rec_id = do
  connection <- conn
  query
    connection
    "SELECT pa.applicant_id as worker_id, pa.budget, ls.stage as project_stage, u.name as user_name \
    \ FROM project_applies pa \
    \ join users u on u.user_id = pa.applicant_id \
    \ JOIN ( \
    \ SELECT apply_id, stage \
    \ from project_applicant_stage_histories \
    \ order by staged_at desc limit 1 \
    \ ) ls ON ls.apply_id = pa.apply_id \
    \ join recruits r on r.recruit_id = pa.project_id \
    \ WHERE r.client_id = ? AND pa.project_id = ?"
    (cli_id, rec_id) ::
    IO [ProjectWorkerDriverEntity]
