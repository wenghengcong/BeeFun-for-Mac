//
//  GeneralPaneController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/15.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class GeneralPaneController: NSViewController {

    @IBOutlet weak var shortcutView: MASShortcutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.shortcutView.associatedUserDefaultsKey = "GlobalShortcut"
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: "GlobalShortcut") {
            self.showWindow()
        }
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
