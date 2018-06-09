//
//  OAuthWebViewController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/24.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import OAuthSwift

import AppKit
import WebKit

typealias WebView = WKWebView

class OAuthGithubWebController: OAuthWebViewController {
    
    var targetURL: URL?
    let webView: WebView = WebView()
    var progressHud: MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in to GitHub"
        configWebView()
        configHudView()
    }
    
    func configWebView() {
        self.webView.frame = self.view.bounds
        self.webView.navigationDelegate = self
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|", options: [], metrics: nil, views: ["view":self.webView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: ["view":self.webView]))
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func configHudView() {
        progressHud = MBProgressHUD.init(view: self.view)
        self.view.addSubview(progressHud)
        progressHud.mode = MBProgressHUDModeDeterminate
        progressHud.delegate = self
        progressHud.removeFromSuperViewOnHide = true
        progressHud.labelText = "On the way..."
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
//            print("login page webview progress: \(webView.estimatedProgress)")
            progressHud.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress >= 0.7 {
                let _ : Void = {
                    progressHud.hide(true)
                }()
            }
        }
    }
    
    override func handle(_ url: URL) {
        targetURL = url
        super.handle(url)
        self.loadAddressURL()
    }
    
    func loadAddressURL() {
        guard let url = targetURL else {
            return
        }
        let req = URLRequest(url: url)
        self.webView.load(req)
        progressHud.show(true)
    }
}

extension OAuthGithubWebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // here we handle internally the callback url and call method that call handleOpenURL (not app scheme used)
        if let url = navigationAction.request.url , url.scheme == "beefunmac" {
            AppDelegate.sharedInstance.applicationHandle(url: url)
            decisionHandler(.cancel)
            self.dismissWebViewController()
            return
        }
        decisionHandler(.allow)
    }
    
    /* override func  webView(webView: WebView!, decidePolicyForNavigationAction actionInformation: [NSObject : AnyObject]!, request: URLRequest!, frame: WebFrame!, decisionListener listener: WebPolicyDecisionListener!) {
     
     if request.URL?.scheme == "oauth-swift" {
     self.dismissWebViewController()
     }
     
     } */
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(error)")
        self.dismissWebViewController()
        // maybe cancel request...
    }
}

extension OAuthGithubWebController: MBProgressHUDDelegate {
    public func hudWasHidden(_ hud: MBProgressHUD!) {
        progressHud.removeFromSuperview()
    }
}
