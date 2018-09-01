//
//  BFHomeController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/30.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit
import Alamofire
import ObjectMapper

class BFOldHomeController: NSViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var homeButton: NSButton!
    
    @IBOutlet weak var webProgress: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        configWebview()
        addHomeNoti()
    }
    
    deinit {
//        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

