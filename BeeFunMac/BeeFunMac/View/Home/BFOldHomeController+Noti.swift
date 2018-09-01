//
//  BFHomeController+Noti.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/2.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension BFOldHomeController {

    func addHomeNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResize(_:)), name: NSWindow.didResizeNotification, object: self.webView.window)
        NotificationCenter.default.addObserver(self, selector: #selector(homeViewLogin), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(homeViewLogout), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
    }
    
    /// Home时登录成功，跳转到首页
    @objc func homeViewLogin() {
        self.homeViewLoadURL(BFGithubWebsite.home)
    }
    
    /// Home时登出成功，打开登录窗口
    @objc func homeViewLogout() {
        
    }
    
    @objc func windowDidResize(_ notification: Notification) {
        
        self.webProgress.snp.remakeConstraints { (make) in
            make.top.equalTo(self.webView.snp.top).offset(-1)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(5)
        }
        
        self.webView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(66)
            make.trailing.equalTo(0)
        }
        scaleContentPage()
    }
}
