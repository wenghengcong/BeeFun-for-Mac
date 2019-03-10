//
//  BFExploreController+Noti.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

extension BFExploreController {
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(selectedLanguageDone(_:)), name: Notification.Name.BeeFun.SelectShowLanguage, object: nil)
    }
    
    @objc func selectedLanguageDone(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
//            print(userInfo)
            if let state: LangPanelState = userInfo["state"] as? LangPanelState {
                guard let language: BFLangModel = userInfo["language"] as? BFLangModel
                    else {return}
                if state == .SelectShowLanguage {
                    selectedLanguage = language.name ?? "all"
                    languageSelectedButton.title = selectedLanguage
                    reloadTimaAndLanguage()
                }
            }
        }
    }

}
