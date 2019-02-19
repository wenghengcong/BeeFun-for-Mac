//
//  BFAboutViewController.swift
//  BeeFun
//
//  Created by WengHengcong on 2019/2/19.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class BFAboutViewController: NSViewController {
    
    @IBOutlet weak var appNameLabel: NSTextField!
    
    @IBOutlet weak var versionLabel: NSTextField!
    
    @IBOutlet weak var copyrightLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        appNameLabel.stringValue = JSApp.getAppName()
        versionLabel.stringValue = JSApp.appVersion + "(\(JSApp.buildVersion))"
        copyrightLabel.stringValue = "Copyright © 2019 Luci  Corporation. All Rights Reserved"
    }
    
}
