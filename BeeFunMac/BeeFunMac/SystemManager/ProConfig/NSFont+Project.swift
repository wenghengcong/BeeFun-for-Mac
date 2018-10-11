//
//  NSFont+Project.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/10.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension NSFont {
    
    //PingFang Light、Medium、Regular、Thin、Ultralight、Semibold
    enum CPEFontSize: CGFloat {
        case tinyFontSize = 8
        case smallFontSize = 10
        case middleFontSize = 12
        case largeFontSize = 14
        case hugeFontSize = 16
    }
    
    class func bfSystemFont(ofSize: CGFloat) -> NSFont {
        return NSFont.systemFont(ofSize: ofSize)
//            return NSFont(name: "PingFang-SC-Regular", size: ofSize)!
    }
    
    class func bfBoldSystemFont(ofSize: CGFloat) -> NSFont {
        return NSFont.boldSystemFont(ofSize: ofSize)
        return NSFont(name: "PingFang-SC-Medium", size: ofSize)!
    }
    
    // MARK: system font
    
    class func tinySizeSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Regular", size: CPEFontSize.tinyFontSize.rawValue)!
        
    }
    
    class func smallSizeSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Regular", size: CPEFontSize.smallFontSize.rawValue)!
    }
    
    class func middleSizeSystemFont() -> NSFont {
            return NSFont(name: "PingFang-SC-Regular", size: CPEFontSize.middleFontSize.rawValue)!
        
    }
    
    class func largeSizeSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Regular", size: CPEFontSize.largeFontSize.rawValue)!
    }
    
    class func hugeSizeSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Regular", size: CPEFontSize.hugeFontSize.rawValue)!
    }
    
    // MARK: system bold font
    
    class func tinySizeBoldSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Medium", size: CPEFontSize.tinyFontSize.rawValue)!
    }
    
    class func smallSizeBoldSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Medium", size: CPEFontSize.smallFontSize.rawValue)!
    }
    
    class func middleSizeBoldSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Medium", size: CPEFontSize.middleFontSize.rawValue)!
    }
    
    class func largeSizeBoldSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Medium", size: CPEFontSize.largeFontSize.rawValue)!
    }
    
    class func hugeSizeBoldSystemFont() -> NSFont {
        return NSFont(name: "PingFang-SC-Medium", size: CPEFontSize.hugeFontSize.rawValue)!
    }
}
