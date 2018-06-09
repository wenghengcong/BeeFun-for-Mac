//
//  BFWebView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/29.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

class BFWebViewManager:NSObject, WKNavigationDelegate {

    var webView: WKWebView?
    weak var bf_navigationDelegate: BFWKNavigationDelegate?
    
    override init() {
        super.init()
        let prefs = WKPreferences()
        prefs.plugInsEnabled = true // NPAPI for Flash, Java, Hangouts
        prefs.minimumFontSize = 14
        prefs.javaScriptCanOpenWindowsAutomatically = true;
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        config.suppressesIncrementalRendering = false
        
        self.webView = WKWebView(frame: CGRect.zero, configuration: config)
        self.webView?.navigationDelegate = self
    }
    
    
    convenience init(config: WKWebViewConfiguration = WKWebViewConfiguration()) {
        self.init()
        self.webView = WKWebView(frame: CGRect.zero, configuration: config)
        self.webView?.navigationDelegate = self
    }
    
}

extension BFWebViewManager {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        self.bf_navigationDelegate?.bf_webView(self.webView!, navigationAction: navigationAction, decisionHandler: decisionHandler)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void){
        self.bf_navigationDelegate?.bf_webView(self.webView!, navigationResponse: navigationResponse, decisionHandler: decisionHandler)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didStartProvisionalNavigation: navigation)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didReceiveServerRedirectForProvisionalNavigation: navigation)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didFailProvisionalNavigation: navigation, withError: error)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didCommit: navigation)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didFinish: navigation)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        self.bf_navigationDelegate?.bf_webView(self.webView!, didFail: navigation, withError: error)
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView){
        self.bf_navigationDelegate?.bf_webViewWebContentProcessDidTerminate(self.webView!)
    }
}
