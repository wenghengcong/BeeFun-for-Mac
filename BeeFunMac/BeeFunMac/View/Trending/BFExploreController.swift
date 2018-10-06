//
//  BFExploreController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/1.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

enum NavigationProductType {
    case githubTrendingRepos
    case githubTrendingDevelopers
    case prodhuctHunt
}

class BFExploreController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {

    @IBOutlet weak var searchTextField: NSTextField!
    @IBOutlet weak var searchButton: NSButton!
    
    @IBOutlet weak var navigationCollectionView: NSCollectionView!
    @IBOutlet weak var detailCollectionView: NSCollectionView!
    
    var navigationType: NavigationProductType = .githubTrendingRepos
    var requesRepostModel: RequsetGithubTrendingModel?
    var requesDeveloperModel: RequsetGithubTrendingModel?
    
    //Navigation data
    var navigationdTitles: [String] = []
    var navigationdData: [String: [BFExploreNavigationModel]] = [:]
    
    //Detail data: 均是二维数组
    var githubTrendingRepos: [[GithubTrengingModel]] = []
    var githubTrendingDevelopser: [[GithubTrengingModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupData()
        setupView()
    }
    
    
}
