//
//  ReadPreference.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/19.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

struct ReadPreference {
    
    static let shard = ReadPreference()
    
    func registerMenuWhenAppOpen() -> Bool {
        if let saveValue = UserDefaults.standard[.RegisterMenuWhenAppOpen]
        , let regis = Bool(saveValue) {
            return regis
        }
        return true
    }
}
