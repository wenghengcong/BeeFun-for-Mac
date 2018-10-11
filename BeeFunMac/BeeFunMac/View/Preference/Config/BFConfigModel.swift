//
//  BFConfigModel.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class BFConfigModel: NSObject, Mappable {
    
    var cg_key: String?
    var cg_value: String?
    var cg_version: String?
    var created_at: String?
    var updated_at: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        //                super.mapping(map)
        cg_key <- map["cg_key"]
        cg_value <- map["cg_value"]
        cg_version <- map["cg_version"]
        created_at <- map["created_at"]
        created_at <- map["created_at"]
    }
}
