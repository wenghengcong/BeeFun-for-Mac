//
//  BFJumpWebStie.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/24.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFJumpWebStie: NSObject {
    static let shared = BFJumpWebStie()
    
    /// 跳转到其他页面
    func jump(_ url: String) {
        if let checkURL = NSURL(string: url) {
            if NSWorkspace.shared.open(checkURL as URL) {
                print("URL Successfully Opened")
            }
        } else {
            print("Invalid URL")
        }
    }
    
}
