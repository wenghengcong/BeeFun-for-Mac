//
//  MenuPanelController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuPanelController: NSViewController {

    
    @IBOutlet weak var shorecutView: MASShortcutView!
    
    @IBOutlet weak var openMenuBarCheckBox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.shorecutView.associatedUserDefaultsKey = ShortcutKey.OpenMenu
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: ShortcutKey.OpenMenu) {
            self.openMenubar()
        }
        
        // openMenuBarCheckBox
        if ReadPreference.shard.registerMenuWhenAppOpen() {
            openMenuBarCheckBox.state = NSControl.StateValue.on
        } else {
            openMenuBarCheckBox.state = NSControl.StateValue.off
        }
    }
    
    func openMenubar() {
        DispatchQueue.main.async {
            if ReadPreference.shard.registerMenuWhenAppOpen() {
                MenuAppManage.shared.showPopover(sender: nil)
            } else {
                let alert = NSAlert()
                alert.messageText = "Allow menu bar app show"
                alert.informativeText = "Go to \"Preference->Menu\" ,check it"
                alert.alertStyle = .warning
                alert.addButton(withTitle: "Go Preference")
                alert.addButton(withTitle: "Cancel")
                if let window = NSApplication.shared.mainWindow {
                    alert.beginSheetModal(for: window) { (model) in
                        if model == NSApplication.ModalResponse.alertSecondButtonReturn {
                            return
                        }
                        BFMenuManager.shared.openPreference(index: 1)
                    }
                }
            
            }
        }
    }
    
    
    @IBAction func openMenuBarCheckBoxAction(_ sender: Any) {
   
        if let button = sender as? NSButton  {
            var open = "true"
            if button.state == NSControl.StateValue.on {
               print("state on")
                open = "true"
            } else {
                print("state off")
                open = "false"
            }
            UserDefaults.standard[.RegisterMenuWhenAppOpen] = open
        }
    }
    
}
