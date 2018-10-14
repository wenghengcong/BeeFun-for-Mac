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
    
    /// 浅黑色: 深夜模式白色
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
    
    /// 浅灰色: 深夜模式黑色
    class var xyGrayDarkBlack: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iGray
        }
    }
    
    /// 灰色: 深夜模式白色
    class var xyGrayDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iGray
        }
    }
    
    /// 浅灰色: 深夜模式白色
    class var xyLightGrayDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iLightGray
        }
    }
    
    
    /// 浅灰色背景
    class var xyGrayDarkBlackBackground: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iGrayBackground
        }
    }
    
    /// 透明: 深页模式黑色
    class var xyClearDarkBlack: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iBlack
        } else {
            return NSColor.iClear
        }
    }
    
    
    /// 透明: 深页模式白色
    class var xyClearDarkWhite: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iClear
        }
    }
    
    /// 线灰色: 深页模式白色
    class var xyLineGray: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iWhite
        } else {
            return NSColor.iLineColor
        }
    }
    
    /// 线灰色: 深夜模式
    class var xyLineGrayDarkGray: NSColor {
        if NSApplication.shared.isDarkMode {
            return NSColor.iLineGrayInDark
        } else {
            return NSColor.iLineGrayInDay
        }
    }
}
