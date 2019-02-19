//
//  GeneralPreferenceController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/24.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import MASPreferences
import MASShortcut

class GeneralPreferenceController:NSViewController, MASPreferencesViewController {
    
    @IBOutlet weak var shortcutView: MASShortcutView!
    
    init() {
        super.init(nibName: NSNib.Name("GeneralPreferenceController"), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shortcutView.associatedUserDefaultsKey = "GlobalShortcut"
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: "GlobalShortcut") {
            self.showWindow()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var toolbarItemLabel: String? {
        return "General"
    }
    
    var viewIdentifier: String {
            return "GeneralPreferences"
    }
    
    var toolbarItemImage: NSImage? {
        return NSImage(named: NSImage.preferencesGeneralName)
    }
    
    func showWindow() {
        DispatchQueue.main.async {
            if let keyWindow = AppDelegate.sharedInstance.mainController?.window {
                if keyWindow.isVisible {
                    keyWindow.orderOut(nil)
                } else {
                    keyWindow.makeKeyAndOrderFront(keyWindow)
                    NSApp.activate(ignoringOtherApps: true)
                }
            }

        }
    }
}
