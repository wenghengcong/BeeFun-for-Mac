//
//  BFLoginWindowController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/23.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFLoginWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        showControlsAndHiddleTitle()
        moveableWindow()
        self.window?.center()
    }
    
    /// 显示右上角三个按钮，但是隐藏title bar
    private func showControlsAndHiddleTitle() {
        //https://stackoverflow.com/questions/25250762/xcode-swift-window-without-title-bar-but-with-close-minimize-and-resize-but
        self.window?.titleVisibility = .hidden
        self.window?.titlebarAppearsTransparent = true
        self.window?.styleMask.insert(.fullSizeContentView)
    }
    
    /// window可移动，有效
    private func moveableWindow() {
        //https://stackoverflow.com/questions/4563893/allow-click-and-dragging-a-view-to-drag-the-window-itself
        self.window?.isMovableByWindowBackground = true
    }
}
