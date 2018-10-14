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
        view.backgColor = NSColor.bfGrayDarkDark
        
        
        
        navigationSepLine.backgColor = NSColor.bfBlueDarkWhite
        detailSepLine.backgColor = NSColor.bfBlueDarkWhite
        //        navAndDetailSepLine.backgColor = NSColor.thDayBlue
        
        navigationContainView.backgColor = NSColor.bfGrayDarkDark
        navigationScrollView.backgColor = NSColor.bfGrayDarkDark
        navigationCollectionView.backgColor = NSColor.bfGrayDarkDark
        
        detailContailView.backgColor = NSColor.bfGrayDarkDark
        detailScrollView.backgColor = NSColor.bfGrayDarkDark
        detailCollectionView.backgColor = NSColor.bfGrayDarkDark
    }
    
    func setupSelectedTimeAndLanguagePopup() {
        languagePopup.target = self
        languagePopup.action = #selector(handleSelectedLanguage(popBtn:))
        
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
//            let time = BFGihubTrendingTimeEnum(rawValue: selTitle)
            reloadTimaAndLanguage()
        }
    }
    
    /// 选中语言
    @objc func handleSelectedLanguage(popBtn: NSPopUpButton) {
        if let selTitle = popBtn.selectedItem?.title {
            print(selTitle)
            let index = popBtn.indexOfItem(withTitle: selTitle)
            if popularLanguage != nil {
                if index < popularLanguage!.count && index >= 0 {
                    var getRepoLanguageVar = popularLanguage![index]
                    if let count = getRepoLanguageVar["count"] {
                        if let newCount = count.int  {
                            let addcount = newCount + 1
                            getRepoLanguageVar["count"] = "\(addcount)"
                        }
                    }
                    popularLanguage![index] = getRepoLanguageVar
                    //1. 存储
                    BFLanguageManager.shared.saveLangugePlistFile(languages: popularLanguage)
                    //2. 重新请求
                    reloadTimaAndLanguage()
                }
            }
        }
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
        languagePopup.removeAllItems()
        languagePopup.addItems(withTitles: langueseArr)
    }
}
