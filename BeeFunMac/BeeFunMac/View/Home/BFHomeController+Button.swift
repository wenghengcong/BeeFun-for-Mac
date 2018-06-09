//
//  BFHomeController+Button.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/2.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension BFHomeController {
    
    /// 回退
    @IBAction func goBack(_ sender: Any) {
        if alertUserNeedLogin() {
            if self.webView.canGoBack {
                self.webView.goBack()
            }
        }
    }
    
    /// 前进
    @IBAction func goForward(_ sender: Any) {
        if alertUserNeedLogin() {
            if self.webView.canGoForward {
                self.webView.goForward()
            }
        }
    }
    
    /// 刷新
    @IBAction func webRefresh(_ sender: Any) {
        if alertUserNeedLogin() {
            self.webView.reload()
        }
    }
    
    /// 回到首页
    @IBAction func goHome(_ sender: Any) {
        if alertUserNeedLogin() {
            self.homeViewLoadURL(BFGithubWebsite.home)
        }
    }
}
