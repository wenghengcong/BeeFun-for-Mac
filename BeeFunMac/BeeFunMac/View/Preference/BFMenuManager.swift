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
    
    lazy var preferencesWindowController:MASPreferencesWindowController = {
        let generalController = GeneralPreferenceController()
//        let syncController = SyncPreferenceController()
//        let controllers = [generalController, syncController]
        let controllers = [generalController]
        return MASPreferencesWindowController(viewControllers:controllers,title: nil)
    }()
    
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
            default:
                break
            }
        }
    }
    
    func openAbout(_ sender: Any) {
        
    }
    
    func openPreference(_ sender: Any) {
        self.preferencesWindowController.window?.level = NSWindow.Level.popUpMenu
        self.preferencesWindowController.showWindow(nil)
        AppDelegate.sharedInstance.mainController?.window?.center()
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
