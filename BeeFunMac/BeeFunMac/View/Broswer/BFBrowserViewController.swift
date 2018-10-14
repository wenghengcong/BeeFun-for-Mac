//
//  BFToolsViewController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/1.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

class BFBrowserViewController: NSViewController, WKUIDelegate, WKNavigationDelegate, NSTextFieldDelegate {

    @IBOutlet weak var navigationContainView: NSView!
    
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var forwardButton: NSButton!
    
    @IBOutlet weak var refreshButton: NSButton!
    
    @IBOutlet weak var websiteInputContainView: NSView!
    
    @IBOutlet weak var websiteInputTextField: NSTextField!
    
    @IBOutlet weak var webViewContainView: NSView!
    @IBOutlet weak var webprogressBar: NSProgressIndicator!
    @IBOutlet weak var websiteView: WKWebView!
    
    /// 该页面的user content支持以下操作
    // [action: jump, url: www.****]
    var userContent: [String: Any]? {
        didSet {
            parseUserContentAndHandle()
        }
    }
    
    /// 展示Github网站的最佳宽度
    var bestWebViewWidth: CGFloat = 1030
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupWebview()
        setupWebsiteInputTextField()
        
        addBrowserNoti()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        navigationContainView.backgColor = NSColor.xyWhiteDarkBlack
        webViewContainView.backgColor = NSColor.xyWhiteDarkBlack
        
    }
    
    deinit {
        //一定要移除KVO的监听,否则会crash
        self.websiteView?.removeObserver(self, forKeyPath: "estimatedProgress")
        NotificationCenter.default.removeObserver(self)
    }
}
