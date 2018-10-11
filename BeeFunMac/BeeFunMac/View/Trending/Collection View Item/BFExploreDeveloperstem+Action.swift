//
//  BFExploreDeveloperstem+Action.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFExploreDevelopersViewItem {

    func addAction() {
                
        avatarImageView.target = self
        avatarImageView.action = #selector(clickAvatarImage)
        
        loginButton.target = self
        loginButton.action = #selector(clickAvatarImage)
        
        repoImageView.addSingleLeftClickGesture(action:  #selector(clickRepo))
        repoButton.target = self
        repoButton.action = #selector(clickRepo)
        
        followedButton.target = self
        followedButton.action = #selector(clickFollowButton)
    }
    
    @objc func clickAvatarImage() {
        BFBrowserManager.shared.gotoPage(url: userModel?.user_url)
    }
    
    @objc func clickRepo() {
        BFBrowserManager.shared.gotoPage(url: userModel?.repo_url)
    }
    
    @objc func clickFollowButton() {
        if followedButton.state == .on {
            followRequest()
        } else if followedButton.state == .off {
            unFollowRequest()
        }
    }
    
}

extension BFExploreDevelopersViewItem {
    //检查star状态
    func checkFollowed() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let login = userModel?.login {
            Provider.sharedProvider.request(.checkUserFollowing(username: login)) { (result) -> Void in
                switch result {
                case let .success(response):
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        //用户已关注，显示unfollow
                        self.followedButton.isHidden = false
                        self.followedButton.state = .on
                    } else if statusCode == BFStatusCode.notFound.rawValue {
                        //用户未关注，显示follow
                        self.followedButton.isHidden = false
                        self.followedButton.state = .off
                    }
                case .failure:
                    self.followedButton.isHidden = true
                    break
                }
            }
        }
    }
    
    func followRequest() {
        if let username = userModel?.login {
            Provider.sharedProvider.request(.follow(username:username) ) { (result) -> Void in
                switch result {
                case let .success(response):
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        //关注成功，显示未关注
                        self.followedButton.isHidden = false
                        self.followedButton.state = .on
                    }
                case .failure:
                   break
                }
            }
        }
    }
    
    func unFollowRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        if let username = userModel?.login {

            Provider.sharedProvider.request(.unfollow(username:username) ) { (result) -> Void in
                switch result {
                case let .success(response):
                    
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        self.followedButton.isHidden = false
                        self.followedButton.state = .off
                    }
                case .failure:
                    break
                }
            }
        }
        
    }
}
