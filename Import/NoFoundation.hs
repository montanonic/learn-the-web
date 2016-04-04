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

-- Import-space code:

--
-- ** Messaging/Alerts
-- Based on http://bootstrapdocs.com/v3.3.6/docs/components/#alerts
--

addMessageSuccess, addMessageInfo, addMessageWarning, addMessageDanger
    :: MonadHandler m => Html -> m ()

addMessageSuccess = addMessage "success"
addMessageInfo = addMessage "info"
addMessageWarning = addMessage "warning"
addMessageDanger = addMessage "danger"

-- | Transform a raw string of Text (that is, formatted according to how it
-- appears in code) as a single string of Text. This allows for using the
-- multiline string quasiquoters, such as [r| |], to avoid having to add line
-- breaks with an escape character manually, while also keeping the Text in the
-- simplistic single line format, with no carriage returns.
asSingleLine :: Text -> Text
asSingleLine = mconcat . ((++ " ") <$>) . lines

--
-- ** Maybe utilities, courtesy of
-- http://haddock.stackage.org/lts-5.9/Agda-2.4.2.5/src/Agda-Utils-Maybe.html#fromMaybeM
--

-- | Version of 'maybe' with different argument ordering.
--   Often, we want to case on a 'Maybe', do something interesting
--   in the 'Just' case, but only a default action in the 'Nothing'
--   case.  Then, the argument ordering of @caseMaybe@ is preferable.
--
--   @caseMaybe m d f = flip (maybe d) m f@
caseMaybe :: Maybe a -> b -> (a -> b) -> b
caseMaybe m d f = maybe d f m

-- | Monadic version of 'maybe'.

maybeM :: Monad m => m b -> (a -> m b) -> m (Maybe a) -> m b
maybeM n j mm = maybe n j =<< mm

-- | Monadic version of 'fromMaybe'.

fromMaybeM :: Monad m => m a -> m (Maybe a) -> m a
fromMaybeM m mm = maybeM m return mm

-- | Monadic version of 'caseMaybe'.
--   That is, 'maybeM' with a different argument ordering.
caseMaybeM :: Monad m => m (Maybe a) -> m b -> (a -> m b) -> m b
caseMaybeM mm d f = maybeM d f mm

-- | 'caseMaybeM' with flipped branches.
ifJustM :: Monad m => m (Maybe a) -> (a -> m b) -> m b -> m b
ifJustM mm = flip (caseMaybeM mm)

-- | A more telling name for 'Traversable.forM_' for the 'Maybe' collection type.
--   Or: 'caseMaybe' without the 'Nothing' case.
whenJust :: Monad m => Maybe a -> (a -> m ()) -> m ()
whenJust m k = caseMaybe m (return ()) k

-- | 'caseMaybe' without the 'Just' case.
whenNothing :: Monad m => Maybe a -> m () -> m ()
whenNothing m d = caseMaybe m d (\_ -> return ())

-- | 'caseMaybeM' without the 'Nothing' case.
whenJustM :: Monad m => m (Maybe a) -> (a -> m ()) -> m ()
whenJustM c m = c >>= (`whenJust` m)

-- | 'caseMaybeM' without the 'Just' case.
whenNothingM :: Monad m => m (Maybe a) -> m () -> m ()
whenNothingM mm d = mm >>= (`whenNothing` d)
