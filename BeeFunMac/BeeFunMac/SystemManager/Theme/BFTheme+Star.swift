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
        let imageName = combineImageName(prefix: IconArea.star, iconName: "untagged", selected: false)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    func unTaggedSelectedImage() -> NSImage? {
        let imageName = combineImageName(prefix: IconArea.star, iconName: "untagged", selected: true)
        let image = NSImage(named: NSImage.Name(rawValue: imageName))
        return image
    }
    
    
}
