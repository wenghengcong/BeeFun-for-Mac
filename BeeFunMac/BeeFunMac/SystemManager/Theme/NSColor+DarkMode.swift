//
//  NSColor+DarkModeSupport.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/13.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    
    /// 蓝色: 深夜模式蓝色
    class var xyBlueDarkBlue: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlue
        } else {
            return NSColor.iBlue
        }
    }
    
    /// 白色: 深夜模式白色
    class var xyWhiteDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iWhite
        }
    }
    
    /// 白色: 深夜模式黑色
    class var xyWhiteDarkBlack: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iWhite
        }
    }
    
    /// 黑色: 深夜模式白色
    class var xyBlackDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iBlack
        }
    }
    
    /// 黑色: 深夜模式白色
    class var xyLightBlackDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iLightBlack
        }
    }
    
    /// 蓝色: 深夜模式白色
    class var xyBlueDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iBlue
        }
    }
    
    /// 浅灰色背景: 深夜模式黑色
    class var xyGrayDarkBlack: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iGray
        }
    }
    
    
    /// 浅灰色背景
    class var xyiGrayDarkBlackBackground: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iGrayBackground
        }
    }
    

}
