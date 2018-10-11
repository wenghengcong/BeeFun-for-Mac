//
//  NSControl+Click.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension NSView {
    
    func addSingleLeftClickGesture(action: Selector?) {
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 1
        gesture.target = self
        gesture.action = action
        addGestureRecognizer(gesture)
    }
    
    func addDoubleLeftClickGesture(action: Selector?) {
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 2
        gesture.target = self
        gesture.action = action
        addGestureRecognizer(gesture)
    }
}
