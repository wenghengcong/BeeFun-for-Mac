//
//  BFExploreReposViewItem.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import Kingfisher

protocol BFExploreReposViewItemDelete: class {
    func clickRepostoriesBuiltUserHome(navigationItem: BFExploreReposViewItem, userHome: String)
}

class BFExploreReposViewItem: NSCollectionViewItem {

    @IBOutlet weak var repoNameLabel: NSButton!
    @IBOutlet weak var repoColorLabel: BFButton!
    
    @IBOutlet weak var repoLanguageLabel: NSButton!
    @IBOutlet weak var repoDescLabel: NSTextField!
    
    @IBOutlet weak var starButton: NSButton!
    
    @IBOutlet weak var builtUsersBox: NSView!
    
    @IBOutlet weak var upLabel: NSTextField!
    @IBOutlet weak var upImageView: NSImageView!
    @IBOutlet weak var starLabel: NSTextField!
    @IBOutlet weak var starImageView: NSImageView!
    @IBOutlet weak var forkLabel: NSTextField!
    @IBOutlet weak var forkImageView: NSImageView!
    
    let viewOriBorderWidth: CGFloat = 1.0
    let viewSelBorderWidth: CGFloat = 5.0
    
    var repoModel: BFGithubTrengingModel? {
        didSet {
            fillDataToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupExploreViewItem()
        addAction()
    }
    
    func setupExploreViewItem() {
        
        // 默认不显示
        starButton.isHidden = true
        //修改按钮颜色、按钮背景色，要注意isBordered 为false
        starButton.isBordered = false
//        starButton.borderWidth = 1.0
//        starButton.borderColor = NSColor.red
        starButton.radius = 3.0
        starButton.backgColor = NSColor.thDayBlue

        view.backgColor = NSColor.white
        view.borderColor = NSColor.white
        view.borderWidth = viewOriBorderWidth
        
        view.radius = 5.0
        
        repoColorLabel.isBordered = false
        repoColorLabel.size = CGSize(width: 8.0, height: 8.0)
        repoColorLabel.radius = repoColorLabel.size.width/2.0
        repoColorLabel.stringValue = ""
    }
    
    func fillDataToUI() {
        
        //检查star状态
        checkStarted()
        
        if let name = repoModel?.repo_name {
            repoNameLabel.title = name
        }
        
        if let color = repoModel?.repo_language_color {
            repoColorLabel.title = ""
            repoColorLabel.isHidden = false
            
            let lanColor = NSColor.hex(color)
            repoColorLabel.backgColor = lanColor
            
            //language label
            let dic = AttributedDictionary.attributeDictionary(foreColor: lanColor, alignment: .right, font: NSFont.bfSystemFont(ofSize: 10.0))
            if let language = repoModel?.repo_language {
                repoLanguageLabel.isHidden = false
                repoLanguageLabel.attributedTitle = NSAttributedString(string: language, attributes: dic)
                repoLanguageLabel.sizeToFit()
                let width = repoLanguageLabel.width
                repoLanguageLabel.snp.remakeConstraints { (make) in
                    make.top.equalTo(8)
                    make.trailing.equalTo(8.0)
                    make.width.equalTo(width)
                    make.height.equalTo(18.0)
                }
                
                repoColorLabel.snp.remakeConstraints { (make) in
                    make.centerY.equalTo(self.repoLanguageLabel.snp.centerY).offset(1)
                    make.trailing.equalTo(self.repoLanguageLabel.snp.leading).offset(-3.0)
                    make.width.equalTo(10.0)
                    make.height.equalTo(10.0)
                }
            } else {
                repoLanguageLabel.isHidden = true
                repoLanguageLabel.title = ""
            }
        } else {
            repoColorLabel.isHidden = true
            repoLanguageLabel.isHidden = true
        }
        
   
        
        if let desc = repoModel?.repo_desc {
            repoDescLabel.stringValue = desc
        } else {
            
        }
        
        if let upNum = repoModel?.up_star_num {
            upImageView.isHidden = false
            upLabel.stringValue = "\(upNum)"
        } else {
            upImageView.isHidden = true
            upLabel.stringValue = "0"
        }
        
        if let starNum = repoModel?.star_num {
            starImageView.isHidden = false
            starLabel.stringValue = "\(starNum)"
        } else {
            starImageView.isHidden = true
            starLabel.stringValue = "0"
        }
        
        if let forkNum = repoModel?.fork_num {
            forkImageView.isHidden = false
            forkLabel.stringValue = "\(forkNum)"
        } else {
            forkImageView.isHidden = true
            forkLabel.stringValue = "0"
        }
        
        let userXMargin: CGFloat = 3.0
        let userYMargin: CGFloat = 1.0
        let w: CGFloat = 17
        let boxW = builtUsersBox.size.width
        if let builtUsers = repoModel?.built_by_users {
            for (index, user) in builtUsers.enumerated() {
                if let userAvatar = user.avatar, let userAvatarUrl = URL(string: userAvatar) {
                    let userButton = NSButton()
                    userButton.kf.setImage(with: userAvatarUrl)
                    userButton.tag = index
                    userButton.target = self
                    userButton.action = #selector(clickBuiltByUser(sender:))
                    userButton.imagePosition = .imageOnly
                    userButton.isBordered = false
                    var x = CGFloat(index) * (w + userXMargin)
                    var y: CGFloat = 0
                    if x > boxW {
                        x = userXMargin
                        y = y + userYMargin + w
                    }
                    userButton.frame = CGRect(x: x, y: y, width: w, height: w)
                    builtUsersBox.addSubview(userButton)
                }
            }
        }
    }
    
}
