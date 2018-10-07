//
//  BFExploreDevelopersViewItem.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExploreDevelopersViewItem: NSCollectionViewItem {

    @IBOutlet weak var posButton: NSButton!
    @IBOutlet weak var avatarImageView: NSButton!
    
    @IBOutlet weak var loginButton: NSButton!
    
    @IBOutlet weak var repoImageView: NSImageView!
    @IBOutlet weak var repoButton: NSButton!
    
    
    private let viewOriBorderWidth: CGFloat = 1.0
    private let viewSelBorderWidth: CGFloat = 5.0
    
    var userModel: BFGithubTrengingModel? {
        didSet {
            fillDataToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        posButton.backgColor = NSColor.thDayBlue
        
        avatarImageView.imagePosition = .imageOnly
        avatarImageView.isBordered = false
        avatarImageView.radius = 5.0
        
        posButton.radius = posButton.width/2.0
        
        view.borderColor = NSColor.thDayBlue
        view.borderWidth = viewOriBorderWidth
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
    private func fillDataToUI() {
        
        if let avatar = userModel?.user_avatar, let userAvatarUrl = URL(string: avatar) {
            avatarImageView.kf.setImage(with: userAvatarUrl)
            
        }
        
        if let pos = userModel?.pos {
            let posAtt = AttributedDictionary.attributeDictionary(foreColor: NSColor.thDayWhite, backColor: NSColor.thDayBlue, alignment: .center)
            posButton.attributedTitle = NSAttributedString(string: "\(pos)", attributes: posAtt)
        }
        
        if let login = userModel?.login {
            let loginAtt = AttributedDictionary.attributeDictionary(foreColor: NSColor.thDayBlue, alignment: NSTextAlignment.center)
            loginButton.attributedTitle = NSAttributedString(string: login, attributes: loginAtt)
        }
        

        if let repoName = userModel?.repo_name {
            let repoAtt = AttributedDictionary.attributeDictionary(foreColor: BFThemeManager.shared.explre_detail_subTitle_color(), alignment: NSTextAlignment.left)

            repoButton.attributedTitle = NSAttributedString(string: repoName, attributes: repoAtt)
        }
        
        
        
    }
    
}