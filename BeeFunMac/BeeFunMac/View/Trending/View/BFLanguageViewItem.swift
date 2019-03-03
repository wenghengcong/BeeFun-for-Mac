//
//  LanguageViewItem.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class BFLanguageViewItem: NSCollectionViewItem {

    @IBOutlet weak var colorLabel: NSButton!
    @IBOutlet weak var nameLabel: NSTextField!
    
    var language: BFLangModel? {
        didSet {
            fillData(language)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        colorLabel.isBordered = false
        colorLabel.radius = colorLabel.size.width/2.0
    }
    
    func fillData(_ language: BFLangModel?) {
        if let color = language?.color {
            let fillColor = NSColor.hex(color)
            colorLabel.backgColor = fillColor
//            nameLabel.textColor = NSColor.hex(color)
        }
        if let name = language?.name {
            nameLabel.stringValue = name
        }
    }
    
}
