//
//  BFConfig.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/6/26.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class BFConfig: NSObject {
    
    static let shared = BFConfig()
    
    /// 是否在审核中
    var appStoreInReview = true
    
    func getConfig() {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.config()) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let configs = Mapper<BeeFunResponseModel<BFConfigModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = configs.codeEnum, code == BFStatusCode.bfOk, let data = configs.data {
                            self.handleConfigs(configs: data)
                        }
                    }
                } catch {
                }
            case .failure:
                break
            }
        }
    }
    
    func handleConfigs(configs: [BFConfigModel]) {
        for config in configs {
            if config.cg_key == "inreview" {
                if let value = config.cg_value {
                    appStoreInReview = (value == "1") ? true : false
                    NotificationCenter.default.post(name: NSNotification.Name.BeeFun.AppInReview, object: nil)
                }
            }
        }
    }
}
