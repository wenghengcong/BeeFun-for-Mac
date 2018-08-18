//
//  BFTheme+IconBar.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
enum IconArea: String {
    case iconBar = "icon_bar"
    case starTag = "star_tag"
    case starOrder = "star_order"
    case starTool = "star_tool"
}

extension BFThemeManager {
    
    /// 整个icon bar背景色
    func iconBarBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayWhite
        case .blue:
            return NSColor.thBlueIconBarBlue
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    /// 选中icon bar时贴在最右侧的颜色
    func iconSelectedLeftLineColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayBlue
        case .blue:
            return NSColor.thBlueWhite
        case .night:
            return NSColor.thNightWhite
        }
    }
    
    /// 选中icon bar 底部背景的颜色
    func iconSelectedBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayWhite
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    /// 未选中icon bar 底部背景的颜色
    func iconNormalBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayWhite
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    func iconbarStarImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.iconBar, iconName: "star", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }
    
    func iconbarGitImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.iconBar, iconName: "git", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }

}
