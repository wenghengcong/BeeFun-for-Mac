//
//  BFStarViewController+WebView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/12.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit
import Down

// MARK: - Tools View
extension BFStarViewController {
    @objc func webViewBackAction(sender: NSButton) {
        if let webview = self.repoWebView {
            if webview.canGoBack {
                webview.goBack()
            }
        }
    }
    
    @objc func webViewForwardAction(sender: NSButton) {
        if let webview = self.repoWebView {
            if webview.canGoForward {
                webview.goForward()
            }
        }
    }
    
    @objc func webViewRefreshAction(sender: NSButton) {
        if let webview = self.repoWebView {
            webview.reload()
        }
    }
    
    @objc func webViewHomeAction(sender: NSButton?) {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            loadRepoReadMePage(objRepo: objrepo)
        }
    }
}

extension BFStarViewController {
    
    // MARK: - Webview
    func starPageConfigWebView() {
        
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-\(self.rightContentView.width), initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
        "head.appendChild(meta);";
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        self.webIndicator.isDisplayedWhenStopped = false
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(script)

        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        
        let toolsViewH: CGFloat = 65
        let rect = CGRect(x: 10, y: 0, width: self.rightContentView.width-10, height: self.rightContentView.height-toolsViewH)
        self.repoWebView = WKWebView(frame: rect, configuration: wkWebConfig)
//        do {
//            self.repoWebView = try DownView(frame: rect, markdownString: "", openLinksInBrowser: false, templateBundle: nil, didLoadSuccessfully: {
//
//            })
//        } catch {
//
//        }

        self.rightContentView.addSubview(self.repoWebView!)
        
        self.repoWebView!.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(10)
            make.top.equalTo(self.rightContentView).offset(toolsViewH)
            make.trailing.equalTo(0)
        }
        
        self.repoWebView?.uiDelegate = self
        self.repoWebView?.navigationDelegate = self
        self.repoWebView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.repoWebView?.allowsBackForwardNavigationGestures = true
        self.repoWebView?.allowsLinkPreview = true
        scaleContentPage()
    }
    
    /// 自定义webview 的工具栏
    func starPageCustomWebViewTools() {
        self.webViewBackBtn.target = self
        self.webViewBackBtn.action = #selector(webViewBackAction(sender:))
        
        self.webViewForwardBtn.target = self
        self.webViewForwardBtn.action = #selector(webViewForwardAction(sender:))
        
        self.webViewRefreshBtn.target = self
        self.webViewRefreshBtn.action = #selector(webViewRefreshAction(sender:))
        
        self.webViewHomeBtn.target = self
        self.webViewHomeBtn.action = #selector(webViewHomeAction(sender:))
    }
    
    func scaleContentPage() {
        let bestWidth: CGFloat = 1030
        let windowWidth = self.rightContentView.width
        let scale = windowWidth/bestWidth
        self.repoWebView?.setMagnification(scale, centeredAt: self.rightContentView.center)
    }
    
    /// webview加载url
    func repoLoadURL(_ url: String?) {
        if url != nil {
            if let invaidURL = URL(string: url!) {
                let request = URLRequest(url: invaidURL)
                self.repoWebView?.load(request)
                scaleContentPage()
            }
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            if let progress = repoWebView?.estimatedProgress {
                print("repo load content ....\(String(describing: progress))")
                if progress == 1 {
                    self.webIndicator.stopAnimation(nil)
                    scaleContentPage()
                }
            }
            
        }
    }
    
    // 1. 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("repo goto url: \(String(describing: webView.url?.absoluteString))")
        self.webIndicator.startAnimation(nil)
        decisionHandler(.allow)
    }
    // 3. 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    // 2.页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 接收到服务器重跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    // 4. 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let _: String = (webView.url!.absoluteString)
        scaleContentPage()
    }
    
    // 5. 当内容返回完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("repo get contnet")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("repo get contnet error:\(error.localizedDescription)")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

extension BFStarViewController {
    
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
