//
//  WKWebView+Extension.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/30.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

extension WKWebView {
    
    /// load url in string
    ///
    /// - Parameter url: url sting
    /// - Returns: A new navigation for the given request
    open func load(_ url: String) -> WKNavigation? {
        if let invaidURL = URL(string: url) {
            let request = URLRequest(url: invaidURL)
            return self.load(request)
        }
        return nil
    }
}
