//
//  NSView+Draw.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/10.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension NSView {
    
    var width: CGFloat {
        
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
        
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
        
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    var center: CGPoint {
        
        get {
            let centerX = left + width/2.0
            let centerY = bottom + height/2.0
            return CGPoint(x: centerX, y: centerY)
        }
        
        set {
            self.x = newValue.x-width/2.0
            self.y = newValue.y-height/2.0
        }
    }
    
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin = CGPoint(x: newValue, y: self.frame.origin.y)
            
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin = CGPoint(x: self.frame.origin.x, y: newValue)
            
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
            
        }
    }
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
            
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
            
        }
    }
    
    /// top区别UIView的top
    var top: CGFloat {
        get {
            return self.frame.origin.y+self.frame.size.height
        }
        set {
            self.frame.origin.y = newValue-self.frame.size.height
        }
    }
    
    /// bottom区别于UIView的bottom
    var bottom: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
}

extension NSView {
    
    /// 设置圆角
    var radius: CGFloat {
        get {
            return self.layer?.cornerRadius ?? 0
        }
        set {
            self.wantsLayer = true
            self.layer?.masksToBounds = true
            self.layer?.cornerRadius = newValue
            self.layer?.masksToBounds = true
        }
    }
    
    /// 设置边框颜色
    var borderColor: NSColor {
        get {
            if let color = self.layer?.borderColor {
                return NSColor(cgColor: color) ?? NSColor.lineBackgroundColor
            }
            return NSColor.lineBackgroundColor
        }
        set {
            self.wantsLayer = true
            self.layer?.borderColor = newValue.cgColor
        }
    }
    
    /// 设置边框颜色
    var borderWidth: CGFloat {
        get {
            return self.layer?.borderWidth ?? 0
        }
        set {
            self.wantsLayer = true
            self.layer?.borderWidth = newValue
        }
    }
}

