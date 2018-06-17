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
    var lastTimeStampKey = "lastUpdateFromGithub"
    
    func updateServerDB() {
        if !UserManager.shared.isLogin {
            return
        }
        
        let nowDate = Date().timeStamp
        let lastUpdate = UserDefaults.standard.integer(forKey: lastTimeStampKey)
        if nowDate - lastUpdate > 1 * 24 * 60 * 60 {
            updateRequest(update: true)
        } else {
            updateRequest(update: false)
        }
    }
    
    /// 更新请求
    ///
    /// - Parameter update: 是否更新所有已经在server db存在repo的信息
    private func updateRequest(update: Bool) {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.updateServerDB(update: update)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
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
