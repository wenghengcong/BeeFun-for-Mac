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
    
    func updateBeeFunDBFromGithub() {
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.syncStarRepoBegin, object: nil)
        BeeFunProvider.sharedProvider.request(BeeFunAPI.updateBeeFunDBFromGithub()) { (result) in
            
            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.syncStarRepoDone, object: nil)
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum {
                            if code == BFStatusCode.bfOk {
                                //添加成功
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
