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
    
    // MARK: - Utils
    func gotoPage(url: String?) {
        let userContent = combineJumpDictionary(jumpUrl: url)
        AppDelegate.sharedInstance.mainController?.mainContentController?.gotoIcanPage(.broswer, userContent: userContent)
    }
    
    func combineJumpDictionary(jumpUrl: String?) -> [String: Any]? {
        if let gotourl = jumpUrl {
            let dic: [String: Any] = ["action":"jump", "url": gotourl]
            return dic
        }
        
        let dic = ["action":"jump"]
        return dic
    }
}
