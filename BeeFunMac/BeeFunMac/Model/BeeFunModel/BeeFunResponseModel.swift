//
//  BeeFunResponseModel.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/3.
//  Copyright © 2018年 JungleSong. All rights reserved.
//

import AppKit
import ObjectMapper

class BeeFunResponseModel<T: Mappable>: NSObject, Mappable {
    
    var code: Int?
    var codeEnum: BFStatusCode?
    var msg: String?
    var data: [T]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
//                super.mapping(map)
        code <- map["code"]
        if code != nil {
            codeEnum = BFStatusCode(rawValue: code!)
        }
        msg <- map["msg"]
        data <- map["data"]
    }
}
