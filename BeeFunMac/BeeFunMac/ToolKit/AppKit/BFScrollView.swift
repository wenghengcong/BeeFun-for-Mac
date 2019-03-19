//
//  BFScrollView.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/19.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

/// 横向滑动禁止的ScrollView
class HorizontalDisableScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        if event.deltaX != 0.0 {
            self.nextResponder?.scrollWheel(with: event)
        }
    }
}

/// 纵向滑动禁止的ScrollView
class VerticalDisableScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        if event.deltaY != 0.0 {
            self.nextResponder?.scrollWheel(with: event)
        }
    }
}

