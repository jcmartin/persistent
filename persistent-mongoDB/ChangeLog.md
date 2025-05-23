# Changelog for persistent-mongoDB

## 2.14.0.0
* MongoDB authentication now allows specifying which database to authenticate against, which may be different from the database that one normally needs to access.

## 2.13.1.0

* Restore update write concern behavior with MongoDB Driver for MongoDB >= 6.0 [#1550](https://github.com/yesodweb/persistent/pull/1550)

## 2.13.0.2

* Fix behavioral compatibility with MongoDB Driver for MongoDB >= 6.0 [#1545](https://github.com/yesodweb/persistent/pull/1545)

## 2.13.0.1

* [#1367](https://github.com/yesodweb/persistent/pull/1367),
  [#1366](https://github.com/yesodweb/persistent/pull/1367),
  [#1338](https://github.com/yesodweb/persistent/pull/1338),
  [#1335](https://github.com/yesodweb/persistent/pull/1335)
    * Support GHC 9.2

## 2.13.0.0

* Fix persistent 2.13 changes [#1286](https://github.com/yesodweb/persistent/pull/1286)

## 2.12.0.0

* Decomposed `HaskellName` into `ConstraintNameHS`, `EntityNameHS`, `FieldNameHS`. Decomposed `DBName` into `ConstraintNameDB`, `EntityNameDB`, `FieldNameDB` respectively. [#1174](https://github.com/yesodweb/persistent/pull/1174)

## 2.11.0

* Naive implementation of `exists` function from `PersistQueryRead` type class using `count`. [#1131](https://github.com/yesodweb/persistent/pull/1131/files)

## 2.10.0.1

* Remove unnecessary deriving of Typeable [#1114](https://github.com/yesodweb/persistent/pull/1114)

## 2.10.0.0

* Fix `ninList` filter operator [#1058](https://github.com/yesodweb/persistent/pull/1058)

## 2.9.0.2

* Compatibility with latest mongoDB [#1012](https://github.com/yesodweb/persistent/pull/1012)

## 2.9.0.1

* Compatibility with latest persistent-template for test suite [#1002](https://github.com/yesodweb/persistent/pull/1002/files)

## 2.9.0

* Removed deprecated `entityToDocument`. Please use `recordToDocument` instead. [#894](https://github.com/yesodweb/persistent/pull/894)
* Removed deprecated `multiBsonEq`. Please use `anyBsonEq` instead. [#894](https://github.com/yesodweb/persistent/pull/894)
* Use `portID` from `mongoDB` instead of `network`. [#946](https://github.com/yesodweb/persistent/pull/946)

## 2.8.0

* Switch from `MonadBaseControl` to `MonadUnliftIO`

## 2.6.0

* Fix upsert behavior [#613](https://github.com/yesodweb/persistent/issues/613)
* Relax bounds for http-api-data

## 2.5

* changes for read/write typeclass split

## 2.1.4

* support http-api-data for url serialization

## 2.1.3

* Add list filtering functions `inList` and `ninList`

## 2.1.2

* Add `nestAnyEq` filter function
* Add `FromJSON` instance for `MongoConf`
