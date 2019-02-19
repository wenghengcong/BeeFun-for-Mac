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
        return attributeDictionary(foreColor: foreColor, backColor: nil, alignment: alignment, lineBreak: nil, baselineOffset: nil, font: nil)
    }
    
    
    class func attributeDictionary(foreColor: NSColor, alignment: NSTextAlignment, font: NSFont) -> [NSAttributedString.Key : Any] {
        return attributeDictionary(foreColor: foreColor, backColor: nil, alignment: alignment, lineBreak: nil, baselineOffset: nil, font: font)
    }
    
    class func attributeDictionary(foreColor: NSColor, backColor: NSColor, alignment: NSTextAlignment) -> [NSAttributedString.Key : Any] {
        return attributeDictionary(foreColor: foreColor, backColor: backColor, alignment: alignment, lineBreak: nil, baselineOffset: nil, font: nil)
    }
    
    class func attributeDictionary(foreColor: NSColor, backColor: NSColor, alignment: NSTextAlignment, font: NSFont) -> [NSAttributedString.Key : Any] {
        return attributeDictionary(foreColor: foreColor, backColor: backColor, alignment: alignment, lineBreak: nil, baselineOffset: nil, font: font)
    }
    
    class func attributeDictionary(foreColor: NSColor, backColor: NSColor?, alignment: NSTextAlignment?, lineBreak: NSLineBreakMode?, baselineOffset: NSNumber?, font: NSFont?) -> [NSAttributedString.Key : Any] {
        
        let style = NSMutableParagraphStyle()
        if alignment != nil {
            style.alignment = alignment!
        }
        if lineBreak != nil {
            style.lineBreakMode = lineBreak!
        }
        
        var attributeDic: [NSAttributedString.Key : Any] = [:]
        attributeDic[NSAttributedString.Key.foregroundColor] = foreColor

        if alignment != nil || lineBreak != nil {
            attributeDic[NSAttributedString.Key.paragraphStyle] = style
        }
        
        if backColor != nil {
            attributeDic[NSAttributedString.Key.backgroundColor] = backColor
        }
        
        if baselineOffset != nil {
            attributeDic[NSAttributedString.Key.baselineOffset] = baselineOffset!
        }
        
        if font != nil {
            attributeDic[NSAttributedString.Key.font] = font!
        }
        return attributeDic
    }
}
