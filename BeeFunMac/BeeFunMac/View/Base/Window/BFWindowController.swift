//
//  BFBaseWindowController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/28.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

class BFWindowController: NSWindowController {

    var mainContentController: BFMainController?
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        showControlsAndHiddleTitle()
        moveableWindow()
        let appDelegate = NSApp.delegate as! AppDelegate
        appDelegate.mainController = self
        
        mainContentController = contentViewController as? BFMainController
    }
    
    /// 显示右上角三个按钮，但是隐藏title bar
    private func showControlsAndHiddleTitle() {
        //https://stackoverflow.com/questions/25250762/xcode-swift-window-without-title-bar-but-with-close-minimize-and-resize-but
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.styleMask.insert(.fullSizeContentView)
    }
    
    /// window可移动，有效
    private func moveableWindow() {
        //https://stackoverflow.com/questions/4563893/allow-click-and-dragging-a-view-to-drag-the-window-itself
        window?.isMovableByWindowBackground = true
    }
    
}
