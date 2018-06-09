//
//  ObjLanguage.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/18.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class ObjLanguage: NSObject, Mappable, NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let newCopy = ObjLanguage()
        newCopy.language = language
        newCopy.num = num
        return newCopy
    }
    
    var language: String?
    var num: Int?
    
    required public init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        language <- map["language"]
        num <- map["num"]
    }
}
