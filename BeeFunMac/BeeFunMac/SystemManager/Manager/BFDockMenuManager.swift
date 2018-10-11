//
//  BFDockMenuManager.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/7/2.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

enum BFDockMenuTitle: String {
    case BeeFun = "BeeFun"
}

class BFDockMenuManager: NSObject {
    
    static let shared = BFDockMenuManager()
    private let mainWindowController = AppDelegate.sharedInstance.mainController
    
    func dockMenu() -> NSMenu {
        let menu = NSMenu()
        let menuItem = NSMenuItem(title: BFDockMenuTitle.BeeFun.rawValue, action: #selector(didClickDockMenuItem(item:)), keyEquivalent: "O")
        menu.addItem(menuItem)
        return menu
    }
    
}

// MARK: - Menu Hanlder

extension BFDockMenuManager {
    
    @objc func didClickDockMenuItem(item: NSMenuItem) {
        if let menuTitle = BFDockMenuTitle(rawValue: item.title) {
            switch menuTitle {
            case .BeeFun:
                openBeeFunMainWindow()
            }
        }
    }
    
    
    func openBeeFunMainWindow() {
        mainWindowController?.window?.makeKeyAndOrderFront(self)
    }
}
