//
//  ObjErropReponse.swift
//  BeeFun
//
//  Created by WengHengcong on 3/8/16.
//  Copyright © 2016 JungleSong. All rights reserved.
//

import Cocoa
import ObjectMapper

/*
{
"message": "Validation Failed",
"errors": [
{
"resource": "Search",
"field": "q",
"code": "missing"
}
],
"documentation_url": "https://developer.github.com/v3/search"
}

*/

class ObjErropReponse: NSObject, Mappable {

    var message: String?
    var errors: [ObjError]?
    var documentationUrl: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)
        message <- map["message"]
        errors <- map["errors"]
        documentationUrl <- map["documentation_url"]

    }

}
