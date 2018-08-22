//
//  BFStarViewController+Down.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/20.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import Alamofire

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
        self.showHudAutoHide(message: "Copied to clipboard", delay: 0.9)
    }
    func didClickDownloadZIP(name: String, zipUrl: String) {
        
        downloadPopover.close()
        //下载地址：
        // https://github.com/Meniny/Ghost/archive/master.zip
        // https://github.com/youusername/magnetX/archive/master.zip
        
        let fileName = name + "-" + zipUrl.lastPathComponent
        let dialog = NSOpenPanel();
        dialog.title                   = "Download ZIP"
        dialog.message                 = "Choose Directory to save \(fileName)"
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
                if let result = dialog.url {
                    // Pathname of the file
                    print("save path: \(result.path)")
                    let saveToUrl = self.combineSaveFileUrl(directory: result, fileName: fileName)
                    self.startDownload(zipUrl: zipUrl, saveUrl: saveToUrl)
                }
            } else {
                // User clicked on "Cancel"
                return
            }
        }
    }
    
    func startDownload(zipUrl: String, saveUrl: URL) -> Void {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (saveUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(zipUrl, to:destination)
            .downloadProgress { (progress) in
                print("download progress: \(progress.fractionCompleted)")
                if progress.isFinished {
                    self.showHudAutoHide(message: "Download zip done!", delay: 0.9)
                }
            }
            .responseData { (data) in
                print("download down")
        }
    }
    
    /// 组装保存的文件路径
    ///
    /// - Parameters:
    ///   - directory: 用户选中的路径
    ///   - fileName: 文件名
    func combineSaveFileUrl(directory: URL, fileName: String) -> URL {
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let documentsURL = directory
        let nameUrl = URL(string: fileName)
        let fileURL = documentsURL.appendingPathComponent((nameUrl?.lastPathComponent)!)
        return fileURL
    }
    
    func didClickOpenInDesktop() {
        downloadPopover.close()

    }
    
    func didClickOpenInXcode() {
        downloadPopover.close()

    }
}


