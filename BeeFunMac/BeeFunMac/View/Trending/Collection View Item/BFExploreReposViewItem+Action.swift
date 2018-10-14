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
        
        starImageView.addSingleLeftClickGesture(action: #selector(clickStar))
        starLabel.addSingleLeftClickGesture(action: #selector(clickStar))

        forkImageView.addSingleLeftClickGesture(action: #selector(clickFork))
        forkLabel.addSingleLeftClickGesture(action: #selector(clickFork))
        
        starButton.target = self
        starButton.action = #selector(clickStarRequest)
    }
    
    @objc func clickRepoName() {
        BFBrowserManager.shared.openUrl(url: repoModel?.repo_url)
    }
    
    @objc func clickStar() {
        BFBrowserManager.shared.openUrl(url: repoModel?.star_url)
    }
    
    @objc func clickFork() {
        BFBrowserManager.shared.openUrl(url: repoModel?.fork_url)
    }
    
    @objc func clickStarRequest() {
        if starButton.title == "Star" {
            starRequest()
        } else if starButton.title == "Unstar" {
            unstarRequest()
        }
    }
    
    @objc func clickBuiltByUser(sender: NSButton) {
        if let builtUsers = repoModel?.built_by_users {
            let user = builtUsers.item(at: sender.tag)
            BFBrowserManager.shared.openUrl(url: user?.url)
        }
    }

}


// MARK: - Star request
extension BFExploreReposViewItem {
    
    func checkStarted() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let owner = repoModel?.repo_owner, let repoName = repoModel?.repo_name {
            Provider.sharedProvider.request(.checkStarred(owner:owner, repo:repoName) ) { (result) -> Void in
//                print(result)
                switch result {
                case let .success(response):
                    let starred = (response.statusCode == BFStatusCode.noContent.rawValue)
                    self.repoModel?.starred = starred
                case .failure:
                    break
                }
                self.refreshStarButtonState()
            }
        }
    }
    
    func unstarRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let owner = repoModel?.repo_owner, let repoName = repoModel?.repo_name {
            Provider.sharedProvider.request(.unstarRepo(owner:owner, repo:repoName) ) { (result) -> Void in
//                print(result)
                switch result {
                case let .success(response):
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        self.repoModel?.starred = false
                        self.delegate?.starReposStateChange(repoViewItem: self, starState: true)
                    } else {
                        //TODO: 取消star失败
                    }
                    
                case .failure:
                    //TODO: 取消star失败
                    break
                }
                self.refreshStarButtonState()
            }
        }
    }
    
    func starRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let owner = repoModel?.repo_owner, let repoName = repoModel?.repo_name {
            Provider.sharedProvider.request(.starRepo(owner:owner, repo:repoName) ) { (result) -> Void in
//                print(result)
                switch result {
                case let .success(response):
                    
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        self.repoModel?.starred = true
                        self.delegate?.starReposStateChange(repoViewItem: self, starState: true)
                    } else {
                        //TODO: star失败
                    }
                    
                case .failure:
                    //TODO: star失败
                    break
                }
                self.refreshStarButtonState()
            }
        }
    }
    
    func refreshStarButtonState() {
        if let starred = repoModel?.starred {
            starButton.isHidden = false
            
            let dic = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyWhiteDarkBlack, backColor: nil, alignment: .center, lineBreak: nil, baselineOffset: NSNumber(value: 0), font: NSFont.bfSystemFont(ofSize: 16.0))
            let title = starred ?  "Unstar" : "Star"
            starButton.attributedTitle = NSAttributedString(string: title, attributes: dic)
        } else {
            starButton.isHidden = true
        }
    }
    
}
