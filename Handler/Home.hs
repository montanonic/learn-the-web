module Handler.Home where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
    withAutofocus, withPlaceholder, bfs, bootstrapSubmit, BootstrapSubmit
    , withLargeInput)

getHomeR :: Handler Html
getHomeR = defaultLayout $(widgetFile "home")

{-
homepageLayout = defaultLayout $ do
    ((res, formWidget), formEnctype) <- runFormPost userForm
    mmsg <- getMessage
    setTitle "Welcome!"
    $(widgetFile "home")

getHomeR :: Handler Html
getHomeR = homepageLayout

data UserForm = UserForm { name :: Text } deriving Show

userForm :: Form UserForm
userForm = renderBootstrap3 BootstrapBasicForm $ UserForm
       <$> areq textField nameSettings Nothing
       <*  bootstrapSubmit ("Register" :: BootstrapSubmit Text)
    where nameSettings = withPlaceholder "First name" (bfs ("Name" :: Text))

postHomeR :: Handler Html
postHomeR = do
    now <- liftIO getCurrentTime

    ident <- case res of
        FormSuccess a -> return $ name a
        FormFailure failures -> do
            setMessage $
                preEscapedToMarkup . mconcat $ failures
            return "()"
        FormMissing -> return "form missing"

    muid <- runDB $ createMinimalUser ident ident now

    case muid of
        Nothing -> do
            addMessage "error" [shamlet|
A user with your username or unique identification already exists.
|]
            homepageLayout
        Just _ -> homepageLayout
-}
