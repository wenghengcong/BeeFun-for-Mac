//
//  BFExploreController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/1.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import Moya

enum BFExploreNavigationProductType: String {
    case githubTrendingRepos = "1"
    case githubTrendingDevelopers = "2"
    case prodhuctHunt = "3"
}

enum BFExploreTrendingTime: String {
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
}

class BFExploreController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, BFExpolreNavigationViewItemDelete, BFExploreReposViewItemDelete {

    var beefunDataUpdateCancable: Cancellable?

    @IBOutlet weak var searchTextField: NSTextField!
    @IBOutlet weak var searchButton: NSButton!
    
    @IBOutlet weak var navigationTitleLabel: NSTextField!
    @IBOutlet weak var navigationContainView: BFView!
    @IBOutlet weak var navigationScrollView: NSScrollView!
    @IBOutlet weak var navigationCollectionView: NSCollectionView!
    @IBOutlet weak var navigationClipView: NSClipView!
    
    
    
    @IBOutlet weak var detailContailView: NSView!
    @IBOutlet weak var detailScrollView: NSScrollView!
    @IBOutlet weak var detailCollectionView: NSCollectionView!
    @IBOutlet weak var detailLayout: NSCollectionViewFlowLayout!
    @IBOutlet weak var detailClipView: NSClipView!
    
    
    
    /// 分割线
    @IBOutlet weak var navigationSepLine: NSBox!
    @IBOutlet weak var detailSepLine: NSBox!
    @IBOutlet weak var navAndDetailSepLine: NSBox!
    
    @IBOutlet weak var detailTitleLabel: NSTextField!
    /// 复合选框
    @IBOutlet weak var timePopup: NSPopUpButton!
    @IBOutlet weak var languagePopup: NSPopUpButton!
    
    var navigationType: BFExploreNavigationProductType = .githubTrendingRepos
    var requesRepostModel: BFGithubTrendingRequsetModel?
    var requesDeveloperModel: BFGithubTrendingRequsetModel?
    
    //Navigation data
    var navigationdTitles: [String] = []
    var navigationdData: [String: [BFExploreNavigationModel]] = [:]
    
    //Detail data: 均是二维数组
    var githubTrendingReposData: [[BFGithubTrengingModel]] = []
    var githubTrendingDevelopserData: [[BFGithubTrengingModel]] = []
    
    /// 全部/流行 语言数据
    var allLanguage: [String]? = []
    var popularLanguage: [[String: String]]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupData()
        setupView()
    }
    
    @IBAction func changeAppearance(_ sender: Any) {
        if #available(OSX 10.14, *) {
            let button = sender as! NSButton
            button.state = (button.state  == .on) ? .off : .on
            if button.state == .on {
                NSApp.appearance = NSAppearance(named: .aqua)
            } else {
                NSApp.appearance = NSAppearance(named: .darkAqua)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
