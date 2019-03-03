//
//  LanguageHeaderView.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class BFLanguageHeaderView: NSView {

    @IBOutlet weak var titleLabel: NSTextField!
    
    var title: String = "" {
        didSet {
            titleLabel.stringValue = title
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        backgColor = NSColor.xyBlueDarkBlue
        titleLabel.textColor = NSColor.xyWhiteDarkWhite
    }
    
}
