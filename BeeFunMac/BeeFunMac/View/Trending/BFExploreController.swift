//
//  BFExploreController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/1.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

enum NavigationProductType: String {
    case githubTrendingRepos = "1"
    case githubTrendingDevelopers = "2"
    case prodhuctHunt = "3"
}

class BFExploreController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource, BFExpolreNavigationViewItemDelete {

    @IBOutlet weak var searchTextField: NSTextField!
    @IBOutlet weak var searchButton: NSButton!
    
    @IBOutlet weak var navigationContainView: BFView!
    @IBOutlet weak var navigationScrollView: NSScrollView!
    @IBOutlet weak var navigationCollectionView: NSCollectionView!
    
    
    @IBOutlet weak var detailContailView: NSView!
    @IBOutlet weak var detailScrollView: NSScrollView!
    @IBOutlet weak var detailCollectionView: NSCollectionView!
    @IBOutlet weak var detailLayout: NSCollectionViewFlowLayout!
    
    @IBOutlet weak var navigationSepLine: NSBox!
    @IBOutlet weak var detailSepLine: NSBox!
    
    var navigationType: NavigationProductType = .githubTrendingRepos
    var requesRepostModel: BFGithubTrendingRequsetModel?
    var requesDeveloperModel: BFGithubTrendingRequsetModel?
    
    //Navigation data
    var navigationdTitles: [String] = []
    var navigationdData: [String: [BFExploreNavigationModel]] = [:]
    
    //Detail data: 均是二维数组
    var githubTrendingReposData: [[BFGithubTrengingModel]] = []
    var githubTrendingDevelopserData: [[BFGithubTrengingModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupData()
        setupView()
    }
    
    
}
