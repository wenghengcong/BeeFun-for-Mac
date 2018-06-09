//
//  TimeHelper.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/10.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import SwiftDate

class TimeHelper: NSObject {
    static let shared = TimeHelper()
    
    /// 返回互联网时间
    ///
    /// - Parameters:
    ///   - rare: 原来的字符串
    ///   - prefix: 时间前缀
    /// - Returns: 返回互联网时间
    func internetTime(rare: String?, prefix: String?) -> String? {
        
        if let rareStr: String = rare {
            let createAt: DateInRegion = rareStr.date(format: DateFormat.iso8601(options: .withInternetDateTime))!
            
            var internet = createAt.string()
            if prefix != nil {
                internet = prefix!.localized + " :" + internet
            }
            return internet
            
        }
        return nil
    }
    
    /// 返回可读时间
    ///
    /// - Parameters:
    ///   - rare: 原来的时间字符串
    ///   - prefix: 时间前缀
    /// - Returns: 返回可读时间
    func readableTime(rare: String?, prefix: String?) -> String? {
        
        if let rareStr: String = rare {
            do {
                let createAt: DateInRegion =  rareStr.date(format: DateFormat.iso8601(options: .withInternetDateTime))!
                
                var (readable, _) = try createAt.colloquialSinceNow()
                if prefix != nil {
                    readable = prefix!.localized + " :"  + readable
                }
                return readable
            } catch {
                return nil
            }
        }
        
        return nil
    }
    
}
