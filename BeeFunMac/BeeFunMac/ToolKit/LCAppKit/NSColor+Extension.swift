//
//  NSColor+Extension.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/29.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    
    convenience init(name: String) {
        self.init(named: NSColor.Name(name))!
    }
    
    // MARK: - init
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    public convenience init?(hex hexString: String, alpha: CGFloat = 1.0) {
        let hexInt = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hexInt).scanHexInt32(&int)
        if (hexInt.count>0) {
            let r, g, b: UInt32
            switch hexInt.count {
            case 3: // RGB (12-bit)
                (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (r, g, b) = (0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
            return
        }
        return nil
    }
    
    public convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }
    
    // MARK: - Class funcs
    
    public class func hex(_ hexStr: String, alpha: CGFloat = 1.0) -> NSColor {
        return NSColor(hex: hexStr, alpha: alpha)!
    }
    
    public class func gray(gray: CGFloat, alpha: CGFloat = 1) -> NSColor {
        return NSColor.init(gray: gray)
    }
    
    // MARK: - component
    
    public var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    public var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    public var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    public static func random(randomAlpha: Bool = false) -> NSColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return NSColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

private extension CGFloat {
    /// SwiftRandom extension
    static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}
