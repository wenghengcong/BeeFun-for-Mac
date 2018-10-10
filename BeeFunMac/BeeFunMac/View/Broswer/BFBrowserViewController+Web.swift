//
//  BFBrowserViewController+Web.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

extension BFBrowserViewController {
    
    func setupWebview() {
        
        websiteView.uiDelegate = self
        websiteView.navigationDelegate = self
        websiteView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        webprogressBar.minValue = 0.0
        webprogressBar.maxValue = 1.0
        webprogressBar.usesThreadedAnimation = true
        webprogressBar.controlTint = NSControlTint.defaultControlTint
        
        scaleWebViewContentPage()
        loadEmptyPage()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            //            print("home page webview progress: \(webView.estimatedProgress)")
            webprogressBar.doubleValue = websiteView.estimatedProgress
            if websiteView.estimatedProgress == 1 {
                webprogressBar.isHidden = true
            } else {
                webprogressBar.isHidden = false
            }
            scaleWebViewContentPage()
        }
    }
    
    func scaleWebViewContentPage() {
        
        let windowWidth = websiteView.width
        var scale = windowWidth/bestWebViewWidth
        if scale > 1 {
            scale = 1.0
        }
        websiteView?.setMagnification(scale, centeredAt: websiteView.center)
    }
    
    // 1. 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // 3. 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // 2.页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        let urlStr: String = (webView.url!.absoluteString)
        print("monitor web site : \(urlStr)")
        BFMonitor.shared.monitorRequest(urlStr)
    }
    
    // 接收到服务器重跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    // 4. 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        scaleWebViewContentPage()
    }
    
    // 5. 当内容返回完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webprogressBar.stopAnimation(nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

extension BFBrowserViewController {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    
    func webView(_ webView: WKWebView, runOpenPanelWith parameters: WKOpenPanelParameters, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping ([URL]?) -> Void) {
        
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        
    }
}
