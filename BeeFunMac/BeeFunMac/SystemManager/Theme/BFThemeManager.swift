//
//  BFThemeManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/28.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
enum BFTheme: String {
    case day = "day"
    case night = "night"
    case blue = "blue"
}

class BFThemeManager: NSObject {
    
    static let shared = BFThemeManager()
    var themeType: BFTheme = .blue
    
}
