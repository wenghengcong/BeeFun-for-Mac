//
//  JSSQLiteSwiftBridge.swift
//  BeeFun
//
//  Created by WengHengcong on 22/05/2017.
//  Copyright © 2017 JungleSong. All rights reserved.
//

import AppKit
import  SQLite

class JSSQLiteSwiftBridge: NSObject {
    
    /// 数据库名称
    var dbName: String?
    
    /// 数据库路径
    var dbPath: String?
    
    /// 连接数据库
    ///
    /// - Returns: <#return value description#>
    func connection(tmp: Bool) -> Connection {
        assert((dbName != nil) || (dbPath != nil))
        if dbName != nil {
            return connection(name: dbName!, tmp: tmp)
        } else if dbPath != nil {
            return connection(path: dbPath!, tmp: tmp)
        } else {
            dbName = "db.sqlite3"
            return connection(name: dbName!, tmp: tmp)
        }
    }
    
    func connection(name: String, tmp: Bool) -> Connection {
        assert(!name.isEmpty)
        var dbpath = BFPathManager.shared.localDocumentURL(fileName: name)?.absoluteString
        if tmp {
            dbpath = BFPathManager.shared.unZipGetSqliteFilePath()?.absoluteString
        }
        return connection(path: dbpath!, tmp: tmp)
    }
    
    func connection(path: String, tmp: Bool) -> Connection {
        assert(!path.isEmpty)
        let db = try! Connection(path)
        return db
    }
}
