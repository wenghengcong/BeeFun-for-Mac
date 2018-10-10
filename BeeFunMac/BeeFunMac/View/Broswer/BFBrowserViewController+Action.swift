//
//  BFBrowserViewController+Action.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFBrowserViewController {
    
    /// 回退
    @IBAction func goBack(_ sender: Any) {
        if alertUserNeedLogin() {
            if websiteView.canGoBack {
                websiteView.goBack()
            }
        }
    }
    
    /// 前进
    @IBAction func goForward(_ sender: Any) {
        if alertUserNeedLogin() {
            if websiteView.canGoForward {
                websiteView.goForward()
            }
        }
    }
    
    /// 刷新
    @IBAction func webRefresh(_ sender: Any) {
        if alertUserNeedLogin() {
            websiteView.reload()
        }
    }
    
    /// 回到首页
    @IBAction func goHome(_ sender: Any) {
        if alertUserNeedLogin() {
            self.loadWebsite(BFGithubWebsite.home)
        }
    }
    
    
    
}
