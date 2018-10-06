//
//  BFButton.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/6.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

@IBDesignable
class BFButton: NSButton {
    @IBInspectable
    var bfBackgroundColor: NSColor? {
        didSet {
            self.backgColor = bfBackgroundColor
        }
    }
}
