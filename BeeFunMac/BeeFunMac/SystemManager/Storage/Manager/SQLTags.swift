//
//  SQLTags.swift
//  BeeFun
//
//  Created by WengHengcong on 02/06/2017.
//  Copyright © 2017 JungleSong. All rights reserved.
//

import AppKit
import SQLite

class SQLTags {
    
    static var retryCount: Int = 0
    static let starTagsName = "star_tags"
    fileprivate static let starTagsTable = Table(starTagsName)
    
    // MARK: - 字段
    /// name为唯一字段，不可重复，区分大小写
    fileprivate static let nameId = Expression<String>("name")
    /// 该tag下对应多少个repos
    fileprivate static let count = Expression<Int?>("count")
    /// 该tag下对应的repos，集合中为reposid
    fileprivate static let star_repos = Expression<SQLite.Blob?>("repos")
    /// order
    fileprivate static let tag_order = Expression<Int?>("tag_order")
}

extension SQLTags {
    /// 创建Star Repos
    static func crateStarTagsTable() {
        if retryCount > 3 {
            return
        }
        do {
            try SQLManager.githubDB(tmp: false).run(starTagsTable.create(ifNotExists: true) { (t) in
                t.column(nameId, primaryKey: true)
                t.column(count)
                t.column(star_repos)
                t.column(tag_order)
            })
        } catch {
            retryCount += 1
            crateStarTagsTable()
            print(error)
        }
    }
}

// MARK: - 增/改
extension SQLTags {
    
    /// 插入一个repos对象
    static func insert(tagObj: ObjTag, tmp: Bool) {
        do {
            if check(name: tagObj.name!, tmp: tmp) {
                let filterRow = starTagsTable.filter(nameId == tagObj.name!)
                let rowid = try SQLManager.githubDB(tmp: tmp).run(filterRow.update([
                    count <- tagObj.count,
//                    tag_order <- tagObj.order,
//                    star_repos <- SQLHelper.SQLBlob(intarray: tagObj.repos!)
                    ]))
                
                print("tag updated id: \(rowid)")
            } else {
                let rowid = try SQLManager.githubDB(tmp: false).run(starTagsTable.insert([
                    nameId <- tagObj.name!,
                    count <- tagObj.count,
//                    tag_order <- tagObj.order,
//                    star_repos <- SQLHelper.SQLBlob(intarray: tagObj.repos!)
                    ]))
                print("tag inserted id: \(rowid)")
            }
        } catch {
            print("tag insertion failed: \(error)")
        }
    }
    
    /// 插入一个repos对象
    static func insert(tag: String, tmp: Bool) {
        if tag.isEmpty {
            return
        }
        let tagObj = ObjTag()
        tagObj.name = tag
        insert(tagObj: tagObj, tmp: tmp)
    }
    
    /// 重命名tag
    static func rename(oriTag: ObjTag, newTag: ObjTag) {
        do {
                try SQLManager.githubDB(tmp: false).transaction {
                    delete(tagObj: oriTag)
                    insert(tagObj: newTag, tmp: false)
                }
        } catch {
            
        }
    }
    
}

// MARK: - 检查tags是否存在
extension SQLTags {
    /// 检查该id是否已经存在
    static func check(name: String, tmp: Bool) -> Bool {
        let query = starTagsTable.where(name == nameId)
        let all = try? SQLManager.githubDB(tmp: tmp).prepare(query)
        if all != nil {
            for item in all! where (name == item[nameId]) {
                return true
            }
        }
        return false
    }
}

// MARK: - 查询
extension SQLTags {
    
    /// 根据顺序查找tags
    ///
    /// - Parameters:
    ///   - order: 顺序
    static func findAll(order: SQLOrder) -> [ObjTag]? {
        let query = starTagsTable.order((order == .asc ? tag_order.asc : tag_order.desc))
        var tagsArr: [ObjTag] = []
        do {
            let all = Array(try SQLManager.githubDB(tmp: false).prepare(query))
            for item in all {
                let tag = convertObjTags(item: item)
                tagsArr.append(tag)
            }
            return tagsArr
        } catch {
            print(error)
            return nil
        }

    }
    
    /// 查找全部tags
    static func findAll() -> [ObjTag]? {
        var tagsArr: [ObjTag] = []
        do {
            let all = Array(try SQLManager.githubDB(tmp: false).prepare(starTagsTable))
            for item in all {
                let tag = convertObjTags(item: item)
                tagsArr.append(tag)
            }
            return tagsArr
        } catch {
            print(error)
            return nil
        }
    }
    
    /// 查找全部tags，并获取字符串
    static func findAllByString() -> [String] {
        var tags: [String] = []
        if let all = findAll() {
            for item in all {
                tags.append(item.name!)
            }
        }
        return tags
    }
    
    /// 根据id查找repos对象
    static func find(name: String) -> ObjTag {
        let query = starTagsTable.where(nameId == name)
        let all = try? SQLManager.githubDB(tmp: false).prepare(query)
        var obj: ObjTag = ObjTag()
        if all != nil {
            for item in all! {
                obj = convertObjTags(item: item)
            }
        }
        return obj
    }
    
    static func convertObjTags(item: Row) -> ObjTag {
        let tag = ObjTag()
        tag.name = item[nameId]
        tag.count = item[count]
//        tag.order = item[tag_order]
//        tag.repos = SQLHelper.intArray(blob: item[star_repos])
        return tag
    }

}

// MARK: - 删
extension SQLTags {
    
    static func delete(name: String) {
        if name.isEmpty {
            return
        }
        let tagObj = ObjTag()
        tagObj.name = name
        delete(tagObj: tagObj)
    }
    
    static func delete(tagObj: ObjTag) {
        if tagObj.name!.isEmpty {
            return
        }
        let query = starTagsTable.filter(tagObj.name! == nameId)
        do {
            if try SQLManager.githubDB(tmp: false).run(query.delete()) > 0 {
                print("deleted tag id:\(String(describing: tagObj.name))")
            } else {
                print("not found tag id:\(String(describing: tagObj.name))")
            }
        } catch {
            print("delete tag failed: \(error)")
        }
    }
}
