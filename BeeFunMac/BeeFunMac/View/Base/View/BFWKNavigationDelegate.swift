//
//  WKWebView+Monitor.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/26.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

public protocol BFWKNavigationDelegate : class {
    
    @available(OSX 10.10, *)
    // 1. 在发送请求之前，决定是否跳转
    func bf_webView(_ webView: WKWebView, navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    
    @available(OSX 10.10, *)
    // 3. 在收到响应后，决定是否跳转
    func bf_webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void)
    
    @available(OSX 10.10, *)
    // 2.页面开始加载时调用
    func bf_webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    
    @available(OSX 10.10, *)
    // 接收到服务器重跳转请求之后调用
    func bf_webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)
    
    @available(OSX 10.10, *)
    // 页面加载失败时调用
    func bf_webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    
    @available(OSX 10.10, *)
    // 4. 当内容开始返回时调用
    func bf_webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    
    @available(OSX 10.10, *)
    // 5. 当内容返回完成时调用
    func bf_webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    
    @available(OSX 10.10, *)
    func bf_webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    
//    @available(OSX 10.10, *)
//    func bf_webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void)
    
    @available(OSX 10.11, *)
    func bf_webViewWebContentProcessDidTerminate(_ webView: WKWebView)
}

