//
//  BFMonitor.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/25.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFMonitor: NSObject {
    
    static let shared = BFMonitor()
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(noti:)), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLogout(noti:)), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
        
        if !UserManager.shared.isLogin {
            return
        }
    }
    
    func stop() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func monitorRequest(_ url: String) {
        if url == "https://github.com/" {
            return
        }
        if url.contains("github.com/login") || url.contains("github.com/signin") {
            //打开登录页面
            
        } else if url.contains("github.com/logout") || url.contains("github.com/signout") {
            //登出
            UserManager.shared.userSignOut()
        } else if url.contains("github.com") && url.contains("subscription") {
            //star
            
        } else if url.contains("github.com/logout") || url.contains("github.com/signout") {
            //登出
            
        }
    }
    
}
