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
    var themeType: BFTheme = .day
    
    func combineImageName(prefix: IconArea?, iconName: String, selected: Bool) -> String {
        var imgName = ""
        if prefix != nil {
            let prefixStr = prefix!.rawValue
            if selected {
                imgName = prefixStr + "_" + themeType.rawValue + "_" + iconName+"_sel"
            } else {
                imgName = prefixStr + "_" + themeType.rawValue + "_" + iconName
            }
        } else {
            if selected {
                imgName =  "_" + themeType.rawValue + "_" + iconName + "_sel"
            } else {
                imgName =  "_" + themeType.rawValue + "_" + iconName
            }
        }
        
        return imgName
    }
    
}
