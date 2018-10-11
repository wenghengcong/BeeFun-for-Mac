//
//  BFBrowserManager.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFBrowserManager: NSObject {
    static let shared = BFBrowserManager()
    
    // MARK: - Public
    func openUrl(url: String?)  {
        if BFConfig.shared.appStoreInReview {
            openSystemDefaultWebBrowser(url: url)
        } else {
            openInternalWebBrowser(url: url)
        }
    }
    
    // MARK: - Utils
    
    /// 利用系统默认的浏览器打开网页
    ///
    /// - Parameter url: url地址
    private func openSystemDefaultWebBrowser(url: String?) {
        if url != nil {
            if let jumpUrl = URL(string: url!) {
                NSWorkspace.shared.open(jumpUrl)
            }
        } else {
            print("error: default browser jumpurl is nil")
        }
    }
    
    /// 内部浏览器打开网页
    ///
    /// - Parameter url: url地址
    private func openInternalWebBrowser(url: String?) {
        let userContent = combineJumpDictionary(jumpUrl: url)
        AppDelegate.sharedInstance.mainController?.mainContentController?.gotoIcanPage(.broswer, userContent: userContent)
    }
    
    private func combineJumpDictionary(jumpUrl: String?) -> [String: Any]? {
        if let gotourl = jumpUrl {
            let dic: [String: Any] = ["action":"jump", "url": gotourl]
            return dic
        }
        
        let dic = ["action":"jump"]
        return dic
    }
}
