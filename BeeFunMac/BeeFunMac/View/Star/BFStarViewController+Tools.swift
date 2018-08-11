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
        
        self.repoUrlBtn.target = self
        self.repoUrlBtn.action = #selector(clickRepoUrlAction)
        
        self.repoOwnerBtn.target = self
        self.repoOwnerBtn.action = #selector(clickRepoOwnerAction)
        
        self.repoNameBtn.target = self
        self.repoNameBtn.action = #selector(clickRepoUrlAction)
        
        self.repoStarBtn.target = self
        self.repoStarBtn.action = #selector(clickRepoStarAction)
        
        self.repoDwnBtn.target = self
        self.repoDwnBtn.action = #selector(clickRepoDownloadAction)
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .left
        let dic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle] as [NSAttributedStringKey : Any]
        self.repoOwnerBtn.attributedTitle = NSAttributedString(string: "--------/", attributes: dic)
        self.repoNameBtn.attributedTitle = NSAttributedString(string: "-----------", attributes: dic)
        self.repoInfoLbl.textColor = NSColor.thDayGray
        self.repoDescLbl.textColor = NSColor.thDayBlack
    }
    
    
    /// 点击repo主页
    @objc func clickRepoUrlAction() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            openDefaultWebBrowser(url: objrepo.html_url)
        }
    }
    
    @objc func clickRepoOwnerAction() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            openDefaultWebBrowser(url: objrepo.owner?.html_url)
        }
    }

    @objc func clickRepoStarAction() {
        
    }
    
    @objc func clickRepoDownloadAction() {
        
    }
    
    func refreshRepoInfoAndReadMe() {
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            oriSelRepoStatTags = objrepo.star_tags
            //star状态
            loadRepoStarState(objRepo: objrepo)
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
    
    
    /// 加载当前Star 状态
    func loadRepoStarState(objRepo: ObjRepos?) {
      
        
    }
    
    /// 加载当前repo的信息
    func loadRepoInfomation(objRepo: ObjRepos?) {
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .left
        let dic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle] as [NSAttributedStringKey : Any]
        
        if let owner = objRepo?.owner?.login {
            self.repoOwnerBtn.attributedTitle = NSAttributedString(string: owner, attributes: dic)
        }
        if let repoName = objRepo?.name {
            self.repoNameBtn.attributedTitle = NSAttributedString(string: "/  " + repoName, attributes: dic)
        }
        
        if let repoDesc = objRepo?.cdescription {
            self.repoDescLbl.stringValue = repoDesc
            self.repoDescLbl.preferredMaxLayoutWidth = (self.repoWebView?.width)! - 45
        }
        
        if let createdAt = BFTimeHelper.shared.shortDateTime(rare: objRepo?.created_at, prefix: "Created at") , let updateAt = BFTimeHelper.shared.shortDateTime(rare: objRepo?.updated_at, prefix: "Updated at") {
            self.repoInfoLbl.stringValue = createdAt + "    " + updateAt
            self.repoInfoLbl.preferredMaxLayoutWidth = (self.repoWebView?.width)! - 45
        }
        
        //objRepo?.clone_url
        //objRepo?.git_url
        layoutRepoInfomation(objRepo: objRepo)
    }
    
    func layoutRepoInfomation(objRepo: ObjRepos?) {
//        self.repoOwnerBtn.backgroundColor = NSColor.green
//        self.repoNameBtn.backgroundColor = NSColor.red
        
        self.repoOwnerBtn.sizeToFit()
        let ownerWidth = self.repoOwnerBtn.width + 10
        self.repoOwnerBtn!.snp.updateConstraints { (make) in
            make.width.equalTo(ownerWidth)
        }
        
        self.repoNameBtn.sizeToFit()
        let nameWidth = self.repoNameBtn.width + 15
        self.repoNameBtn!.snp.updateConstraints { (make) in
            make.width.equalTo(nameWidth)
        }
    }
    
    /// readme 页面加载
    func loadRepoReadMePage(objRepo: ObjRepos?) {
        if let owner = objRepo?.owner?.login, let repo = objRepo?.name {
            Provider.sharedProvider.request(GitHubAPI.readme(owner: owner, repo: repo)) { (result) in
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
