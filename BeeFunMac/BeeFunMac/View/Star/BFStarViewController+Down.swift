//
//  BFStarViewController+Down.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/20.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController: NSPopoverDelegate {

    
    // MARK: - Popover Delegate
    
    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }
    
    func popoverDidShow(_ notification: Notification) {
        
    }
    
    func popoverDidClose(_ notification: Notification) {
        let closeReason = notification.userInfo![NSPopover.closeReasonUserInfoKey] as! String
        if (closeReason == NSPopover.CloseReason.standard.rawValue) {
            
        }
    }
}

extension BFStarViewController: BFStarDownloadControllerProtocol {
    
    func didCopyUrlToClipboard() {
        downloadPopover.close()
        //TODO: 提示符无效
//        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//        hud?.mode = MBProgressHUDModeText
//        hud?.labelText = "Copied"
//        hud?.removeFromSuperViewOnHide = true
//        hud?.hide(true, afterDelay: 3.0)
    }
    
    func didClickDownloadZIP() {
        downloadPopover.close()

    }
    
    func didClickOpenInDesktop() {
        downloadPopover.close()

    }
    
    func didClickOpenInXcode() {
        downloadPopover.close()

    }
}


