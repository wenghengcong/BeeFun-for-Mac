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
    
    func didClickDownloadZIP(url: String) {
        downloadPopover.close()
        //下载地址：
        // https://github.com/Meniny/Ghost/archive/master.zip
        // https://github.com/youusername/magnetX/archive/master.zip
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose a .txt file"
        dialog.message                 = "Choose path to save zip"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = false
        dialog.canChooseDirectories    = true
        dialog.canCreateDirectories    = true
        dialog.canChooseFiles          = false
        dialog.allowsMultipleSelection = false
        dialog.treatsFilePackagesAsDirectories = true
        dialog.showsTagField           = true
        dialog.prompt = "Save"
//        dialog.allowedFileTypes        = ["txt"];
        dialog.beginSheetModal(for: self.view.window!) { (response) in
            if (response == NSApplication.ModalResponse.OK) {
                let result = dialog.url // Pathname of the file
                
                if (result != nil) {
                    let path = result!.path
                    print("save path: \(path)")
                }
            } else {
                // User clicked on "Cancel"
                return
            }
        }
    }
    
    func didClickOpenInDesktop() {
        downloadPopover.close()

    }
    
    func didClickOpenInXcode() {
        downloadPopover.close()

    }
}


