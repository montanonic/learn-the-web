-- | This module contains custom data types that will be used in defining some
-- of our Persistent entities in `config/models`.
module Model.Persistent where

import Prelude
import Database.Persist.TH

-- | We want the framework options to be hard-coded, rather than user-submitted.
data Framework
    = YesodFramework
    | ServantFramework
    | ScottyFramework
    | HappstackFramework
    | SpockFramework
    | SnapFramework
    | MFlowFramework
    deriving (Show, Read, Eq)
derivePersistField "Framework"
