//
//  BFHomeViewController+Data.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

extension BFHomeViewController {
    
    func setupData() {
        
        setRequestModel()
        
        getGithubTrendingDeveloper()
        getGithubTrendingReopsitories()
    }
    
    func setRequestModel() {
        
        requesRepostModel = RequsetGithubTrendingModel()
        requesRepostModel?.type = 1
        requesRepostModel?.source = 1
        requesRepostModel?.time = GIhubTrendingTimeEnum.daily
        requesRepostModel?.page = 1
        requesRepostModel?.perpage = 100
        requesRepostModel?.sort = "up_star_num"
        requesRepostModel?.direction = "desc"
        
        requesDeveloperModel = RequsetGithubTrendingModel()
        requesDeveloperModel?.type = 1
        requesDeveloperModel?.source = 1
        requesDeveloperModel?.time = GIhubTrendingTimeEnum.daily
        requesDeveloperModel?.page = 1
        requesDeveloperModel?.perpage = 100
        requesDeveloperModel?.sort = "pos"
        requesDeveloperModel?.direction = "desc"
    }
    
    func getGithubTrendingDeveloper() {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesDeveloperModel!)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<GithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
                                self.githubTrendingDevelopser.insert(data, at: 0)
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
    
    func getGithubTrendingReopsitories() {

        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesRepostModel!)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<GithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
                                self.githubTrendingRepos.insert(data, at: 0)
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
