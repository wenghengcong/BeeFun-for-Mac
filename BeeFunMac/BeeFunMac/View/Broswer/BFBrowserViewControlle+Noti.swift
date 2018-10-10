//
//  BFBrowserViewControlle+Noti.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFBrowserViewController {
    
    func addBrowserNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResize(_:)), name: NSWindow.didResizeNotification, object: websiteView.window)
        NotificationCenter.default.addObserver(self, selector: #selector(homeViewLogin), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(homeViewLogout), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
    }
    
    /// Home时登录成功，跳转到首页
    @objc func homeViewLogin() {
        self.loadWebsite(BFGithubWebsite.home)
    }
    
    /// Home时登出成功，打开登录窗口
    @objc func homeViewLogout() {
        
    }
    
    @objc func windowDidResize(_ notification: Notification) {
        
//        webprogressBar.snp.remakeConstraints { (make) in
//            make.top.equalTo(websiteView.snp.top).offset(-1)
//            make.leading.equalTo(0)
//            make.trailing.equalTo(0)
//            make.height.equalTo(5)
//        }
//        
//        websiteView.snp.remakeConstraints { (make) in
//            make.bottom.equalTo(0)
//            make.leading.equalTo(0)
//            make.top.equalTo(66)
//            make.trailing.equalTo(0)
//        }
        scaleWebViewContentPage()
    }
}
