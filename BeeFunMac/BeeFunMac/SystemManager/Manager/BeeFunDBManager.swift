//
//  BeeFunDBManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/14.
//  Copyright © 2018年 JungleSong. All rights reserved.
//

import AppKit
import ObjectMapper

class BeeFunDBManager: NSObject {
    
    static let shared = BeeFunDBManager()
    
    /// 是否正在更新数据库
    var isUpdating: Bool = false
    
    var lastTimeStampKey = "lastUpdateFromGithub"

    func updateServerDB(first: Bool) {
        if !UserManager.shared.isLogin || isUpdating {
            return
        }

        let nowDate = Date().timeStamp
        let lastUpdate = UserDefaults.standard.integer(forKey: lastTimeStampKey)
        if (nowDate - lastUpdate > 1 * 24 * 60 * 60) || first {
           return updateRequest(first: first, update: true)
        } else {
           return updateRequest(first: first, update: false)
        }
    }
    
    /// 更新请求
    ///
    /// - Parameter update: 是否更新所有已经在server db存在repo的信息
    private func updateRequest(first: Bool, update: Bool) {

        //开始同步数据
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.SyncStarRepoStart, object: nil)
        isUpdating = true
        
        print("begin update beefun database")
        BeeFunProvider.sharedProvider.request(BeeFunAPI.updateServerDB(first: first, update: update)) { (result) in
            
            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.SyncStarRepoEnd, object: nil)
            self.isUpdating = false
            
            switch result {
            case let .success(response):
                do {
                    if let tagResponse = Mapper<BeeFunResponseModel<ObjBase>>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum, code == BFStatusCode.bfOk {
                            if update {
                                //添加成功
                                UserDefaults.standard.set(Date().timeStamp, forKey: self.lastTimeStampKey)
                            }
                        }
                    }
                } catch {
                }
            case .failure:
                break
            }
        }
    }
}
