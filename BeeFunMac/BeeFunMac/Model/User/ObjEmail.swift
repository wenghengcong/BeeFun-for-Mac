//
//  ObjEmail.swift
//  BeeFun
//
//  Created by WengHengcong on 16/1/25.
//  Copyright © 2016年 JungleSong. All rights reserved.
//

import Cocoa
import ObjectMapper

class ObjEmail: NSObject, Mappable {

    var email: String?
    var primary: Bool?
    var verified: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)
        email <- map["email"]
        primary <- map["primary"]
        verified <- map["verified"]
    }

}
