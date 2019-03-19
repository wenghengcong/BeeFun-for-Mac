
//
//  MenuSettingController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuSettingController: NSViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.backgColor = NSColor.white
    }
    
    @IBAction func openPreference(_ sender: Any) {
        MenuAppManage.shared.closePopover(sender: nil)
        BFMenuManager.shared.openPreference(nil)
    }
    
    
    @IBAction func quitApplication(_ sender: Any) {
        MenuAppManage.shared.remove()
    }
    
    @IBAction func quitMainApp(_ sender: Any) {
        NSApplication.shared.terminate(nil)
    }
    
    
    @IBAction func openMainApp(_ sender: Any) {
        MenuAppManage.shared.closePopover(sender: nil)
        BFWindowManager.shared.openWindow()
    }
    
}
