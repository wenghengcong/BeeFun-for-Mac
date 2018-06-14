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
    
    func updateBeeFunDBFromGithub() {
        if !UserManager.shared.isLogin {
            return
        }
        
        let nowDate = Date().timeStamp
        let lastUpdate = UserDefaults.standard.integer(forKey: lastTimeStampKey)
        if nowDate - lastUpdate > 3 * 24 * 60 * 60 {
            updateRequest()
        }
    }
    
    func updateRequest() {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.updateBeeFunDBFromGithub()) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum {
                            if code == BFStatusCode.bfOk {
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
