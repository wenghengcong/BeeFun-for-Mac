//
//  BFHomeController+WebView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/2.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

extension BFOldHomeController {
    
    func configWebview() {
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        webProgress.minValue = 0.0
        webProgress.maxValue = 1.0
        webProgress.usesThreadedAnimation = true
        webProgress.controlTint = NSControlTint.defaultControlTint
        self.webProgress.snp.makeConstraints { (make) in
            make.top.equalTo(self.webView.snp.top).offset(-1)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(5)
        }
        scaleContentPage()
        self.homeViewLoadURL(BFGithubWebsite.home)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
//            print("home page webview progress: \(webView.estimatedProgress)")
            webProgress.doubleValue = webView.estimatedProgress
            if webView.estimatedProgress == 1 {
                webProgress.isHidden = true
            } else {
                webProgress.isHidden = false
            }
            scaleContentPage()
        }
    }
    
    func scaleContentPage() {
        let bestWidth: CGFloat = 1030
        let windowWidth = self.webView.width
        var scale = windowWidth/bestWidth
        if scale > 1 {
            scale = 1.0
        }
        self.webView?.setMagnification(scale, centeredAt: self.webView.center)
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
        scaleContentPage()
    }
    
    // 5. 当内容返回完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webProgress.stopAnimation(nil)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

extension BFOldHomeController {
    
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

