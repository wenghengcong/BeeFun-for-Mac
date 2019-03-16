//
//  BFMenuManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/24.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import MASPreferences

enum MenuItemTitle: String {
    case preferences = "Preferences…"
    case about = "About BeeFun"
    case help = "Help"
    case signOut = "Sign Out"
    case openMain = "Open…"
}

class BFMenuManager: NSObject {
    
    static let shared = BFMenuManager()
    
    private lazy var preferencesWindowController = NSWindowController.instantiate(storyboard: "PreferencesWindow")
    
    func openMenuItem(_ item: NSMenuItem, menu: NSMenu) {
        print("click menu title: \(item.title)")
        if let title: MenuItemTitle = MenuItemTitle.init(rawValue: item.title) {
            switch title {
            case .preferences:
                openPreference(item)
            case .about:
                openAbout(item)
            case .help:
                openHelp(item)
            case .signOut:
                openSignOut(item)
            case .openMain:
                openBeeFunMainWindow()
            }
        }
    }
    
    // warning
    func openAbout(_ sender: Any) {
        // 无法解决window变成key的问题，导致一旦关闭窗口，窗口打开后就是about
        // 利用原生的About
//        let infoStoryboard = NSStoryboard.init(name: NSStoryboard.Name( "Information"), bundle: nil)
//        let aboutWindow = infoStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier( "about_beefun")) as? BFWindowController
//        aboutWindow?.contentViewController?.identifier = NSUserInterfaceItemIdentifier(rawValue: "about_window")
//        aboutWindow?.window?.center()
//        aboutWindow?.showWindow(aboutWindow)
    }
    
    func openPreference(_ sender: Any) {
//        self.preferencesWindowController.window?.level = NSWindow.Level.popUpMenu
//        self.preferencesWindowController.window?.center()
//        self.preferencesWindowController.showWindow(nil)
//        AppDelegate.sharedInstance.mainController?.window?.center()
        self.preferencesWindowController.showWindow(sender)
    }
    
    
    func openHelp(_ sender: Any) {
        BFJumpWebStie.shared.jump(BFWebsiteURL.AppOfficeSite)
    }
    
    func openSignOut(_ sender: Any) {
        UserManager.shared.userSignOut()
    }
    
    func openBeeFunMainWindow() {
        AppDelegate.sharedInstance.mainController?.window?.makeKeyAndOrderFront(self)
    }
}
