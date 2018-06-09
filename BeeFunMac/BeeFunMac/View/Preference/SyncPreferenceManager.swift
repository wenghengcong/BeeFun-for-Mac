//
//  SyncPreferenceManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/25.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class SyncPreferenceManager {
    static let shared = SyncPreferenceManager()
    
    fileprivate let syncTimeIntervalKey = "syncTimeIntervalKey"
 
    fileprivate let userDefaults = UserDefaults.standard

    fileprivate init() {
        registerUserDefault()
    }
    
    fileprivate func registerUserDefault() {
        let firstDefault = [
                            syncTimeIntervalKey: 120,
                            ]
            as [String : Any]
        userDefaults.register(defaults: firstDefault)
    }
    
    var syncTimeInterval:Int {
        get{
            #if DEBUG
                return 20
            #else
                return userDefaults.object(forKey: syncTimeIntervalKey) as! Int
            #endif
        }
        set{
            userDefaults.set(newValue, forKey: syncTimeIntervalKey)
        }
    }
}
