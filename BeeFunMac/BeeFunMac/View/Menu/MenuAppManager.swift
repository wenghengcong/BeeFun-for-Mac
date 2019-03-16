//
//  MenuAppManager.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/15.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

class MenuAppManage {
    
    static let shared = MenuAppManage()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func setupMainMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("menu_logo_40"))
            button.target = self
            button.action = #selector(togglePopover(_:))
        }
        
        popover.contentViewController = MenuAppViewController.menuAppController()
        eventMonitor = EventMonitor(mask: .leftMouseDown) { [weak self] event in
            if self?.popover.isShown == true { self?.closePopover(sender: event) }
        }
        eventMonitor?.start()
    }
    
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
}

