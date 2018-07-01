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
        NotificationCenter.default.addObserver(self, selector: #selector(addTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.AddTag, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(repoUpdateTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.RepoUpdateTag, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(delTagSuccessful(noti:)), name: NSNotification.Name.BeeFun.DelTag, object: nil)
        
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
    }
    
    internal func removeNotification() {
        self.repoWebView?.removeObserver(self, forKeyPath: "estimatedProgress")
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func syncStarRepoBegin(noti: NSNotification) {
        refreshStartRotate()
    }
    
    @objc func syncStarRepoDone(noti: NSNotification) {
        //刷新按钮停止转动
        refreshStopRotate()
        searchStarReposNow(allRefresh: true, scrollToTop: true)
    }
    
    // MARK: - 重新
    @objc func addTagSuccessful(noti: NSNotification) {
        //1. 刷新布局
        reLayoutWorkingLayout()
        //2. 重新刷新tag管理区域的列表
        getFirstPageTags()
    }
    
    
    // 对repo更新tag成功后的通知， 刷新当前repo列表
    @objc func repoUpdateTagSuccessful(noti: NSNotification) {
        
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
    
    @objc func delTagSuccessful(noti: NSNotification) {
        //在删除tag后刷新相关页面
        self.refreshAfterRightMenuAction(delete: true)
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
