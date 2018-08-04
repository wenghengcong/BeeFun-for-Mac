//
//  BFStarViewController+Repo.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/9.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper
import Down

// MARK: - Star repo Table
extension BFStarViewController {
    
    func starPageCustomRepoTableView() {
        starTable.delegate = self
        starTable.dataSource = self
        starTable.register(NSNib.init(nibNamed: NSNib.Name(rawValue: "BFStarTableCellView"), bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.StarCell))
        starTable.selectionHighlightStyle = .none
        starTable.allowsMultipleSelection = false
        starTable.target = self
        starTable.action = #selector(didSelectedRepoTableView)
        starTable.enclosingScrollView?.borderType = .noBorder
//        starTable.enclosingScrollView?.scrollerKnobStyle = .default
        
    }
    
    /// 选中行
    @objc func didSelectedRepoTableView() {
        
        resignAllTextFieldFirstResponder()
        let row = starTable.clickedRow
        let unselected = -1
        
        if row == unselected {
            repoTableViewDidDeselectRow()
        }else if row != unselected {
            repoTableViewDidSelectRow(row)
        }
    }
    
    private func repoTableViewDidDeselectRow() {
        // clicked outside row
    }
    
    func repoTableViewDidSelectRow(_ row : Int){
        // row did select
        print("did selected \(row)")
        selectedRepoRow = row
        for index in 0..<starTable.numberOfRows {
            if let rowCell = starTable.view(atColumn: 0, row: index, makeIfNecessary: false) as? BFStarTableCellView {
                rowCell.didSelectedCell(selected: (index == row))
            }
        }
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            oriSelRepoStatTags = objrepo.star_tags
            loadRepoReadMePage(objRepo: objrepo)
            //working tags
            refreshWorkingTagsFromRepo(repo: objrepo)
            reLayoutWorkingLayout()
        }
    }

    func loadRepoReadMePage(objRepo: ObjRepos) {
        if let owner = objRepo.owner?.login, let repo = objRepo.name {
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
