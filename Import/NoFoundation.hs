module Import.NoFoundation
    ( module Import.NoFoundation
    ) where

import ClassyPrelude.Yesod   as Import.NoFoundation
import Model                 as Import.NoFoundation
import Settings              as Import.NoFoundation
import Settings.StaticFiles  as Import.NoFoundation
import Yesod.Auth            as Import.NoFoundation
import Yesod.Core.Types      as Import.NoFoundation (loggerSet)
import Yesod.Default.Config2 as Import.NoFoundation

-- modules not originally part of the scaffolding:

addMessageSuccess, addMessageInfo, addMessageWarning, addMessageDanger
    :: MonadHandler m => Html -> m ()

addMessageSuccess = addMessage "success"
addMessageInfo = addMessage "info"
addMessageWarning = addMessage "warning"
addMessageDanger = addMessage "danger"
