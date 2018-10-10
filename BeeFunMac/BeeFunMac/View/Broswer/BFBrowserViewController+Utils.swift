//
//  BFBrowserViewController+Utils.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFBrowserViewController {
    
    /// webview加载url
    func loadWebsite(_ url: String?) {
        
        if url != nil {
            if (!(url!.contains("https")) || !(url!.contains("http")) ) {
                let httpUrl = "https://" + url!
                _ = websiteView.load(httpUrl)
            } else {
                _ = websiteView.load(url!)
            }
        } else {
            loadEmptyPage()
        }
    }
    
    func loadEmptyPage() {
        websiteView.load(URLRequest(url: URL(string:"about:blank")!))
        scaleWebViewContentPage()
    }
    
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
