//
//  MenuTrendingController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class MenuTrendingController: NSViewController, NSCollectionViewDelegate, NSCollectionViewDataSource {
    @IBOutlet weak var topLineView: NSBox!
    
    @IBOutlet weak var trendingCollectionView: NSCollectionView!
    @IBOutlet weak var languageSegmentControl: NSSegmentedControl!
    @IBOutlet weak var typeSegmentControl: NSSegmentedControl!
    @IBOutlet weak var refreshButton: NSButton!
        
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    var requesRepostModel: BFGithubTrendingRequsetModel?
    var requesDeveloperModel: BFGithubTrendingRequsetModel?
    
    //Detail data: 均是二维数组
    var githubTrendingReposData: [[BFGithubTrengingModel]] = []
    var githubTrendingDevelopserData: [[BFGithubTrengingModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        menu_loadDefault()
        menu_trengding_setupView()
        menu_trengding_setupData()
        menu_trengding_setupAction()
    }

    
    /// 默认加载
    func menu_loadDefault() {
    
        if let langs = BFLangPanelUtil.shared.favouriteLanguages() {
            languageSegmentControl.segmentCount = langs.count
            languageSegmentControl.selectedSegment = 0
            for (index, lan) in langs.enumerated() {
                languageSegmentControl.setLabel(lan.name ?? "All", forSegment: index)
            }
        } else {
            languageSegmentControl.segmentCount = 1
            languageSegmentControl.selectedSegment = 0
            languageSegmentControl.setLabel("All", forSegment: 0)
        }
        
        if let language = UserDefaults.standard[.lastMenuTrendingLanguage], let lastIndex = Int(language) {
            languageSegmentControl.setSelected(true, forSegment: lastIndex)
        } else {
            languageSegmentControl.setSelected(true, forSegment: 0)
        }
        
        if let type = UserDefaults.standard[.lastMenuTrendingType], let lastIndex = Int(type) {
            typeSegmentControl.setSelected(true, forSegment: lastIndex)
        } else {
            typeSegmentControl.setSelected(true, forSegment: 0)
        }
    }
}

extension MenuTrendingController {
    /// 是否选中Repository type
    func isRepository() -> Bool {
        let typeSelIndex = typeSegmentControl.indexOfSelectedItem
        if typeSelIndex == 0 {
            return true
        }
        return false
    }
    
    /// 返回当前选中的语言
    func menu_trending_selectedLanguage() -> String {
        let sel = languageSegmentControl.selectedSegment
        let lang = languageSegmentControl.label(forSegment: sel)?.lowercased().replacing(" ", with: "-")
        if (lang != nil) && (!lang!.isEmpty) {
            return lang!
        }
        return "all"
    }
}
