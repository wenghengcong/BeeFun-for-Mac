//
//  BFMonitor+Handle.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/25.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFMonitor {
    
    /// 登陆成功
    @objc func userLogin(noti: NSNotification) {
        start()
    }
    
    /// 登出成功
    @objc func userLogout(noti: NSNotification) {
        stop()
    }
    
}
