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

    
    /// 选中icon bar 底部背景的颜色
    func tagShowBackgroundColor() -> NSColor {
        switch themeType {
        case .day:
            return NSColor.thDayWhite
        case .blue:
            return NSColor.clear
        case .night:
            return NSColor.thNightBlack
        }
    }
    
    /// 选中icon bar 底部背景的颜色
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
    
    func allStarNormalImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "all", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func allStarSelectedImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "all", selected: true)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func unTaggedNormalImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "all", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func unTaggedSelectedImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "all", selected: true)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    
    /// 保存Tag的icon
    func saveTagNormalImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "save", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func saveTagSelectedImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "save", selected: true)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    
    /// Tag前面的icon
    func tagNormalImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "save", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func tagSelectedImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "save", selected: true)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
}
