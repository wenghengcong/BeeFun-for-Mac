//
//  ObjSearchReposResponse.swift
//  BeeFun
//
//  Created by WengHengcong on 4/9/16.
//  Copyright © 2016 JungleSong. All rights reserved.
//

import AppKit
import ObjectMapper

class SEResponseRepos: NSObject, Mappable {

    var totalCount: Int?
    var incompleteResults: Bool?
    var items: [ObjRepos]?

    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }

}
