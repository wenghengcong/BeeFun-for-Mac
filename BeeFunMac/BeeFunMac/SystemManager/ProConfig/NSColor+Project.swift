//
//  NSColor+Project.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/28.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    class var cpBlueLinkColor: NSColor {
        //red
        return NSColor.hex("007aff", alpha: 1.0)
    }
    
    class var labelTitleTextColor: NSColor {
        //gray
        return NSColor.hex("000000", alpha: 1.0)
    }
    
    class var lineGrayColor: NSColor {
        return NSColor.hex("ceced2", alpha: 1.0)
    }
    
    class var subtitleTextColor: NSColor {
        //black
        return NSColor.hex("7b7b7b", alpha: 1.0)
    }

    
    class var placeholderTextColor: NSColor {
        return NSColor.hex("c7c6cd", alpha: 1.0)
    }
    
    class var bfRedColor: NSColor {
        //red
        return NSColor.hex("fa3e3e", alpha: 1.0)
    }
}
