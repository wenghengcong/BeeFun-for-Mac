//
//  BFStarViewController+DB.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/12.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

extension BFStarViewController {

    // MARK: - Tag
    func getFirstPageTags() {
        getTagsPage = 1
        getAllTagsDataNetwork()
    }
    
    func getNextPageTags() {
        getTagsPage += 1
        getAllTagsDataNetwork()
    }
    
    // MARK: 获取所有Tag列表
    func getAllTagsDataNetwork() {
        
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getAllTags(page: 0  , perpage: 0, sort: tagSortPara, direction: tagDirectionPara, containAll: "false")) { (result) in
            self.getTagsNextPageLoading = false
            switch result {
            case let .success(response):
                do {
                    if let allTag: GetAllTagResponse = Mapper<GetAllTagResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = allTag.codeEnum, code == BFStatusCode.bfOk {
                            if let data = allTag.data {
                                self.allTags = data
                                self.tagTable.reloadData()
                            }
                        } else {
                            self.resetGetTagsPageAfterNetworkError()
                        }
                    } else {
                        self.resetGetTagsPageAfterNetworkError()
                    }
                } catch {
                    self.resetGetTagsPageAfterNetworkError()
                }
            case .failure:
                self.resetGetTagsPageAfterNetworkError()
            }
        }
    }
    
    // MARK: 新增ObjTag
    func addTagNetwork(tag: ObjTag) {
        
        let willAddTagName = tag.name!.trimmed
        if willAddTagName.lowercased() == "all" {
            //            JSMBHUDBridge.showInfo("'All' is default,change one.".localized)
            return
        }
        
        BeeFunProvider.sharedProvider.request(BeeFunAPI.addTag(tagModel: tag)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: GetAllTagResponse = Mapper<GetAllTagResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum {
                            if code == BFStatusCode.bfOk {
                                //添加成功
                                //TODO: tips
                                //                                JSMBHUDBridge.showSuccess("Success".localized)
                                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.AddTag, object: nil, userInfo: ["tag": tag.name!])
                                //成功后重新将 inputNewTagField 置空
                                self.inputNewTagField.stringValue = ""
                            } else if code == BFStatusCode.addTagWhenExist {
                                //TODO: tips
                                //                                JSMBHUDBridge.showError("Already exists!".localized, view: self.view)
                            }
                        }
                    }
                } catch {
                }
            case .failure:
                //删除失败
                //TODO: tips
                //                JSMBHUDBridge.showError("Failure".localized)
                break
            }
            
        }
    }
    
    // MARK: 重命名Tag
    func renameTagNetwork(form: String, to: String) {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.updateTag(name: form, to: to)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: GetAllTagResponse = Mapper<GetAllTagResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum, code == BFStatusCode.bfOk {
                            //更新成功
                            //TODO: 弹框提醒
                            //                                JSMBHUDBridge.showSuccess("Success".localized)
                            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.RepoUpdateTag, object: nil, userInfo: ["from": form, "to": to])
                            self.refreshAfterRightMenuAction(delete: false)
                        }
                    }
                } catch {
                }
            case .failure:
                //更新失败
                //TODO: 弹框提醒
                //                    JSMBHUDBridge.showError("Failure".localized)
                break
            }
        }
    }
    
    // MARK: - 删除Tag
    func deleteTagNetwork(tag: String) {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.deleteTag(name: tag)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let tagResponse: GetAllTagResponse = Mapper<GetAllTagResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = tagResponse.codeEnum, code == BFStatusCode.bfOk {
                            //TODO: 提示成功
                            //                            JSMBHUDBridge.showSuccess("Success".localized)
                            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.DelTag, object: nil, userInfo: ["tag": tag])
                        }
                    }
                } catch {
                }
            case .failure:
                //TODO: 提示失败
                //                JSMBHUDBridge.showError("Failure".localized)
                break
            }
        }
    }
    // MARK: - Repos
    func getFirstPageStarRepos(allRefresh: Bool, scrollToTop:Bool) {
        getReposPage = 1
        getAllReposNetwork(allRefresh: allRefresh, scrollToTop: scrollToTop)
    }
    
    func getNextPageStarRepos(allRefresh: Bool, scrollToTop:Bool) {
        getReposPage += 1
        getAllReposNetwork(allRefresh: allRefresh, scrollToTop: scrollToTop)
    }
    
    // MARK: 获取所有repos
    func getAllReposNetwork(allRefresh: Bool, scrollToTop:Bool) {
        if getRepoTagPara.isBlank || getRepoLanguageVar.isBlank {
            return
        }
        
        BeeFunProvider.sharedProvider.request(BeeFunAPI.repos(tag: getRepoTagPara, language: getRepoLanguageVar, page: getReposPage, perpage: getReposPerPage, sort: getRepoSortPara, direction: getRepoDirectionPara)) { (result) in
            var message = kNoDataFoundTip
            self.getReposNextPageLoading = false
            switch result {
            case let .success(response):
                do {
                    if let allRepos: GetReposResponse = Mapper<GetReposResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = allRepos.codeEnum, code == BFStatusCode.bfOk {
                            if let data = allRepos.data {
                                DispatchQueue.main.async {
                                    self.hanldeStaredRepoResponse(repos: data, allRefresh: allRefresh, scrollToTop: scrollToTop)
                                }
                            }
                        } else {
                            self.resetGetReposPageAfterNetworkError()
                        }
                    } else {
                        self.resetGetReposPageAfterNetworkError()
                    }
                } catch {
                    //                    JSMBHUDBridge.showError(message, view: self)
                    self.resetGetReposPageAfterNetworkError()
                }
            case .failure:
                message = kNetworkErrorTip
                //                JSMBHUDBridge.showError(message, view: self)
                self.resetGetReposPageAfterNetworkError()
            }
        }
    }
    
    
    
    // MARK: 更新repo tag列表
    func updateRepoTagNetwork() {
        
        if starReposData.isBeyond(index: selectedRepoRow) {
            return
        }
        let repoModel = starReposData[selectedRepoRow]
        
        let star_tagsStr = convertObjListToString(tags: self.workingTags)
        
        if let repoid = repoModel.id {
            BeeFunProvider.sharedProvider.request(BeeFunAPI.addTagToRepo(star_tags: star_tagsStr, repoId: repoid)) { (result) in
                switch result {
                case let .success(response):
                    do {
                        if let allTag: BeeFunResponseModel = Mapper<BeeFunResponseModel>().map(JSONObject: try response.mapJSON()) {
                            if let code = allTag.codeEnum, code == BFStatusCode.bfOk {
                                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.RepoUpdateTag, object: nil, userInfo: ["star_tags": self.workingTags])
                                //在通知中处理如下: addTagSuccessful(noti: NSNotification)
                                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.AddTag, object: nil, userInfo: nil)
                            } else {
                                //TODO:tips
                                //                                JSMBHUDBridge.showError("Update Failure".localized)
                            }
                        }
                    } catch {
                        
                    }
                case .failure: break
                }
            }
        }
    }
    
    // MARK: - Language
    // MARK: 获取语言列表
    func getLanguageDataNetwork() {
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getLanguages(page: 0, perpage: 0, sort: "num", direction: "desc")) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let allLan: GetAllLangResponse = Mapper<GetAllLangResponse>().map(JSONObject: try response.mapJSON()) {
                        if let code = allLan.codeEnum, code == BFStatusCode.bfOk {
                            if let data = allLan.data {
                                self.handleGetLanguageList(data: data)
                            }
                        }
                    }
                } catch {
                }
            case .failure: break
            }
        }
    }
}
