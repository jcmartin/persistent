-- | An 'EntityDef' represents metadata about a type that @persistent@ uses to
-- store the type in the database, as well as generate Haskell code from it.
--
-- @since 2.13.0.0
module Database.Persist.EntityDef
    ( -- * The 'EntityDef' type
      EntityDef
      -- * Construction
      -- * Accessors
    , getEntityHaskellName
    , getEntityDBName
    , getEntityFields
    , getEntityFieldsDatabase
    , getEntityForeignDefs
    , getEntityUniques
    , getEntityUniquesNoPrimaryKey
    , getEntityId
    , getEntityIdField
    , getEntityKeyFields
    , getEntityComments
    , getEntityExtra
    , getEntitySpan
    , isEntitySum
    , entityPrimary
    , entitiesPrimary
    , keyAndEntityFields
    , keyAndEntityFieldsDatabase
     -- * Setters
    , setEntityId
    , setEntityIdDef
    , setEntityDBName
    , overEntityFields
      -- * Related Types
    , EntityIdDef(..)
    ) where

import Data.List.NonEmpty (NonEmpty)
import Data.Map (Map)
import Data.Text (Text)

import Database.Persist.EntityDef.Internal
import Database.Persist.FieldDef

import Database.Persist.Names
import Database.Persist.Types.Base
       (ForeignDef, Span, UniqueDef(..), entityKeyFields)

-- | Retrieve the list of 'UniqueDef' from an 'EntityDef'. This does not include
-- a @Primary@ key, if one is defined. A future version of @persistent@ will
-- include a @Primary@ key among the 'Unique' constructors for the 'Entity'.
--
-- @since 2.14.0.0
getEntityUniquesNoPrimaryKey
    :: EntityDef
    -> [UniqueDef]
getEntityUniquesNoPrimaryKey ed =
    filter isNotPrimaryKey $ entityUniques ed
  where
    isNotPrimaryKey ud =
        let
            constraintName = unConstraintNameHS $ uniqueHaskell ud
         in
            constraintName /= unEntityNameHS (getEntityHaskellName ed) <> "PrimaryKey"

-- | Retrieve the list of 'UniqueDef' from an 'EntityDef'.  As of version 2.14,
-- this will also include the primary key on the entity, if one is defined. If
-- you do not want the primary key, see 'getEntityUniquesNoPrimaryKey'.
--
-- @since 2.13.0.0
getEntityUniques
    :: EntityDef
    -> [UniqueDef]
getEntityUniques =
    entityUniques

-- | Retrieve the Haskell name of the given entity.
--
-- @since 2.13.0.0
getEntityHaskellName
    :: EntityDef
    -> EntityNameHS
getEntityHaskellName = entityHaskell

-- | Return the database name for the given entity.
--
-- @since 2.13.0.0
getEntityDBName
    :: EntityDef
    -> EntityNameDB
getEntityDBName = entityDB

getEntityExtra :: EntityDef -> Map Text [[Text]]
getEntityExtra = entityExtra

-- |
--
-- @since 2.13.0.0
setEntityDBName :: EntityNameDB -> EntityDef -> EntityDef
setEntityDBName db ed = ed { entityDB = db }

getEntityComments :: EntityDef -> Maybe Text
getEntityComments = entityComments

-- |
--
-- @since 2.13.0.0
getEntityForeignDefs
    :: EntityDef
    -> [ForeignDef]
getEntityForeignDefs = entityForeigns

-- | Retrieve the list of 'FieldDef' that makes up the fields of the entity.
--
-- This does not return the fields for an @Id@ column or an implicit @id@. It
-- will return the key columns if you used the @Primary@ syntax for defining the
-- primary key.
--
-- This does not return fields that are marked 'SafeToRemove' or 'MigrationOnly'
-- - so it only returns fields that are represented in the Haskell type. If you
-- need those fields, use 'getEntityFieldsDatabase'.
--
-- @since 2.13.0.0
getEntityFields
    :: EntityDef
    -> [FieldDef]
getEntityFields = filter isHaskellField . entityFields

-- | This returns all of the 'FieldDef' defined for the 'EntityDef', including
-- those fields that are marked as 'MigrationOnly' (and therefore only present
-- in the database) or 'SafeToRemove' (and a migration will drop the column if
-- it exists in the database).
--
-- For all the fields that are present on the Haskell-type, see
-- 'getEntityFields'.
--
-- @since 2.13.0.0
getEntityFieldsDatabase
    :: EntityDef
    -> [FieldDef]
getEntityFieldsDatabase = entityFields

-- |
--
-- @since 2.13.0.0
isEntitySum
    :: EntityDef
    -> Bool
isEntitySum = entitySum

-- |
--
-- @since 2.13.0.0
getEntityId
    :: EntityDef
    -> EntityIdDef
getEntityId = entityId

-- |
--
-- @since 2.13.0.0
getEntityIdField :: EntityDef -> Maybe FieldDef
getEntityIdField ed =
    case getEntityId ed of
        EntityIdField fd ->
            pure fd
        _ ->
            Nothing

-- | Set an 'entityId' to be the given 'FieldDef'.
--
-- @since 2.13.0.0
setEntityId
    :: FieldDef
    -> EntityDef
    -> EntityDef
setEntityId fd = setEntityIdDef (EntityIdField fd)

-- |
--
-- @since 2.13.0.0
setEntityIdDef
    :: EntityIdDef
    -> EntityDef
    -> EntityDef
setEntityIdDef i ed = ed { entityId = i }

-- |
--
-- @since 2.13.0.0
getEntityKeyFields
    :: EntityDef
    -> NonEmpty FieldDef
getEntityKeyFields = entityKeyFields

-- | TODO
--
-- @since 2.13.0.0
setEntityFields :: [FieldDef] -> EntityDef -> EntityDef
setEntityFields fd ed = ed { entityFields = fd }

-- | Perform a mapping function over all of the entity fields, as determined by
-- 'getEntityFieldsDatabase'.
--
-- @since 2.13.0.0
overEntityFields
    :: ([FieldDef] -> [FieldDef])
    -> EntityDef
    -> EntityDef
overEntityFields f ed =
    setEntityFields (f (getEntityFieldsDatabase ed)) ed

-- | Gets the 'Span' of the definition of the entity.
--
-- Note that as of this writing the span covers the entire file or quasiquote
-- where the item is defined due to parsing limitations. This may be changed in
-- a future release to be more accurate.
--
-- @since 2.15.0.0
getEntitySpan :: EntityDef -> Maybe Span
getEntitySpan = entitySpan
