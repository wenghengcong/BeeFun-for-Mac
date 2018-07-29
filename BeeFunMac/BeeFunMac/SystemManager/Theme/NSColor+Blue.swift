//
//  NSColor+Blue.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

// MARK: - Blue
// icon 颜色值：ffffff/dbdbdb
extension NSColor {
    
    /// 白色值
    // 选中icon bar 底部背景的颜色
    // 未选中icon bar 底部背景的颜色
    class var thBlueWhite: NSColor {
        return NSColor.hex("ffffff", alpha: 1.0);
    }
    
    // 整个iconBar的颜色值
    class var thBlueIconBarBlue: NSColor {
        return NSColor.hex("007aff", alpha: 1.0);
    }
    
    /// 蓝色Icon的颜色值
    class var thBlueBlue: NSColor {
        return NSColor.hex("2e7dfb", alpha: 1.0);
    }
    
    /// 灰色Icon的颜色值
    class var thBlueGray: NSColor {
        return NSColor.hex("dbdbdb", alpha: 1.0);
    }
    
    
    /// icon bar 黑色背景颜色值
    //  选中icon bar 底部背景的颜色
    class var thBlueBlack: NSColor {
        return NSColor.hex("16191c", alpha: 1.0);
    }
}

