//
//  MenuTrendDevItem.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuTrendDevItem: NSCollectionViewItem {

    // 总的背景视图
    @IBOutlet weak var containBackView: NSView!
    
    // 用户信息
    @IBOutlet weak var avatarImageView: NSButton!
    @IBOutlet weak var userNameLabel: NSButton!
    // 关注按钮
    @IBOutlet weak var followButton: NSButton!
    // 排名
    @IBOutlet weak var posButton: NSButton!
    // repo信息
    @IBOutlet weak var repoImageView: NSImageView!
    @IBOutlet weak var repoLabel: NSButton!

    @IBOutlet weak var bottomLine: NSBox!
    private let viewOriBorderWidth: CGFloat = 1.0
    private let viewSelBorderWidth: CGFloat = 5.0
    
    var userModel: BFGithubTrengingModel? {
        didSet {
            menu_tringding_dev_item_fillDataToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        avatarImageView.imagePosition = .imageOnly
        avatarImageView.isBordered = false
        avatarImageView.radius = 5.0
        posButton.radius = 5.0
        bottomLine.backgColor = NSColor.xyLightGrayDarkWhite
//        view.radius = 5.0
        menu_tringding_dev_item_addAction()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        view.backgColor = NSColor.xyWhiteDarkBlack
        posButton.backgColor = NSColor.thDayBlue
        view.viewBorderColor = NSColor.xyClearDarkWhite
        view.viewBorderWidth = viewOriBorderWidth
        
        if let pos = userModel?.pos {
            let posAtt = AttributedDictionary.attributeDictionary(foreColor: NSColor.thDayWhite, backColor: NSColor.clear, alignment: .center, lineBreak: NSLineBreakMode.byTruncatingTail, baselineOffset: NSNumber(value: 0), font: NSFont.bfSystemFont(ofSize: 11.0))
            posButton.attributedTitle = NSAttributedString(string: "\(pos)", attributes: posAtt)
        }
        
        if let repoName = userModel?.repo_name {
            
            let repoAtt = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyGrayDarkWhite, backColor: NSColor.xyClearDarkBlack, alignment: .left, lineBreak: NSLineBreakMode.byTruncatingTail, baselineOffset: nil, font: NSFont.bfSystemFont(ofSize: 12.0))
            repoLabel.attributedTitle = NSAttributedString(string: repoName, attributes: repoAtt)
        }
    }
    /*
     
     "today": "2018-10-04",
     "time_period": "daily",
     "language": "objective-c",
     "full_name": "Microsoft (Microsoft)",
     "type": 2,
     "pos": 1,
     "user_url": "https://github.com/Microsoft",
     "login": "Microsoft",
     "user_id": null,
     "repo_name": "react-native-code-push",
     "repo_url": "https://github.com/Microsoft/react-native-code-push",
     "user_avatar": "https://avatars2.githubusercontent.com/u/6154722?s=96&v=4",
     "repo_desc": "React Native module for CodePush",
     */
    private func menu_tringding_dev_item_fillDataToUI() {
        
        //检查是否关注该用户
//        menu_tringding_dev_item_checkFollowed()
        
        if let avatar = userModel?.user_avatar, let userAvatarUrl = URL(string: avatar) {
            avatarImageView.kf.setImage(with: userAvatarUrl)
            
        }
        
        if let login = userModel?.login {
            let loginAtt = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyBlackDarkWhite, backColor: NSColor.xyWhiteDarkBlack, alignment: .left, lineBreak: NSLineBreakMode.byTruncatingTail, baselineOffset: nil, font: NSFont.bfSystemFont(ofSize: 14.0))
            userNameLabel.attributedTitle = NSAttributedString(string: login, attributes: loginAtt)
        }
    }
    
    func menu_tringding_dev_item_addAction() {
        
        avatarImageView.target = self
        avatarImageView.action = #selector(menu_tringding_dev_item_clickAvatarImage)
        
        userNameLabel.target = self
        userNameLabel.action = #selector(menu_tringding_dev_item_clickAvatarImage)
        
        repoImageView.addSingleLeftClickGesture(action:  #selector(menu_tringding_dev_item_clickRepo))
        repoImageView.target = self
        repoImageView.action = #selector(menu_tringding_dev_item_clickRepo)
        
        repoLabel.target = self
        repoLabel.action = #selector(menu_tringding_dev_item_clickRepo)
        
        followButton.target = self
        followButton.action = #selector(menu_tringding_dev_item_clickFollowButton)
    }
    
    @objc func menu_tringding_dev_item_clickAvatarImage() {
        BFBrowserManager.shared.openUrl(url: userModel?.user_url)
    }
    
    @objc func menu_tringding_dev_item_clickRepo() {
        BFBrowserManager.shared.openUrl(url: userModel?.repo_url)
    }
    
    @objc func menu_tringding_dev_item_clickFollowButton() {
        if followButton.state == .on {
            menu_tringding_dev_item_followRequest()
        } else if followButton.state == .off {
            menu_tringding_dev_item_unFollowRequest()
        }
    }

    //检查star状态
    func menu_tringding_dev_item_checkFollowed() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let login = userModel?.login {
            Provider.sharedProvider.request(.checkUserFollowing(username: login)) { (result) -> Void in
                switch result {
                case let .success(response):
                    let mess = String(data: response.data, encoding: .utf8)!
                    let statusCode = response.statusCode
                    print("statusCode: \(statusCode), followed: \(mess)")
                    if statusCode == BFStatusCode.noContent.rawValue {
                        //用户已关注，显示unfollow
                        self.userModel?.followed = true
                    } else if statusCode == BFStatusCode.notFound.rawValue {
                        //用户未关注，显示follow
                        self.userModel?.followed = false
                    }
                case .failure:
                    break
                }
                self.menu_tringding_dev_item_refreshFollowButton()
            }
        }
    }
    
    func menu_tringding_dev_item_refreshFollowButton() {
        if let followed = userModel?.followed {
            followButton.isHidden = false
            
            let dic = AttributedDictionary.attributeDictionary(foreColor: NSColor.black, backColor: nil, alignment: .center, lineBreak: nil, baselineOffset: NSNumber(value: 0), font: NSFont.bfSystemFont(ofSize: 13.0))
            let title = followed ?  "Unfollow" : "Follow"
            followButton.attributedTitle = NSAttributedString(string: title, attributes: dic)
        } else {
            followButton.isHidden = true
        }
    }
    
    func menu_tringding_dev_item_followRequest() {
        if let username = userModel?.login {
            Provider.sharedProvider.request(.follow(username:username) ) { (result) -> Void in
                switch result {
                case let .success(response):
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        //关注成功，显示未关注
                        self.userModel?.followed = true
                    }
                case .failure:
                    break
                }
                self.menu_tringding_dev_item_refreshFollowButton()
            }
        }
    }
    
    func menu_tringding_dev_item_unFollowRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        if let username = userModel?.login {
            
            Provider.sharedProvider.request(.unfollow(username:username) ) { (result) -> Void in
                switch result {
                case let .success(response):
                    
                    let statusCode = response.statusCode
                    if statusCode == BFStatusCode.noContent.rawValue {
                        self.userModel?.followed = false
                    }
                case .failure:
                    break
                }
                self.menu_tringding_dev_item_refreshFollowButton()
            }
        }
        
    }
}
