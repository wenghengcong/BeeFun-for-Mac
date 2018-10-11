//
//  BFStarViewController+Data.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/7.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

extension BFStarViewController {
    
    
    func firstLoadStarPage() {
        
        getRepoLanguageVar = "All"
        languagePop.selectItem(at: 0)
        
        searchKey = nil
        searchField.stringValue = ""
        
        ordertType = .time
        orderFilterView.selectOrder(type: ordertType)
        
        self.selectedRepoRow = 0
        webViewReadMeAction(sender: nil)
        clickAllStarButton()
    }
    
    func reloadRepoTableViewData() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
//        starTable.animations = nil
        starTable.reloadData()
        CATransaction.commit()
    }
    
    /// 取消搜索按钮
    func resetAfterCancelSearchButton() {
        searchField.stringValue = ""
        clickAllStarButton()
        searchStarReposNow(forceSearchKey: false, allRefresh: true, scrollToTop: true)
    }

    func starPageReloadAllData() {
        getLanguageDataNetwork()
        getFirstPageTags()
    }
    
    func handleGetLanguageList(data: [ObjLanguage]) {
        languageArr.removeAll()
        languageAndNum.removeAll()
        for lan in data {
            if let lanName = lan.language, let num = lan.num {
                let tips = lanName + "     [\(num)]"
                languageArr.append(lanName)
                languageAndNum.append(tips)
            }
        }
        reloadLanguage()
    }
    
    // MARK: - Tag
    func refreshWorkingTagsFromRepo(repo: ObjRepos?) {
        if let tags = repo?.star_tags {
            workingTags.removeAll()
            for tag in tags {
                let obj = ObjTag()
                obj.name = tag
                workingTags.append(obj)
            }
        } else {
            workingTags.removeAll()
        }
    }

}
