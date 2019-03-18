//
//  NumberConvert.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/18.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

class NumberConvert {
    
    static func readableNumber(_ input: Int?) -> String? {
        if input == nil {
            return nil
        }
        var prefixNum = 0.0
        let thousand = 1000.0
        let ten_thousand = 10000.0
        // 1万以上才显示
        let inputDouble = Double(input!)
        if inputDouble >= ten_thousand {
            prefixNum = inputDouble/thousand
            let output = String(format: "%.1fk", prefixNum)
            return output
        } else {
            return "\(String(describing: input!))"
        }
    }
}
