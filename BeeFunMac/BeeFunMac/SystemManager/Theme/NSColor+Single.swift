//
//  NSColor+Single.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/14.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    
    // 黑色
    class var iBlack: NSColor {
//        return NSColor(name: "iBlack")
        return NSColor.hex("262626", alpha: 1.0);
    }
    
    // 浅黑色
    class var iDeepBlack: NSColor {
//        return NSColor(name: "iDeepBlack")
        return NSColor.hex("16191C", alpha: 1.0);
    }
    
    // 深黑色
    class var iLightBlack: NSColor {
//        return NSColor(name: "iLightBlack")
        return NSColor.hex("385173", alpha: 1.0);
    }
    
    // 蓝色
    class var iBlue: NSColor {
//        return NSColor(name: "iBlue")
        return NSColor.hex("2E7DFB", alpha: 1.0);
    }
    
    // 白色
    class var iWhite: NSColor {
//        return NSColor(name: "iWhite")
        return NSColor.hex("FFFFFF", alpha: 1.0);
    }
    
    // 灰色
    class var iGray: NSColor {
//        return NSColor(name: "iGray")
        return NSColor.hex("808080", alpha: 1.0);
    }
    
    // 浅灰色
    class var iLightGray: NSColor {
//        return NSColor(name: "iLightGray")
        return NSColor.hex("BFBFBF", alpha: 1.0);
    }
    
    /// 浅灰色背景
    class var iGrayBackground: NSColor {
//        return NSColor(name: "iGrayBackground")
        return NSColor.hex("f5f5f5", alpha: 1.0);
    }
    
}
