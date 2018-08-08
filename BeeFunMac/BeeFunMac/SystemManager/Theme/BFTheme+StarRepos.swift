//
//  BFTheme+StarRepos.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFThemeManager {
    
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
}
