//
//  BFMonitor+Handle.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/25.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFMonitor {
    
    /// 登陆成功
    @objc func userLogin(noti: NSNotification) {
        start()
    }
    
    /// 登出成功
    @objc func userLogout(noti: NSNotification) {
        stop()
    }
    
    /// 数据同步完成之后，压缩并上传
    @objc func syncStarRepoDone(noti: NSNotification) {
//        BFiCloudManager.shared.syncLocalDBToiCloud()
    }
    
    /// 自动同步iCloud与本地数据库
    @objc func autoSyncZipData() {
//        BFiCloudManager.shared.startiCloudQuery()
    }
    
    /// 用户改变了数据库就同步数据
    @objc func databaseChanged() {
//        BFiCloudManager.shared.syncLocalDBToiCloud()
    }
    
    /// 改变了同步时间，修改定时器
    @objc func changeSyncTime() {
        killTimer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(SyncPreferenceManager.shared.syncTimeInterval), target: self, selector: #selector(self.autoSyncZipData), userInfo: nil, repeats: true)
    }
    
    // MARK: - Utilies
    func killTimer() {
        if(timer != nil){
            timer!.invalidate()
            timer = nil
        }
    }
}
