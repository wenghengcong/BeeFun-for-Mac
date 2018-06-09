//
//  GetAllLangResponse.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/18.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class GetAllLangResponse: BeeFunResponseModel {
    
    var data: [ObjLanguage]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}
