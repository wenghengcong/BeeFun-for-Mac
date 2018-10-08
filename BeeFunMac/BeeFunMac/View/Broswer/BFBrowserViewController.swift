//
//  BFToolsViewController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/1.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

class BFBrowserViewController: NSViewController {

    @IBOutlet weak var navigationContainView: NSView!
    
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    
    @IBOutlet weak var refreshButton: NSButton!
    
    @IBOutlet weak var websiteInputContainView: NSView!
    
    @IBOutlet weak var websiteInputTextField: NSTextField!
    
    @IBOutlet weak var webViewContainView: NSView!
    @IBOutlet weak var webprogressBar: NSProgressIndicator!
    @IBOutlet weak var websiteView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        navigationContainView.backgColor = NSColor.white
        webViewContainView.backgColor = NSColor.white
        
        webprogressBar.alphaValue = 0.0
        webprogressBar.isHidden = true
    }
    
}
