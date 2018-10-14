//
//  BFStarViewController+Tools.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/9.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    
    /// 定制repo区域内各按钮动作
    func starPageCustomRepoInfoArea() {
        
        repoUrlBtn.target = self
        repoUrlBtn.action = #selector(clickRepoUrlAction)
        
        repoOwnerBtn.target = self
        repoOwnerBtn.action = #selector(clickRepoOwnerAction)
        
        repoNameBtn.target = self
        repoNameBtn.action = #selector(clickRepoUrlAction)
        
        repoStarBtn.target = self
        repoStarBtn.allowsMixedState = false
        repoStarBtn.action = #selector(clickRepoStarAction)
        
        repoDwnBtn.target = self
        repoDwnBtn.action = #selector(clickRepoDownloadAction)
        

    }
    
    func updateRepoStarButtonState() {
        if selectedRepoStarred {
            repoStarBtn.state = .on
        } else {
            repoStarBtn.state = .off
        }
    }
    
    
    /// 点击repo主页
    @objc func clickRepoUrlAction() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            BFBrowserManager.shared.openUrl(url: objrepo.html_url)
        }
    }
    
    @objc func clickRepoOwnerAction() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            BFBrowserManager.shared.openUrl(url: objrepo.owner?.html_url)
        }
    }

    @objc func clickRepoStarAction() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let _ = starReposData[selectedRepoRow]
            if repoStarBtn.state == .on {
                //Star请求
                toolsStarRequest()
            } else {
                //Unstar请求
                toolsUnstarRequest()
            }
        }
    }
    
    @objc func clickRepoDownloadAction() {
        if downloadPopover.isShown {
            downloadPopover.close()
        } else {
            if !starReposData.isBeyond(index: selectedRepoRow) {
                let objrepo = starReposData[selectedRepoRow]
                downloadPopover.show(relativeTo: NSZeroRect, of: repoDwnBtn, preferredEdge: .maxY)
                if let popContent: BFStarDownloadController = downloadPopover.contentViewController as? BFStarDownloadController {
                    popContent.repository = objrepo
                }
            }
        }
    }
    
    func refreshRepoInfoAndReadMe() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            oriSelRepoStatTags = objrepo.star_tags
            //star状态
            toolsLoadRepoStarState(objRepo: objrepo)
            //repo信息
            loadRepoInfomation(objRepo: objrepo)
            //加载readme
            loadRepoReadMePage(objRepo: objrepo)
            //working tags
            refreshWorkingTagsFromRepo(repo: objrepo)
            reLayoutWorkingLayout()
        } else {
            refreshWorkingTagsFromRepo(repo: nil)
            webViewReadMeAction(sender: nil)
            reLayoutWorkingLayout()
        }
    }
    
    /// 加载当前repo的信息
    func loadRepoInfomation(objRepo: ObjRepos?) {
        
        let dic = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyBlackDarkWhite, backColor: NSColor.xyWhiteDarkBlack, alignment: .left, lineBreak: nil, baselineOffset: nil, font: NSFont.bfBoldSystemFont(ofSize: 14.0))
        
        if let owner = objRepo?.owner?.login {
            repoOwnerBtn.attributedTitle = NSAttributedString(string: owner, attributes: dic)
        }
        if let repoName = objRepo?.name {
            repoNameBtn.attributedTitle = NSAttributedString(string: "/  " + repoName, attributes: dic)
        }
        
        if let repoDesc = objRepo?.cdescription {
            repoDescLbl.stringValue = repoDesc
            repoDescLbl.preferredMaxLayoutWidth = (repoWebView?.width)! - 45
        }
        
        if let createdAt = BFTimeHelper.shared.shortDateTime(rare: objRepo?.created_at, prefix: "Created at") , let pushedAt = BFTimeHelper.shared.shortDateTime(rare: objRepo?.pushed_at, prefix: "Latest commit pushed at") {
            repoInfoLbl.stringValue = createdAt + "    ||    " + pushedAt
            repoInfoLbl.preferredMaxLayoutWidth = (repoWebView?.width)! - 45
        }
        
        //objRepo?.clone_url
        //objRepo?.git_url
        layoutRepoInfomation(objRepo: objRepo)
    }
    
    func layoutRepoInfomation(objRepo: ObjRepos?) {
        
        repoOwnerBtn.sizeToFit()
        let ownerWidth = repoOwnerBtn.width + 10
        repoOwnerBtn!.snp.updateConstraints { (make) in
            make.width.equalTo(ownerWidth)
        }
        
        repoNameBtn.sizeToFit()
        let nameWidth = repoNameBtn.width + 15
        repoNameBtn!.snp.updateConstraints { (make) in
            make.width.equalTo(nameWidth)
        }
    }

    /// readme 页面加载
    func loadRepoReadMePage(objRepo: ObjRepos?) {
        
        if let requestBefore = loadReadMeRequest {
            for request in requestBefore {
                print("cancel request before: \(request)")
                request.cancel()
            }
            loadReadMeRequest?.removeAll()
        }
        
        if let owner = objRepo?.owner?.login, let repo = objRepo?.name {
        let readmeRequest = Provider.sharedProvider.request(GitHubAPI.readme(owner: owner, repo: repo)) { (result) in
                switch result {
                case let .success(response):
                    do {
                        let htmlString = try response.mapString()
                        let statusCode = response.statusCode
                        let templateHtml = self.getTemplateHTML()
                        //https://github.com/sindresorhus/github-markdown-css
                        let htmlPathURL = Bundle.main.url(forResource: "readmeTemplate", withExtension: "html")
                        let resultHtml = templateHtml.replacing("{{body}}", with: htmlString)
                        if statusCode == BFStatusCode.ok.rawValue {
                            //                            let basePath = Bundle.main.bundlePath
                            if let baseUrlPath = htmlPathURL?.deletingLastPathComponent() {
                                self.repoWebView?.loadHTMLString(resultHtml, baseURL: baseUrlPath)
                            } else{
                                self.loadReadEmptyPage()
                            }
                        } else {
                            self.loadReadEmptyPage()
                        }
                    } catch {
                        self.loadReadEmptyPage()
                    }
                    
                case .failure:
                    self.loadReadEmptyPage()
                    break
                }
            }
            
            loadReadMeRequest?.append(readmeRequest)
        }
        
        
    }
    
    private func getTemplateHTML() -> String {
        var html = ""
        if let htmlPathURL = Bundle.main.url(forResource: "readmeTemplate", withExtension: "html"){
            do {
                html = try String(contentsOf: htmlPathURL, encoding: .utf8)
            } catch  {
                print("Unable to get the file.")
            }
        }
        
        return html
    }
}
