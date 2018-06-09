//
//  ObjLabel.swift
//  BeeFun
//
//  Created by WengHengcong on 2/23/16.
//  Copyright © 2016 JungleSong. All rights reserved.
//
/**
*
"url": "https://api.github.com/repos/octocat/Hello-World/labels/bug",
"name": "bug",
"color": "f29513"
*/

import Cocoa
import ObjectMapper

class ObjLabel: NSObject, Mappable {
    var url: String?
    var name: String?
    var color: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)

        url <- map["url"]
        name <- map["name"]
        color <- map["color"]

    }
}
