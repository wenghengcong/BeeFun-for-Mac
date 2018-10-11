//
//  BFExploreController+Data.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

extension BFExploreController {
    
    func setupData() {
        
        requesRepostModel = BFGithubTrendingRequsetModel()
        requesDeveloperModel = BFGithubTrendingRequsetModel()

        setRequestModel(time: .daily, language: "all")
        setupNavigationData()
    }
    
    
    func setupNavigationData() {
        
        navigationdTitles = ["Github"]
        
        let github_trending_repo = [
            "navType": "1",
            "logo":"exp_nav_github_trend",
            "title": "Trending Repositories",
            "desc": "See what the GitHub community is most excited about today."
        ]
        
        let github_trending_developers = [
            "navType": "2",
            "logo":"exp_nav_github_trend",
            "title": "Trending Developers",
            "desc": "These are the organizations and developers building the hot tools today."
        ]
        if let trend_repo = BFExploreNavigationModel(JSON: github_trending_repo),
            let trend_deve = BFExploreNavigationModel(JSON: github_trending_developers) {
            navigationdData = [
                navigationdTitles[0]: [trend_repo, trend_deve]
            ]
        }
        
//        navigationCollectionView.reloadData()
        
        // select first item of collection view
        collectionView(navigationCollectionView, didSelectItemsAt: [IndexPath(item: 0, section: 0)])
        navigationCollectionView.selectionIndexPaths.insert(IndexPath(item: 0, section: 0))
        // the below code also do select first item
//        navigationCollectionView.selectItems(at: [IndexPath(item: 0, section: 0)], scrollPosition: .top)

    }
    
    func setRequestModel(time: BFGihubTrendingTimeEnum, language: String) {
        var source = 2
        if language.lowercased() == "all" {
            source = 1
        }
        requesRepostModel?.type = 1
        requesRepostModel?.source = source
        requesRepostModel?.time = time
        requesRepostModel?.language = language
        requesRepostModel?.page = 1
        requesRepostModel?.perpage = 100
        requesRepostModel?.sort = "up_star_num"
        requesRepostModel?.direction = "desc"
        
        requesDeveloperModel?.type = 2
        requesDeveloperModel?.source = source
        requesDeveloperModel?.time = time
        requesDeveloperModel?.language = language
        requesDeveloperModel?.page = 1
        requesDeveloperModel?.perpage = 100
        requesDeveloperModel?.sort = "pos"
        requesDeveloperModel?.direction = "asc"
    }
    
    /// 重新加载数据
    func reloadTimaAndLanguage() {
        if let timeTitle = timePopup.selectedItem?.title, let lanTitle = languagePopup.selectedItem?.title {
            let time: BFGihubTrendingTimeEnum = BFGihubTrendingTimeEnum(rawValue: timeTitle) ?? .daily
            let language = lanTitle.lowercased().replacing(" ", with: "-")
            setRequestModel(time: time, language: language)
            
            if navigationType == .githubTrendingDevelopers {
                getGithubTrendingDeveloper(refresh: true)
            } else if navigationType == .githubTrendingRepos {
                getGithubTrendingReopsitories(refresh: true)
            }
        }
    }
    
    func getGithubTrendingDeveloper(refresh: Bool) {
        
        if !refresh && githubTrendingDevelopserData.count > 0  {
            detailCollectionView.reloadData()
            return
        }
        
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesDeveloperModel!)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<BFGithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
//                                if self.githubTrendingDevelopserData.count > 0 {
//                                    self.githubTrendingDevelopserData[0] = data
//                                } else {
                                    self.githubTrendingDevelopserData.removeAll()
                                    self.githubTrendingDevelopserData.append(data)
//                                }
                                self.detailCollectionView.reloadData()
                                self.detailCollectionView.scroll(NSPoint.zero)
                            }
                        }
                    }
                } catch {
                }
                break
            case .failure:
                break
            }
        }
    }
    
    func getGithubTrendingReopsitories(refresh: Bool) {

        if !refresh && githubTrendingDevelopserData.count > 0  {
            detailCollectionView.reloadData()
            return
        }
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesRepostModel!)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<BFGithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
//                                if self.githubTrendingReposData.count > 0 {
//                                    self.githubTrendingReposData[0] = data
//                                } else {
                                    self.githubTrendingReposData.removeAll()
                                    self.githubTrendingReposData.append(data)
//                                }
                                self.detailCollectionView.reloadData()
                                self.detailCollectionView.scroll(NSPoint.zero)
                            }
                        }
                    }
                } catch {
                }
                break
            case .failure:
                break
            }
        }
        
    }
    
 
}
