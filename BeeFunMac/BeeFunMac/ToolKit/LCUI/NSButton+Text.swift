//
//  NSButton.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/14.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

extension NSButton {
    
    func setTitleTextColor(color: NSColor) {
        let dic = AttributedDictionary.attributeDictionary(foreColor: color, backColor: nil, alignment: nil, lineBreak: nil, baselineOffset: nil, font: nil)
        let attTitle = NSAttributedString(string: title, attributes: dic)
        attributedTitle = attTitle
    }
}
