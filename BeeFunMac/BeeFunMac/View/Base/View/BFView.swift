//
//  BFView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/8.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

@IBDesignable
class BFView: NSView {

    @IBInspectable
    var bfBackgroundColor: NSColor? {
        didSet {
            self.backgColor = bfBackgroundColor
        }
    }
    
}
