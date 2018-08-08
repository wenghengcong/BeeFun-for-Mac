//
//  BFStarViewController+Noti.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/28.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    // MARK: - lefe cycle
    internal func addNotification() {
        //登出
        NotificationCenter.default.addObserver(self, selector: #selector(userDidLogout(noti:)), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
        //tag操作
        NotificationCenter.default.addObserver(self, selector: #selector(addTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.AddTag, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.UpdateTag, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(delTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.DelTag, object: nil)
        //repo操作
        NotificationCenter.default.addObserver(self, selector: #selector(repoUpdateTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.RepoUpdateTag, object: nil)
        //是否开始同步
        NotificationCenter.default.addObserver(self, selector: #selector(syncStarRepoBegin(noti:)), name: NSNotification.Name.BeeFun.SyncStarRepoStart, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(syncStarRepoDone(noti:)), name: NSNotification.Name.BeeFun.SyncStarRepoEnd, object: nil)
        
        let repoScrollView = starTable.enclosingScrollView
//        let repoScrollContentView = repoScrollView?.contentView
//        repoScrollContentView?.postsBoundsChangedNotifications = true
        NotificationCenter.default.addObserver(self, selector: #selector(repoScrollViewDidScroll(_:)), name: NSScrollView.didEndLiveScrollNotification, object: repoScrollView)

//        NotificationCenter.default.addObserver(self, selector: #selector(repoClipViewBoundDidChange(_:)), name: NSView.boundsDidChangeNotification, object: repoScrollContentView)
        
        let tagScrollView = tagTable.enclosingScrollView
        // a register for those notifications on the content view.
        NotificationCenter.default.addObserver(self, selector: #selector(tagScrollViewDidScroll(_:)), name: NSScrollView.didEndLiveScrollNotification, object: tagScrollView)
        
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(windowWillCloseAction(noti:)), name: NSWindow.willCloseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(windowWillCloseAction(noti:)), name: NSWindow.willMiniaturizeNotification, object: nil)

    }
    
    @objc func windowWillCloseAction(noti: NSNotification) {
        NSApplication.shared.activate(ignoringOtherApps: true)
//        self.repoTagsTextField.matches = nil
        self.repoTagsTextField.autoCompletePopover?.performClose(nil)
//        self.repoTagsTextField.complete(nil)
        self.repoTagsTextField.autoCompletePopover?.contentViewController?.view.window?.close()
//        self.repoTagsTextField.contentViewController?.dismiss(nil)
//        if NSApp.windows.count >= 2 {
////            if let popWindow = self.repoTagsTextField.contentViewController?.view.window {
////                popWindow.close()
////            }
//            NSApp.windows.last?.close()
//        }
    }
    
    @objc func windowWillMiniaturizeAction(noti: NSNotification) {
        NSApplication.shared.activate(ignoringOtherApps: true)

//        self.repoTagsTextField.autoCompletePopover?.performClose(nil)
        self.repoTagsTextField.matches = nil
        self.repoTagsTextField.complete(nil)
        self.repoTagsTextField.autoCompletePopover?.contentViewController?.view.window?.close()

//        self.repoTagsTextField.contentViewController?.dismiss(nil)
//        if NSApp.windows.count >= 2 {
////            if let popWindow = self.repoTagsTextField.contentViewController?.view.window {
////                popWindow.close()
////            }
//            NSApp.windows.last?.close()
//        }
    }
    
    internal func removeNotification() {
        self.repoWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 登录登出
    @objc func userDidLogout(noti: NSNotification) {
        refreshStopRotate()
    }
    
    // MARK: - 同步
    @objc func syncStarRepoBegin(noti: NSNotification) {
        getFirstPageTags()
        refreshStartRotate()
    }
    
    @objc func syncStarRepoDone(noti: NSNotification) {
        //刷新按钮停止转动
        refreshStopRotate()
        searchStarReposNow(allRefresh: true, scrollToTop: true)
    }
    
    // MARK: - Tag操作
    @objc func addTagSuccessful(noti: NSNotification) {
        //1. 刷新布局
        reLayoutWorkingLayout()
        //2. 重新刷新tag管理区域的列表
        getFirstPageTags()
    }
    
    @objc func updateTagSuccessful(noti: NSNotification) {
        refreshAfterRightMenuAction(delete: false, noti: noti)
    }
    
    @objc func delTagSuccessful(noti: NSNotification) {
        //在删除tag后刷新相关页面
        refreshAfterRightMenuAction(delete: true, noti: noti)
    }
    
    // MARK: - Repo操作
    // 对repo更新tag成功后的通知， 刷新当前repo列表
    @objc func repoUpdateTagSuccessful(noti: NSNotification) {
        getFirstPageTags()
        if let userinfo = noti.userInfo, let updateTagsList: [ObjTag] = userinfo["star_tags"] as? [ObjTag] {
            if !starReposData.isBeyond(index: selectedRepoRow) {
                let selectedRepo = starReposData[selectedRepoRow]
                selectedRepo.star_tags = convertObjListToStringList(tags: updateTagsList)
                oriSelRepoStatTags = selectedRepo.star_tags
            }
        }
        
        self.starTable.reloadData(forRowIndexes:  IndexSet.init(integer: self.selectedRepoRow), columnIndexes:  IndexSet.init(integer: 0))
        if let rowCell = self.starTable.view(atColumn: 0, row: self.selectedRepoRow, makeIfNecessary: false) as? BFStarTableCellView {
            rowCell.didSelectedCell(selected: true)
        }
    }
    
    // MARK: - Scroll notification
    @objc func repoClipViewBoundDidChange(_ notification: Notification) {
//        let changedContentView = notification.object
    }
    
    @objc func repoScrollViewDidScroll(_ notification: Notification) {
        if let scrollView: NSScrollView = notification.object as? NSScrollView {
            let visibleRect = scrollView.contentView.visibleRect
            let currentPosition = visibleRect.origin
            if let percent = scrollView.verticalScroller?.doubleValue {
                print("visiable rect: \(visibleRect) positon: \(currentPosition)  percent: \(percent)")
                if (percent >= 0.7 || percent == 1.0) && !getReposNextPageLoading {
                    getReposNextPageLoading = true
                    getNextPageStarRepos(allRefresh: false, scrollToTop: false)
                }
            }
        }
    }
    
    @objc func tagScrollViewDidScroll(_ notification: Notification) {
        if let scrollView: NSScrollView = notification.object as? NSScrollView {
            let visibleRect = scrollView.contentView.visibleRect
            let currentPosition = visibleRect.origin
            if let percent = scrollView.verticalScroller?.doubleValue {
                print("visiable rect: \(visibleRect) positon: \(currentPosition)  percent: \(percent)")
                if (percent >= 0.7 || percent == 1.0) && !getTagsNextPageLoading {
                    getTagsNextPageLoading = true
                    getNextPageTags()
                }
            }
        }
    }
}
