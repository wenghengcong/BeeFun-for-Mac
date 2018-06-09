
//
//  NSColor+Project.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/29.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    
    // MARK: navigation bar
    class var iconBarBackgroundColor: NSColor {
        //white
        //红色：CD2626（暗色调）->FF0033（亮色）
        //黑色：262626
        //黑灰色：737373
        return NSColor.hex("f7f7f7", alpha: 1.0)
    }
    
    //icon 红色：cd2626，灰色8a8a8a
    
    // MARK: navigation bar
    class var navigationBarTitleTextColor: NSColor {
        //white
        return NSColor.hex("ffffff", alpha: 1.0)
    }
    
    class var navigationBarBackgroundColor: NSColor {
        //red
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    // MARK: tab bar
    class var tabBarTitleTextColor: NSColor {
        //red
        return NSColor.hex("d81e06", alpha: 1.0)
    }
    
    class var tabBarBackgroundColor: NSColor {
        //light gray
        return NSColor.white
    }
    
    // MARK: label
    class var labelSubtitleTextColor: NSColor {
        //black
        return NSColor.hex("7b7b7b", alpha: 1.0)
    }
    
    class var labelTitleTextColor: NSColor {
        //gray
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    // MARK: text field
    class var textFieldTextColor: NSColor {
        //black
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    class var textFieldPlaceholderTextColor: NSColor {
        //light gray
        return NSColor.hex("c7c6cd", alpha: 1.0)
    }
    
    // MARK: text view
    class var textViewTextColor: NSColor {
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    class var textViewPlaceholderTextColor: NSColor {
        return NSColor.hex("c7c6cd", alpha: 1.0)
    }
    
    // MARK: button
    class var buttonWihteTitleTextColor: NSColor {
        return NSColor.hex("ffffff", alpha: 1.0)
    }
    
    class var buttonBlackTitleTextColor: NSColor {
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    class var buttonRedTitleTextColor: NSColor {
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    class var buttonRedBackgroundColor: NSColor {
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    //below 3 color group
    class var buttonWhiteBackgroundColor: NSColor {
        return NSColor.hex("ffffff", alpha: 1.0)
    }
    
    class var buttonHighlightBackgroundColor: NSColor {
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    class var buttonSelectedBackgroundColor: NSColor {
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    // MARK: view
    class var viewBackgroundColor: NSColor {
        return NSColor.hex("f8f8f8", alpha: 1.0)
    }
    
    //badege
    class var badgeBackgroundColor: NSColor {
        return NSColor.hex("e31100", alpha: 1.0)
    }
    
    //line
    class var lineBackgroundColor: NSColor {
        return NSColor.hex("ceced2", alpha: 1.0)
    }
    
    // MARK: color name
    class var cpBlackColor: NSColor {
        //black
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    class var cpRedColor: NSColor {
        //red
        return NSColor.hex("ff0033", alpha: 1.0)
    }
    
    class var cpBlueColor: NSColor {
        //red
        return NSColor.hex("5677fc", alpha: 1.0)
    }
    
    class var cpBlueLinkColor: NSColor {
        //red
        return NSColor.hex("007aff", alpha: 1.0)
    }
    
    class var cpMaskColor: NSColor {
        return NSColor.hex("000000", alpha: 0.1)
    }
}
