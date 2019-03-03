//
//  BFExploreController+View.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFExploreController {

    
    func setupView() {
        setupCollectionView()
        setupSelectedTimeAndLanguagePopup()
    }
    
    
    override func viewDidLayout() {
        
        super.viewDidLayout()
        view.backgColor = NSColor.xyGrayDarkBlack
        
        navigationTitleLabel.textColor = NSColor.xyBlackDarkWhite
        navigationSepLine.backgColor = NSColor.xyBlueDarkWhite
        
        detailTitleLabel.textColor = NSColor.xyBlackDarkWhite
        detailSepLine.backgColor = NSColor.xyBlueDarkWhite
        //        navAndDetailSepLine.backgColor = NSColor.thDayBlue
        
        navigationContainView.backgColor = NSColor.xyGrayDarkBlackBackground
        navigationScrollView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        navigationCollectionView.backgColor = NSColor.xyGrayDarkBlackBackground
        navigationClipView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        detailContailView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailScrollView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailCollectionView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailClipView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        setupLangSegmentcontrol()
    }
    
    func setupLangSegmentcontrol() {
        
        let arr = ["swift", "c", "c++", "java"]
        langSegment.segmentCount = arr.count
        langSegment.selectedSegment = 0
        for (index, lan) in arr.enumerated() {
            langSegment.setLabel(lan, forSegment: index)
        }
    }
    
    func setupSelectedTimeAndLanguagePopup() {
        languageSelectedButton.target = self
        languageSelectedButton.action = #selector(handleSelectedLanguage(button:))
    
        timePopup.target = self
        timePopup.action = #selector(handleSelectedTime(popBtn:))
        firstLoadLanguage()
    }
    
    func firstLoadLanguage() {
        //语言数据加载
        popularLanguage = BFLanguageManager.shared.popLanguages()
        refreshLanguagePop()
    }
    
    @objc func handleSelectedTime(popBtn: NSPopUpButton) {

        if let _ = popBtn.selectedItem?.title {
//            let time = BFGihubTrendingTimeEnum( selTitle)
            reloadTimaAndLanguage()
        }
    }
    
    /// 选中语言
    @objc func handleSelectedLanguage(button: NSButton) {
        LangPanel.shared.panelController.showWindow(button)
        
//        self.view.sheet
//        //1. 存储
//        BFLanguageManager.shared.saveLangugePlistFile(languages: popularLanguage)
//        //2. 重新请求
//        reloadTimaAndLanguage()
    }
    
    /// 重新加载语言列表
    func refreshLanguagePop() {
        popularLanguage?.sort(by: { (first, second) -> Bool in
            if let first = first["count"]?.int , let sec = second["count"]?.int   {
                return first > sec
            }
            return false
        })
        
        var langueseArr: [String] = []
        popularLanguage?.forEachEnumerated({ (index, dic) in
            if let lan = dic["lan"] {
                print("add lan to pop \(lan)")
                langueseArr.append(lan)
            }
        })
    }
}
