//
//  NSView+Extension.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/29.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension NSView {
    
    /// backgroundColor add by JS
    var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        
        set {
            DispatchQueue.main.async {
                self.wantsLayer = true
                self.layer?.backgroundColor = newValue?.cgColor
            }
            
        }
    }
}
