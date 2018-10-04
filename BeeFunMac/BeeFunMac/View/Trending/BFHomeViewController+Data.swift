//
//  BFHomeViewController+Data.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFHomeViewController {
    
    func setupData() {
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
        
        getGithubTrendingDeveloper()
        getGithubTrendingReopsitories()
    }
    
    func getGithubTrendingDeveloper() {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesDeveloperModel!)) { (result) in
            switch result {
            case let .success(response):
//                do {
//                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
//                        if let code = tagResponse.codeEnum, code == BFStatusCode.bfOk {
//                            if update {
//                                //添加成功
//                                UserDefaults.standard.set(Date().timeStamp, forKey: self.lastTimeStampKey)
//                            }
//                        }
//                    }
//                } catch {
//                }
                break
            case .failure:
                break
            }
        }
    }
    
    func getGithubTrendingReopsitories() {

    }
    
}
