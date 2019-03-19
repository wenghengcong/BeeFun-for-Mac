//
//  MenuTrendRepoItem.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuTrendRepoItem: NSCollectionViewItem {

    @IBOutlet weak var upBackView: NSView!
    
    @IBOutlet weak var starBackView: NSView!
    @IBOutlet weak var repoUpLabel: NSTextField!
    @IBOutlet weak var repoNameButton: NSButton!
    @IBOutlet weak var repoDescLabel: NSTextField!
    @IBOutlet weak var repoColorLabel: BFButton!
    @IBOutlet weak var starButton: NSButton!
    @IBOutlet weak var upImageView: NSImageView!
    
    @IBOutlet weak var bottomLine: NSBox!
    @IBOutlet weak var repoStarLabel: NSTextField!
    
    
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
        menu_trend_repo_item_setupExploreViewItem()
        menu_trend_repo_item_addAction()
    }
    
    func menu_trend_repo_item_addAction() {
        
        repoNameButton.target = self
        repoNameButton.action = #selector(menu_trend_repo_item_clickRepoName)
        
        repoDescLabel.addSingleLeftClickGesture(action:  #selector(menu_trend_repo_item_clickRepoName))
        repoDescLabel.target = self
        repoDescLabel.action = #selector(menu_trend_repo_item_clickRepoName)
        
        starButton.target = self
        starButton.action = #selector(menu_trend_repo_item_clickStarRequest)
    }
    
    @objc func menu_trend_repo_item_clickRepoName() {
        BFBrowserManager.shared.openUrl(url: repoModel?.repo_url)
    }
    
    @objc func menu_trend_repo_item_clickStarRequest() {
        if starButton.title == "Star" {
            menu_trend_repo_item_starRequest()
        } else if starButton.title == "Unstar" {
            menu_trend_repo_item_unstarRequest()
        }
    }
    
    func menu_trend_repo_item_setupExploreViewItem() {
        
        // 默认不显示
        starButton.isHidden = true
        //修改按钮颜色、按钮背景色，要注意isBordered 为false
        starButton.isBordered = false
        //        starButton.borderWidth = 1.0
        //        starButton.borderColor = .red
        starButton.radius = 3.0
        repoStarLabel.isBezeled = false
        repoUpLabel.isBezeled = false
        bottomLine.backgColor = NSColor.lineGrayColor
        
        repoColorLabel.isBordered = false
        repoColorLabel.size = CGSize(width: 8.0, height: 8.0)
        repoColorLabel.radius = repoColorLabel.size.width/2.0
        repoColorLabel.stringValue = ""
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        starButton.backgColor = NSColor.xyBlueDarkWhite

        view.backgColor = NSColor.xyWhiteDarkBlack
        starBackView.backgColor = NSColor.xyWhiteDarkBlack
        upBackView.backgColor = NSColor.xyWhiteDarkBlack
        
        repoUpLabel.backgColor = NSColor.xyClearDarkWhite
        repoStarLabel.backgColor = NSColor.xyClearDarkWhite
        
        repoDescLabel.textColor = NSColor.xyGrayDarkWhite
        
        view.viewBorderColor = NSColor.xyClearDarkWhite
        if NSApplication.shared.isDarkMode {
            view.viewBorderWidth = viewOriBorderWidth
        } else {
            view.viewBorderWidth = 0
        }
        
        let diction = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyBlackDarkWhite, backColor: nil, alignment: nil, lineBreak: nil, baselineOffset: nil, font: NSFont.systemFont(ofSize: 13.0))
        if let name = repoModel?.repo_name {
            repoNameButton.attributedTitle = NSAttributedString(string: name, attributes: diction)
        }
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
            repoUpLabel.stringValue = NumberConvert.readableNumber(upNum)!
        } else {
            upImageView.isHidden = true
            repoUpLabel.stringValue = "0"
        }
        
        if let star = repoModel?.star_num {
            repoStarLabel.stringValue = NumberConvert.readableNumber(star)!
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
            let dic = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyWhiteDarkBlack, backColor: nil, alignment: .center, lineBreak: nil, baselineOffset: NSNumber(value: 0), font: NSFont.bfSystemFont(ofSize: 11.0))
            let title = starred ?  "Unstar" : "Star"
            starButton.attributedTitle = NSAttributedString(string: title, attributes: dic)
        } else {
            starButton.isHidden = true
        }
    }
    
}
