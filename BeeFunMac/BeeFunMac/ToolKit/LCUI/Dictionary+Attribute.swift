//
//  Dictionary+Attribute.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/7.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class AttributedDictionary {
    
   class func attributeDictionary(foreColor: NSColor, alignment: NSTextAlignment) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let dic = [NSAttributedStringKey.foregroundColor:foreColor,
                       NSAttributedStringKey.paragraphStyle: style]
        return dic
    }
    
    
    class func attributeDictionary(foreColor: NSColor, alignment: NSTextAlignment, font: NSFont) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let dic = [NSAttributedStringKey.foregroundColor:foreColor,
                   NSAttributedStringKey.paragraphStyle: style,
                   NSAttributedStringKey.font: font]
        return dic
    }
    
    class func attributeDictionary(foreColor: NSColor, backColor: NSColor, alignment: NSTextAlignment) -> [NSAttributedString.Key : Any] {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let dic = [NSAttributedStringKey.foregroundColor:foreColor,
                   NSAttributedStringKey.backgroundColor:backColor,
                   NSAttributedStringKey.paragraphStyle: style]
        return dic
    }
}
