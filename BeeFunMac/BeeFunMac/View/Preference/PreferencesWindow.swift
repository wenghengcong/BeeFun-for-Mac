//
//  PreferencesWindow.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/15.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSPanel {

    // MARK: Panel Methods
    
    /// disable "Hide Toolbar" menu item
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        
        switch menuItem.action {
        case #selector(toggleToolbarShown)?:
            return false
            
        default:
            return super.validateMenuItem(menuItem)
        }
    }
    
}
