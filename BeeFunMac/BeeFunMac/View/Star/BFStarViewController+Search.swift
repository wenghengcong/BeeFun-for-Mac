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
    
    func searchStarReposNow(allRefresh: Bool, scrollToTop:Bool) {
        
        if searchField.stringValue.isEmpty {
            searchKey = nil
        } else {
            searchKey = searchField.stringValue
        }
        
        searchField.window?.resignFirstResponder()
        inputNewTagField.window?.resignFirstResponder()
        
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

        //2. 筛选search key
        var filterBySearchKey: [ObjRepos] = []
        searchKey = searchKey?.lowercased() //全部转换为小写来对比
        if let key = searchKey {
            for repo in reponseData {
                if let fullname = repo.full_name?.lowercased(), let desc = repo.cdescription,
                   let star_tags = repo.star_tags {
                    let star_tags_str = convertStarTagStringListToString(tags: star_tags)
                    if fullname.lowercased().contains(key) || desc.lowercased().contains(key) ||
                        star_tags_str.lowercased().contains(key) {
                        filterBySearchKey.append(repo)
                    }
                }
            }
            reponseData = filterBySearchKey
        } else {
            //无搜索关键字，则不对reponseData操作
        }
        
        //3. 刷新
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
        
        if scrollToTop {
            if scrollToTop {
                starTable.scroll(NSPoint.zero)
                if starReposData.count > 0 {
                    repoTableViewDidSelectRow(0)
                }
            }
            webViewHomeAction(sender: nil)
        }
        
    }
}
