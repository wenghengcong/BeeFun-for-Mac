//
//  BFImageButton.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/9.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

class BFImageButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.imageScaling = .scaleNone
//        self.highlight(false)
        self.isBordered = false
    }
    
}
