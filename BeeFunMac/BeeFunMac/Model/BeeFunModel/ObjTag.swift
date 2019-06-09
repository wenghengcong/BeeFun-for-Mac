//
//  ObjTagModel.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/3.
//  Copyright © 2018年 JungleSong. All rights reserved.
//

import AppKit
import ObjectMapper

public class ObjTag: NSObject, Mappable, NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let newCopy = ObjTag()
        newCopy.name = name
        newCopy.owner = owner
        newCopy.count = count
        newCopy.sort = sort
        newCopy.repos = repos
        newCopy.createdAt = createdAt
        newCopy.updatedAt = updatedAt
        return newCopy
    }
    
    var name: String?
    var owner: String?
    var count: Int?
    var sort: Int?
    var repos: String?
    var createdAt: Int64?
    var updatedAt: Int64?
    
    required public init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        name <- map["name"]
        owner <- map["owner"]
        count <- map["count"]
        sort <- map["sort"]
        repos <- map["repos"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
}
