//
//  BFTheme+Star.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa


// MARK: - Star 页面的主题配置
extension BFThemeManager {

    
    func tagCellBackgroundColor(selected: Bool) -> NSColor {
        switch themeType {
        case .day:
            if selected {
                return NSColor.thDayBlue
            } else {
                return NSColor.thDayLightGray
            }
        case .blue:
            if selected {
                return NSColor.white
            } else {
                return NSColor.clear
            }
        case .night:
            if selected {
                return NSColor.white
            } else {
                return NSColor.white
            }
        }
    }
    
    func tagCellTitleColor(selected: Bool) -> NSColor {
        switch themeType {
        case .day:
            if selected {
                return NSColor.thDayBlue
            } else {
                return NSColor.thDayBlack
            }
        case .blue:
            if selected {
                return NSColor.white
            } else {
                return NSColor.clear
            }
        case .night:
            if selected {
                return NSColor.white
            } else {
                return NSColor.white
            }
        }
    }
    
    /// All stars
    func allStarsAttributeTitle(selected: Bool) -> NSAttributedString {
       let attributeTitle =  NSAttributedString(string: "All Stars", attributes: [NSAttributedStringKey.foregroundColor: starShowTitleColor(selected: selected)])
        return attributeTitle
    }
    
    /// untagged stars
    func untaggedStarsAttributeTitle(selected: Bool) -> NSAttributedString {
        let attributeTitle =  NSAttributedString(string: "Untagged Stars", attributes: [NSAttributedStringKey.foregroundColor: starShowTitleColor(selected: selected)])
        return attributeTitle
    }
    
    /// Tag管理区域，显示用的 文本的颜色
    func starShowTitleColor(selected: Bool) -> NSColor {
        switch themeType {
        case .day:
            if selected {
                return NSColor.thDayBlue
            } else {
                return NSColor.thDayBlack
            }
        case .blue:
            if selected {
                return NSColor.white
            } else {
                return NSColor.clear
            }
        case .night:
            if selected {
                return NSColor.white
            } else {
                return NSColor.white
            }
        }
    }
    
    /// 区域内分割线的颜色
    func sepLineBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayLightGray
        case .blue:
            return NSColor.thDayBlue
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    /// Tag管理区域，显示用的 底部背景的颜色
    func tagShowBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.white
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    /// Tag管理区域，显示用的 文本标题的颜色
    func tagShowTitleColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayBlack
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    /// Tag管理区域，按钮区域-底部背景的颜色
    func tagActionBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayWhite
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    func starAllStarImage(selected: Bool) -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "all", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func starUntaggedImage(selected: Bool) -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "untagged", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func starSyncImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.star, iconName: "sync", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }
    
    func starTimeImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.star, iconName: "order_time", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }
    
    func starNumImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.star, iconName: "order_num", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }
    
    func starA_ZImage(selected: Bool) -> NSImage? {
        let imgName: String = combineImageName(prefix: IconArea.star, iconName: "order_a_z", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imgName))
        return image
    }
    
    /// 保存Tag的icon
    func starSaveTagImage(selected: Bool) -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "save", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    /// Tag前面的icon
    func tagCellImage(selected: Bool) -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "tagcell", selected: selected)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
}
