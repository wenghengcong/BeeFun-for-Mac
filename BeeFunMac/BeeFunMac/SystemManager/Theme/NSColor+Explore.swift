//
//  NSColor+Explore.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/14.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

extension BFThemeManager {
    
    func explre_nav_title_color() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayBlack
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.white
        }
    }
    
    func explre_nav_subTitle_color() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayLightBlack
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.white
        }
    }
    
    func explre_detail_title_color() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayBlack
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.white
        }
    }
    
    func explre_detail_subTitle_color() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayLightBlack
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.white
        }
    }
}
