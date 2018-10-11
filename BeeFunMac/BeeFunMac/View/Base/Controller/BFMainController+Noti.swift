//
//  BFMainController+Noti.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/1.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import Kingfisher

extension BFMainController {
    
    /// 主视图登录成功
    @objc func mainViewLogin() {
        loadProfileInfo()
    }
    
    /// 主视图登出成功
    @objc func mainViewLogout() {
        let profileImage:NSImage = NSImage.init(named: NSImage.Name(rawValue: "iconbar_p_normal"))!
        profileButton.kf.setImage(with: profileImage as? Resource)
    }
    
    @objc func refreshViewWhenAppInReview() {
        if BFConfig.shared.appStoreInReview {
            browserButton.isHidden = true
            browserButton.isHidden = true
        } else {
            homeButton.isHidden = false
            homeBackView.isHidden = false
        }
    }
}
