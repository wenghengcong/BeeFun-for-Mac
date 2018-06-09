//
//  ObjResponser.swift
//  BeeFun
//
//  Created by wenghengcong on 16/1/31.
//  Copyright © 2016年 JungleSong. All rights reserved.
//

import Cocoa
import ObjectMapper

/*

status code: 200, 
headers {
}

*/
class ObjResponser: NSObject, Mappable {

    var statusCode: Int?
    var headers: ObjResponseHeader?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)
        statusCode <- map["status code"]
        headers <- map["headers"]

    }
}
