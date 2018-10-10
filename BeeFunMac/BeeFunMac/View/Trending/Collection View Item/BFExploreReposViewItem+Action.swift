//
//  BFExploreReposViewItem+Action.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFExploreReposViewItem {

    func addAction() {
        repoNameLabel.target = self
        repoNameLabel.action = #selector(clickRepoName)
        
        addClickGesture(gestureView: starImageView, action: #selector(clickStar))
        addClickGesture(gestureView: starLabel, action: #selector(clickStar))
        
        addClickGesture(gestureView: forkImageView, action: #selector(clickFork))
        addClickGesture(gestureView: forkLabel, action: #selector(clickFork))
    }
    
    func addClickGesture(gestureView: NSControl, action: Selector?) {
        let gesture = NSClickGestureRecognizer()
        gesture.buttonMask = 0x1 // left mouse
        gesture.numberOfClicksRequired = 1
        gesture.target = self
        gesture.action = action
        gestureView.addGestureRecognizer(gesture)
    }

    @objc func clickRepoName() {
        gotoBrowserPage(url: repoModel?.repo_url)
    }
    
    @objc func clickStar() {
        gotoBrowserPage(url: repoModel?.star_url)
    }
    
    @objc func clickFork() {
        gotoBrowserPage(url: repoModel?.fork_url)
    }
    
    @objc func clickBuiltByUser(sender: NSButton) {
        if let builtUsers = repoModel?.built_by_users {
            let user = builtUsers.item(at: sender.tag)
            gotoBrowserPage(url: user?.url)
        }
    }
    
     // MARK: - Utils
    func gotoBrowserPage(url: String?) {
        let userContent = combineJumpDiction(jumpUrl: url)
        AppDelegate.sharedInstance.mainController?.mainContentController?.gotoIcanPage(.broswer, userContent: userContent)
    }
    
    func combineJumpDiction(jumpUrl: String?) -> [String: Any]? {
        if let gotourl = jumpUrl {
            let dic: [String: Any] = ["action":"jump", "url": gotourl]
            return dic
        }
        
        let dic = ["action":"jump"]
        return dic
    }
}
