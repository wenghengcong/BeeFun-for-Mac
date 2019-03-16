//
//  MenuTrendRepoItem.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuTrendRepoItem: NSCollectionViewItem {

    @IBOutlet weak var repoUpLabel: NSTextField!
    @IBOutlet weak var repoNameButton: NSButton!
    @IBOutlet weak var repoDescLabel: NSTextField!
    @IBOutlet weak var repoColorLabel: BFButton!
    @IBOutlet weak var starButton: NSButton!
    @IBOutlet weak var upImageView: NSImageView!
    
    let viewOriBorderWidth: CGFloat = 1.0
    let viewSelBorderWidth: CGFloat = 5.0
    
    weak var delegate: BFExploreReposViewItemDelete?
    
    var repoModel: BFGithubTrengingModel? {
        didSet {
            menu_trend_repo_item_fillDataToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func menu_trend_repo_item_setupExploreViewItem() {
        
        // 默认不显示
        starButton.isHidden = true
        //修改按钮颜色、按钮背景色，要注意isBordered 为false
        starButton.isBordered = false
        //        starButton.borderWidth = 1.0
        //        starButton.borderColor = .red
        starButton.radius = 3.0
        
        view.radius = 5.0
        
        repoColorLabel.isBordered = false
        repoColorLabel.size = CGSize(width: 8.0, height: 8.0)
        repoColorLabel.radius = repoColorLabel.size.width/2.0
        repoColorLabel.stringValue = ""
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        starButton.backgColor = NSColor.xyBlueDarkWhite
        
        view.backgColor = NSColor.xyWhiteDarkBlack
        
        repoDescLabel.textColor = NSColor.xyBlackDarkWhite
        
        view.viewBorderColor = NSColor.xyClearDarkWhite
        if NSApplication.shared.isDarkMode {
            view.viewBorderWidth = viewOriBorderWidth
        } else {
            view.viewBorderWidth = 0
        }
        
        let diction = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyBlackDarkWhite, backColor: nil, alignment: nil, lineBreak: nil, baselineOffset: nil, font: NSFont.systemFont(ofSize: 17.0))
        if let name = repoModel?.repo_name {
            repoNameButton.attributedTitle = NSAttributedString(string: name, attributes: diction)
        }
        
        menu_trend_repo_item_starRequest()
    }
    
    
    func menu_trend_repo_item_fillDataToUI() {
        
        //检查star状态
        menu_trend_repo_item_checkStarted()
        
        if let color = repoModel?.repo_language_color {
            repoColorLabel.title = ""
            repoColorLabel.isHidden = false
            let lanColor = NSColor.hex(color)
            repoColorLabel.backgColor = lanColor
        } else {
            repoColorLabel.isHidden = true
        }
        
        if let desc = repoModel?.repo_desc {
            repoDescLabel.stringValue = desc
        } else {
            repoDescLabel.stringValue = ""
        }
        
        if let upNum = repoModel?.up_star_num {
            upImageView.isHidden = false
            repoUpLabel.stringValue = "\(upNum)"
        } else {
            upImageView.isHidden = true
            repoUpLabel.stringValue = "0"
        }
    }
    
}

extension MenuTrendRepoItem {
    
    func menu_trend_repo_item_checkStarted() {
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
                self.menu_trend_repo_item_refreshStarButtonState()
            }
        }
    }
    
    func menu_trend_repo_item_unstarRequest() {
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
//                        self.delegate?.starReposStateChange(repoViewItem: self, starState: true)
                    } else {
                        //TODO: 取消star失败
                    }
                    
                case .failure:
                    //TODO: 取消star失败
                    break
                }
                self.menu_trend_repo_item_refreshStarButtonState()
            }
        }
    }
    
    func menu_trend_repo_item_starRequest() {
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
//                        self.delegate?.starReposStateChange(repoViewItem: self, starState: true)
                    } else {
                        //TODO: star失败
                    }
                    
                case .failure:
                    //TODO: star失败
                    break
                }
                self.menu_trend_repo_item_refreshStarButtonState()
            }
        }
    }
    
    func menu_trend_repo_item_refreshStarButtonState() {
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
