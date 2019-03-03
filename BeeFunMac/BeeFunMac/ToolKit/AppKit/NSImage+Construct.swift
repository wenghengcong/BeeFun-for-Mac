//
//  NSImage+Construct.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension NSImage {
    
    convenience public init?(name: String) {
        self.init(named: NSImage.Name("name"))
    }
}
