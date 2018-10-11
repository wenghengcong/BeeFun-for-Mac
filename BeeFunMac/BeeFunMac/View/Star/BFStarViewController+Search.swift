//
//  BFStarViewController+Search.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/23.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

extension BFStarViewController: NSSearchFieldDelegate {
    
    //开始搜索
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        print("begin search \(searchField.stringValue)")
    }
    
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        print("end search \(searchField.stringValue)")
    }
    
    @objc func searchCancelButtonClick() {
        print("cancel search")
        resetAfterCancelSearchButton()
    }
    
    /// 搜索
    ///
    /// - Parameters:
    ///   - forceSearchKey: 强制搜索 搜索关键字s
    ///   - allRefresh: 是否刷新全部列表数据
    ///   - scrollToTop: 是否滑动到顶部
    func searchStarReposNow(forceSearchKey: Bool, allRefresh: Bool, scrollToTop:Bool) {
        
        if !searchField.stringValue.isEmpty && forceSearchKey {
            searchKey = searchField.stringValue
        } else {
            searchKey = nil
        }
        
        resignAllTextFieldFirstResponder()
        
        if ordertType == .time {
            getRepoSortPara = "starred_at"
            getRepoDirectionPara = "desc"
        } else if ordertType == .star {
            getRepoSortPara = "stargazers_count"
            getRepoDirectionPara = "desc"
        } else if ordertType == .a_z {
            getRepoSortPara = "name"
            getRepoDirectionPara = "asc"
        }
        
        // 1.经过语言筛选及排序
        if filterTags.count > 0 {
            if let tagName = filterTags[0].name {
                getRepoTagPara = tagName
            }
        } else {
            //点击all或untagged，都要将tag置为all
            if clickAllStar || clickUntaggedStar {
                getRepoTagPara = "all"
            }
        }
        getFirstPageStarRepos(allRefresh: allRefresh, scrollToTop: scrollToTop)
    }
    
    func hanldeStaredRepoResponse(repos: [ObjRepos], allRefresh: Bool, scrollToTop:Bool) {
        //在能获取到所有star repo数据后，重新拉取language接口
        if languageArr.count == 1 || languageAndNum.count == 1 {
            getLanguageDataNetwork()
        }
        
        var reponseData: [ObjRepos] = repos
        //1. 选中无tag标记
        var filterByUntagged: [ObjRepos] = []
        if clickUntaggedStar {
            for repo in reponseData {
                //未标记
                if let startags = repo.star_tags {
                    if startags.isEmpty {
                        filterByUntagged.append(repo)
                    }
                } else {
                    filterByUntagged.append(repo)
                }
            }
            reponseData = filterByUntagged
        } else if clickAllStar {
            //选中全部，则不对reponseData操作
        }

        //2. 刷新
        let refreshBeforeCount = starReposData.count
        if getReposPage == 1 {
            starReposData = reponseData
        } else {
            starReposData += reponseData
        }
        let refreshAfterCount = starReposData.count

        //刷新前后count不一样
        if refreshAfterCount == refreshBeforeCount {
            reloadRepoTableViewData()
        } else if(refreshAfterCount < refreshBeforeCount) {
            reloadRepoTableViewData()
        } else {
            if allRefresh {
                reloadRepoTableViewData()
            } else {
                if getReposPage == 1 {
                    reloadRepoTableViewData()
                } else {
                    let rangeIndex = refreshBeforeCount ..< refreshAfterCount
                    let insertIndexSet = IndexSet(integersIn: rangeIndex)
                    print("insertIndexSet: \(insertIndexSet)")
//                    starTable.beginUpdates()
                    starTable.insertRows(at: insertIndexSet, withAnimation: NSTableView.AnimationOptions.effectGap)
                    starTable.reloadData(forRowIndexes: insertIndexSet, columnIndexes: IndexSet(integer: 0))
//                    starTable.endUpdates()
                }
            }
        }
        //当前刷新是数据为空，就不
        if starReposData.count == 0 {
            selectedRepoRow = 0
            repoTableViewDidSelectRow(0)
        } else {
            if scrollToTop {
                starTable.scroll(NSPoint.zero)
                repoTableViewDidSelectRow(0)
            }
        }
    }
}
