//
//  IconBarView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/29.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

class IconBarView: NSView {
    
    /// window可移动，不是必要
//    override var mouseDownCanMoveWindow: Bool {
//        get {
//            return true
//        }
//    }
    
    override func viewDidChangeEffectiveAppearance() {
        // Update appearance related state here...
        if NSApplication.shared.isDarkMode {
            backgColor = NSColor.iBlack
        } else {
            backgColor = NSColor.iGrayBackground
        }
    }
    
}
