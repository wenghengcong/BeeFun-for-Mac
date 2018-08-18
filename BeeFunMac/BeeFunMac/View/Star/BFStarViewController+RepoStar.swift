//
//  BFStarViewController+RepoStar.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/17.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper
import SwiftDate

extension BFStarViewController {

    /// 加载当前Star 状态
    func toolsLoadRepoStarState(objRepo: ObjRepos?) {
        if !UserManager.shared.isLogin {
            return
        }
        
        if let owner = objRepo?.owner?.login, let repoName = objRepo?.name {
            Provider.sharedProvider.request(.checkStarred(owner:owner, repo:repoName) ) { (result) -> Void in
                var message = kNoDataFoundTip
                print(result)
                switch result {
                case let .success(response):
                    self.selectedRepoStarred = (response.statusCode == BFStatusCode.noContent.rawValue)
                    self.updateRepoStarButtonState()
                case .failure:
                    message = kNetworkErrorTip
                }
            }
        }
    }
    
    
    /// Star repo
    func toolsStarRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            if let owner = objrepo.owner?.login, let repoName = objrepo.name {
                Provider.sharedProvider.request(.starRepo(owner:owner, repo:repoName) ) { (result) -> Void in
                    var message = kNoDataFoundTip
                    print(result)
                    switch result {
                    case let .success(response):
                        
                        let statusCode = response.statusCode
                        if statusCode == BFStatusCode.noContent.rawValue {
                            self.selectedRepoStarred = true
                            self.updateRepoStarButtonState()
                            //TODO: 提示Star成功
                            //插入
                            self.toolsAddRepoWhenStarRepo(objRepo: objrepo)
                        } else {
                            
                        }
                        
                    case .failure:
                        message = kNetworkErrorTip
                    }
                }
            }
        }
        
    }
    
    /// Unstar repo
    func toolsUnstarRequest() {
        if !UserManager.shared.isLogin {
            return
        }
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            if let owner = objrepo.owner?.login, let repoName = objrepo.name {
                Provider.sharedProvider.request(.unstarRepo(owner:owner, repo:repoName) ) { (result) -> Void in
                    var message = kNoDataFoundTip
                    print(result)
                    switch result {
                    case let .success(response):
                        let statusCode = response.statusCode
                        if statusCode == BFStatusCode.noContent.rawValue {
                            self.selectedRepoStarred = false
                            self.updateRepoStarButtonState()
                            //TODO: 提示unstar成功
                            if let repoid = objrepo.id {
                                self.toolsDeleteRepoWhenUnStarRepo(repoId: repoid)
                            }
                        } else {
                            
                        }
                        
                    case .failure:
                        message = kNetworkErrorTip
                    }
                }
            }
        }
        
      
    }
    
    
    // MARK: - BeeFun DB 操作
    func toolsDeleteRepoWhenUnStarRepo(repoId: Int) {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.delRepo(repoid: repoId)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum {
                            if code == BFStatusCode.bfOk {
                                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.didUnStarRepo, object: nil)
                            }
                        } else {
                            
                        }
                    }
                } catch {
                }
            case .failure:
                break
            }
        }
    }
    
    func toolsAddRepoWhenStarRepo(objRepo: ObjRepos) {
        let now = DateInRegion()
        objRepo.starred_at = now.iso8601()
        BeeFunProvider.sharedProvider.request(BeeFunAPI.addRepo(repo: objRepo)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum {
                            if code == BFStatusCode.bfOk {
                                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.didStarRepo, object: nil)
                            }
                        } else {
                            
                        }
                    }
                } catch {
                }
            case .failure:
                break
            }
        }
    }
}
