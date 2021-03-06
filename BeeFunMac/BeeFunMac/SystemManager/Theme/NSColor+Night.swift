//
//  NSColor+Night.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

// MARK: - Night
// icon 颜色值：ffffff/808080
extension NSColor {
    
    /// 白色值
    //贴在最右侧的线的颜色值
    class var thNightWhite: NSColor {
        return NSColor.hex("ffffff", alpha: 1.0);
    }
    
    /// 蓝色Icon的颜色值
    class var thNightBlue: NSColor {
        return NSColor.hex("2e7dfb", alpha: 1.0);
    }
    
    /// 灰色Icon的颜色值
    class var thNightGray: NSColor {
        return NSColor.hex("808080", alpha: 1.0);
    }
    
    
    /// icon bar 黑色背景颜色值
    //  选中icon bar 底部背景的颜色
    class var thNightBlack: NSColor {
        return NSColor.hex("16191c", alpha: 1.0);
    }
    
}
