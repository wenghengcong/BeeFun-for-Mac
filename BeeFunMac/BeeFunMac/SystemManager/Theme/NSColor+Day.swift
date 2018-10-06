//
//  NSColor+Theme.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

// MARK: - Day
// icon 颜色值：ffffff/2e7dfb
extension NSColor {
    
    /// 白色值
    class var thDayWhite: NSColor {
        return NSColor.hex("ffffff", alpha: 1.0);
    }
    
    
    /// 蓝色Icon的颜色值
    class var thDayBlue: NSColor {
        return NSColor.hex("2e7dfb", alpha: 1.0);
    }
    
    /// 灰色Icon的颜色值
    class var thDayGray: NSColor {
        return NSColor.hex("808080", alpha: 1.0);
    }
    
    /// 浅灰色的颜色值
    class var thDayLightGray: NSColor {
        return NSColor.hex("bfbfbf", alpha: 1.0);
    }
    
    /// 黑色文本Title的颜色值
    class var thDayBlack: NSColor {
        return NSColor.hex("262626", alpha: 1.0);
    }
    
    /// 黑色副标题文本的颜色值
    class var thDayLightBlack: NSColor {
        return NSColor.hex("385173", alpha: 1.0);
    }
}
