//
//  MenuTrending+Action.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

extension MenuTrendingController {
    
    func menu_trengding_setupAction() {
        languageSegmentControl.target = self
        languageSegmentControl.action = #selector(handleLanguageChanged(sender:))
        
        typeSegmentControl.target = self
        typeSegmentControl.action = #selector(handleTypeChanged(sender:))
        
        refreshButton.target = self
        refreshButton.action = #selector(handleRefresh(sender:))
        refreshButton.backgColor = NSColor.clear
    }
    
    @objc func handleLanguageChanged(sender: Any) {
        UserDefaults.standard[.lastMenuTrendingLanguage] = "\(languageSegmentControl.selectedSegment)"
        menu_updateCurrentLanguage()
        menu_updateCurrentData()
    }
    
    @objc func handleTypeChanged(sender: Any) {
        UserDefaults.standard[.lastMenuTrendingType] = "\(typeSegmentControl.selectedSegment)"
        menu_updateCurrentData()
    }
    
    @objc func handleRefresh(sender: Any) {
        menu_updateCurrentData()
    }
    
    func menu_updateCurrentLanguage() {
        requesRepostModel?.language = menu_trending_selectedLanguage()
        requesDeveloperModel?.language = menu_trending_selectedLanguage()
    }
}
