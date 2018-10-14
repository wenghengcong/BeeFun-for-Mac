//
//  BFDarkModeManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/14.
//  Copyright © 2018 LuCi. All rights reserved.
//

import Cocoa

class BFDarkModeManager: NSObject {

    static let shared = BFDarkModeManager()
    
    func setupDarkMode(_ notification: Notification) {
        //build settings -> Other Swift Flags, set "-DDEBUG_DARK_AQUA"
        if #available(OSX 10.14, *) {
            #if DEBUG_DARK_AQUA
            NSApp.appearance = NSAppearance(named: .aqua)
            #endif
        } else {
            // Fallback on earlier versions
        }
    }
}

extension NSAppearance {
    @objc(rsIsDarkMode)
    public var isDarkMode: Bool {
        let isDarkMode: Bool
        
        if #available(macOS 10.14, *) {
            if self.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua {
                isDarkMode = true
            } else {
                isDarkMode = false
            }
        } else {
            isDarkMode = false
        }
        
        return isDarkMode
    }
}

extension NSApplication {
    @objc(rsIsDarkMode)
    public var isDarkMode: Bool {
        if #available(macOS 10.14, *) {
            return self.effectiveAppearance.isDarkMode
        } else {
            return false
        }
    }
}


