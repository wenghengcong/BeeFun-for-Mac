//
//  BFHomeController+Util.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/2.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension BFHomeController {
    
    /// webview加载url
    func homeViewLoadURL(_ url: String?) {
        if url != nil {
            if let invaidURL = URL(string: url!) {
                let request = URLRequest(url: invaidURL)
                self.webView.load(request)
                scaleContentPage()
            }
        }
    }
    // TODO: - 开始检测登录操作
    func alertUserNeedLogin() -> Bool {
        if !UserManager.shared.isLogin {
            let alert = NSAlert()
            alert.messageText = kLoginFirstTip
            alert.informativeText = kLoginDetailTip
            alert.alertStyle = .warning
            alert.addButton(withTitle: "Go")
            alert.beginSheetModal(for: self.view.window!) { (model) in
                UserManager.shared.userSignIn()
                
            }
        }
        return UserManager.shared.isLogin
    }
}
