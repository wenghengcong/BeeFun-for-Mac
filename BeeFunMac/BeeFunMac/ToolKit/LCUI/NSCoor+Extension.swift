//
//  NSCoor+Extension.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/13.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

extension NSColor {
    
    convenience init(name: String) {
        self.init(named: NSColor.Name(name))!
    }
}
