//
//  BFExploreNavigationModel.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/6.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class BFExploreNavigationModel: NSObject, Mappable {
    var logo: String?
    var title: String?
    var desc: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        logo <- map["logo"]
        title <- map["title"]
        desc <- map["desc"]
    }
}
