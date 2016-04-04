-- | Contains database functions primarily concerned with the User Entity,
-- except for those concerned with User creation, such as 'createUser' and
-- 'createMinimalUser', which are defined instead in Foundation so that they can
-- be used in code there to create users in the Authentication process.
--
-- We cannot define them here and then import those into Foundation without
-- creating a cycle, as the Import module imports Foundation.
module Model.User where

import Import
