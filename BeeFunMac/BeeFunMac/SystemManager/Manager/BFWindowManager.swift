//
//  BFWindowManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/15.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

class BFWindowManager: NSObject {

    static let shared = BFWindowManager()
    
    // MARK: - Open What Window
    func openWindow() {
        if UserManager.shared.isLogin {
            openMainWindow()
        } else {
            openLoginWindow()
        }
    }
    
    func openMainWindow() {
        //https://stackoverflow.com/questions/5547741/how-to-open-a-new-window-on-button-click-in-cocoa-mac-application
        if let lastWindow = AppDelegate.sharedInstance.mainController {
            lastWindow.close()
        }
        NSApplication.shared.mainWindow?.close()
        let mainStoryboard = NSStoryboard.init(name: NSStoryboard.Name( "MainWindow"), bundle: nil)
        let mainWindow = mainStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier( "mainwindow")) as? BFWindowController
        
        var frame = mainWindow?.mainContentController?.view.window?.frame ?? NSRect.zero
        frame.size = NSSize(width: 1350, height: 700)
        mainWindow?.mainContentController?.view.window?.setFrame(frame , display: false)
        
        AppDelegate.sharedInstance.mainController = mainWindow
        AppDelegate.sharedInstance.mainController?.showWindow(self)
        AppDelegate.sharedInstance.mainController?.window?.center()
    }
    
    func openLoginWindow() {
        //https://stackoverflow.com/questions/5547741/how-to-open-a-new-window-on-button-click-in-cocoa-mac-application
        if let lastWindow = AppDelegate.sharedInstance.mainController {
            lastWindow.close()
        }
        NSApplication.shared.mainWindow?.close()
        let mainStoryboard = NSStoryboard.init(name: NSStoryboard.Name( "MainWindow"), bundle: nil)
        let loginWindow = mainStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier( "loginwindow")) as? BFWindowController
        var frame = loginWindow?.mainContentController?.view.window?.frame ?? NSRect.zero
        frame.size = NSSize(width: 260, height: 320)
        
        loginWindow?.mainContentController?.view.window?.setFrame(frame , display: false)
        AppDelegate.sharedInstance.mainController = loginWindow
        AppDelegate.sharedInstance.mainController?.showWindow(self)
        AppDelegate.sharedInstance.mainController?.window?.center()
    }
    
    func closeLoginWindow() {
        let mainStoryboard = NSStoryboard.init(name: NSStoryboard.Name( "MainWindow"), bundle: nil)
        let loginWindow = mainStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier( "loginwindow")) as? BFWindowController
        loginWindow?.close()
    }
}
