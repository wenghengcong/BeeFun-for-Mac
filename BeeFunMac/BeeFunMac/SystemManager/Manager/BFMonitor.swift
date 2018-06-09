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
    var timer: Timer?
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin(noti:)), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userLogout(noti:)), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
        
        if !UserManager.shared.isLogin {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(syncStarRepoDone(noti:)), name: NSNotification.Name.BeeFun.syncStarRepoDone, object: nil)
        //修改了同步时间
        NotificationCenter.default.addObserver(self, selector: #selector(changeSyncTime), name: NSNotification.Name.BeeFun.syncTimeChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(databaseChanged), name: NSNotification.Name.BeeFun.databaseChanged, object: nil)

        timer = Timer.scheduledTimer(timeInterval: TimeInterval(SyncPreferenceManager.shared.syncTimeInterval), target: self, selector: #selector(self.autoSyncZipData), userInfo: nil, repeats: true)
    }
    
    func stop() {
        NotificationCenter.default.removeObserver(self)
        killTimer()
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
