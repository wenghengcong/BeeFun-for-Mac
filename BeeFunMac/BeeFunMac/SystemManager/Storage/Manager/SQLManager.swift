//
//  SQLManager.swift
//  BeeFun
//
//  Created by WengHengcong on 19/05/2017.
//  Copyright © 2017 JungleSong. All rights reserved.
//

import AppKit
import SQLite

enum SQLiteError: Error {
    case connecttion
}

enum SQLiteAction: Int {
    case insert
    case update
    case delete
    case query
}

struct SQLManager {
    
    #if DEBUG
    static let githubDatabaseName = "github_debug.sqlite3"
    #else
    static let githubDatabaseName = "github.sqlite3"
    #endif
    
    static func createAllTables() {
        //建表
        SQLStars.crateStarReposTable()
        SQLTags.crateStarTagsTable()
    }
    
    static func githubDB(tmp: Bool) -> Connection {
        let sqlBridge = JSSQLiteSwiftBridge()
        sqlBridge.dbName = githubDatabaseName
        return sqlBridge.connection(tmp: tmp)
    }
    
    static func checkDBValid( completion: () -> Void) {
        if let url = BFPathManager.shared.localDocumentURL(fileName: SQLManager.githubDatabaseName), !FileManager.default.fileExists(atPath: url.path) {
            //无本地数据库，开始下载创建本地数据库
            SQLManager.createAllTables()
        } else if !self.checkTableExist(SQLStars.starTableName) || !self.checkTableExist(SQLTags.starTagsName) {
            
            //先移除当前的非正常的db
            if let url = BFPathManager.shared.localDocumentURL(fileName: SQLManager.githubDatabaseName)
            {
                do {
                    try FileManager.default.removeItem(atPath: url.path)
                } catch {}
                //有本地数据库，则重新下载最新数据
                SQLStars.crateStarReposTable()
                SQLTags.crateStarTagsTable()
            }
        }
        completion()
    }
    
    static func checkTableExist(_ tableName: String) -> Bool {
        return SQLManager.githubDB(tmp: false).tableExists(tableName: tableName)
    }
    
    static func compareDatabase() {
        
        if !fileExists(BFPathManager.shared.localGetSqliteFilePath() ) {
            //本地没有githu数据库，直接拷贝
            if let tmp = BFPathManager.shared.unZipGetSqliteFilePath(), let local = BFPathManager.shared.localGetSqliteFilePath() {
                do {
                    try FileManager.default.copyItem(atPath: tmp.path, toPath: local.path)
                    print("Move unzip tmp db to local db")
                } catch {
                    print("Move unzip tmp db to local db failure :\n\((error as NSError).description)")
                }
            }
            return
        }
        //找到云端数据库所有打tag的repo
        let tmpTagStarFromTmpDB = SQLStars.findAllTagStar(tmp: true)
        if tmpTagStarFromTmpDB == nil || tmpTagStarFromTmpDB!.isEmpty {
            return
        }
        for repo in tmpTagStarFromTmpDB! {
            if let tmpID = repo.id {
                if let findTheRepoFromDB = SQLStars.find(id: tmpID), let pendAddTags = repo.star_tags {
                    if let haveTags = findTheRepoFromDB.star_tags {
                        for tag in pendAddTags {
                            SQLTags.insert(tag: tag, tmp: false)
                        }
                        SQLStars.update(repo: findTheRepoFromDB, tags: haveTags)
                    } else {
                        SQLStars.update(repo: findTheRepoFromDB, tags: pendAddTags)
                    }

                }
            }
        }
    }
    
    static func fileExists(_ path: URL?) -> Bool {
        if let filePath = path {
            if FileManager.default.fileExists(atPath: filePath.path) {
                return true
            }
        }
        return false
    }
}
