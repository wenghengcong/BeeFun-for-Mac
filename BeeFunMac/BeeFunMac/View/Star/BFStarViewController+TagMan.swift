//
//  BFStarViewController+TagMan.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/9.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import CoreGraphics
import ObjectMapper

// MARK: - 各种按钮点击效果
extension BFStarViewController {
    //tag区域的各种按钮状态管理
    func starButtonsReady() {
        
//        self.refreshButton.isHidden = true
        self.refreshButton.target = self
        self.refreshButton.action = #selector(refreshDataFromNetwork)
        
        self.allStarsBtn.target = self
        self.allStarsBtn.action = #selector(clickAllStarButton)
        
        self.untaggedStarBtn.target = self
        self.untaggedStarBtn.action = #selector(clickUntaggedStarButton)
        
        self.tagSortBtn.target = self
        self.tagSortBtn.action = #selector(clickSortTagButton)
        
        self.saveNewTagBtn.target = self
        self.saveNewTagBtn.action = #selector(clickSaveTagButton)
        
        //TODO: Tag Sort按钮暂时隐藏
        tagSortBtn.isHidden = true
        
        self.inputNewTagField.delegate = self
    }
    
    //刷新按钮
    @objc func refreshDataFromNetwork() {
        //启动从Github拉取数据，更新服务端数据库
        if !updateBeeFunDBLoading {
            BeeFunDBManager.shared.updateServerDB(showTips: true, first: false)
        }
    }
    
    //刷新按钮开始转动
    func refreshStartRotate() {
        updateBeeFunDBLoading = true
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = NSNumber(value: -Double.pi * 2)
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = .infinity;
        self.refreshButton.layer?.position = CGPoint(x: self.refreshButton.frame.midX, y: self.refreshButton.frame.midY)
        self.refreshButton.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.refreshButton?.layer?.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    //刷新按钮停止转动
    func refreshStopRotate() {
        updateBeeFunDBLoading = false
        self.refreshButton?.layer?.removeAnimation(forKey: "rotationAnimation")
    }
    
    //点击All Star
    @objc func clickAllStarButton() {
        //untagged 以及 tag table未选中
        clickAllStar = true
        clickUntaggedStar = false
        allStarsBtn.state = .on
        untaggedStarBtn.state = .off
        saveNewTagBtn.state = .off
        unSelectedTagAndReload()
    }
    //点击Untagged Star
    @objc func clickUntaggedStarButton() {
        //all 以及 tag table未选中
        clickAllStar = false
        clickUntaggedStar = true
        allStarsBtn.state = .off
        untaggedStarBtn.state = .on
        saveNewTagBtn.state = .off
        unSelectedTagAndReload()
    }
    
    //不选中tag table中的tag后的状态改变
    func unSelectedTagAndReload() {
        filterTags = []
        self.selectedTagRow = -1
        deSelectedTagTableRow()
        searchStarReposNow(allRefresh: true, scrollToTop: true)
    }
    //点击tag 排序按钮，当前暂时隐藏
    @objc func clickSortTagButton() {
        
    }
    
    /// tag管理区域保存tag
    @objc func clickSaveTagButton() {
        saveNewTagBtn.state = .off
        saveNewTagToDB()
        getFirstPageTags()
        self.view.window?.makeFirstResponder(inputNewTagField)
    }
    //保存tag到数据库
    func saveNewTagToDB(){
        if inputNewTagField.stringValue.isBlank {
            //TODO:tips
//            JSMBHUDBridge.showInfo("Tag name is blank.".localized)
            return
        }
        let newTag = ObjTag()
        newTag.name = inputNewTagField.stringValue.trimmed
        newTag.owner = UserManager.shared.login
        addTagNetwork(tag: newTag)    
    }
    
    /// 右键弹出按钮
    func starTagRightMenuReady() {
        let renameMenu = NSMenuItem.init(title: "Rename", action: #selector(rightMenuRenameTagAction(sender:)), keyEquivalent: "")
        let delMenu = NSMenuItem.init(title: "Delete", action: #selector(rightMenuDeleteTagAction(sender:)), keyEquivalent: "")
        renameMenu.target = self
        delMenu.target = self
        self.tagRightMenu.addItem(renameMenu)
        self.tagRightMenu.addItem(NSMenuItem.separator())
        self.tagRightMenu.addItem(delMenu)
        self.tagRightMenu.addItem(NSMenuItem.separator())
    }
    
    /// 右键弹出按钮
    @objc func rightMenuRenameTagAction(sender: NSMenuItem) {
        
        let selIndex = self.tagTable.clickedRow
        print("right click menu rename: \(selIndex)")

        let alert = NSAlert()
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        alert.messageText = "Rename Tag"
        alert.informativeText = "will change all repo tags name"
        
        let inputNewTag = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        inputNewTag.placeholderString = "input new tag name"
        
        alert.accessoryView = inputNewTag
        alert.beginSheetModal(for: self.view.window!) { (model) in
            if inputNewTag.stringValue.length <= 0 {
                //TODO: 弹框提醒
                return
            }
            if self.allTags.isBeyond(index: selIndex) {
                return
            }
            let from = self.allTags[selIndex]
            let to = ObjTag()
            to.name = inputNewTag.stringValue
            self.renameTagNetwork(form: from.name!, to: to.name!)
        }
    }
    
    @objc func rightMenuDeleteTagAction(sender: NSMenuItem) {
        let selIndex = tagTable.clickedRow
        print("right click menu delete:\(selIndex)")
        if allTags.isBeyond(index: selIndex) {
            return
        }
        let objTag = allTags[selIndex]
        self.deleteTagNetwork(tag: objTag.name!)
    }
    
    
    /// 右键删除按钮后，刷新相关视图
    /// - Parameter delete: 是否是删除(另外一个操作是重命名tag)
    func refreshAfterRightMenuAction(delete: Bool) {
        
        if delete {
            getFirstPageTags()
            //删除tag后，默认选中"all" tag
            clickAllStarButton()
        } else {
            //更新tag后的刷新
            updateTagRefreshTagsAndRepos()
        }
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            oriSelRepoStatTags = objrepo.star_tags
            //working tags
             refreshWorkingTagsFromRepo(repo: objrepo)
            reLayoutWorkingLayout()
        }
    }
    //TODO: 还没有完成，需要刷新
    func updateTagRefreshTagsAndRepos() {
        getTagsPage = 1
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
                                //重命名tag操作后
                                self.tagTableViewDidSelectRow(self.selectedTagRow)
                                self.searchStarReposNow(allRefresh: true, scrollToTop: true)
                                if !self.starReposData.isBeyond(index: self.selectedRepoRow) {
                                    let objrepo = self.starReposData[self.selectedRepoRow]
                                    self.oriSelRepoStatTags = objrepo.star_tags
                                    //working tags
                                    self.refreshWorkingTagsFromRepo(repo: objrepo)
                                    self.reLayoutWorkingLayout()
                                }
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
}

// MARK: - Tag Table 点击
extension BFStarViewController {
    
    func starPageCustomTagTableView() {
        tagTable.delegate = self
        tagTable.dataSource = self
        tagTable.register(NSNib.init(nibNamed: NSNib.Name(rawValue: "BFStarTagCellView"), bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.TagCell))
        tagTable.selectionHighlightStyle = .none
        tagTable.allowsMultipleSelection = false
        tagTable.target = self
        tagTable.action = #selector(didSelectedTagTableView)
    }
    
    /// 选中行
    @objc func didSelectedTagTableView() {
        
        allStarsBtn.state = .off
        untaggedStarBtn.state = .off
        saveNewTagBtn.state = .off

        clickAllStar = false
        clickUntaggedStar = false
        
        let row = tagTable.clickedRow
        let unselected = -1
        
        if row == unselected {
            tagTableViewDidDeselectRow()
        }else if row != unselected {
            tagTableViewDidSelectRow(row)
        }
    }
    
    private func tagTableViewDidDeselectRow() {
        // clicked outside row
    }
    
    
    /// 选中某一个tag
    private func tagTableViewDidSelectRow(_ row : Int){
        // row did select
        print("did selected \(row)")
        selectedTagRow = row
        for index in 0..<tagTable.numberOfRows {
            if let rowCell = tagTable.view(atColumn: 0, row: index, makeIfNecessary: false) as? BFStarTagCellView {
                rowCell.didSelectedCell(selected: (index == row))
            }
        }
        selectedTag = allTags[row]
        if selectedTag != nil {
            filterTags = [selectedTag!]
        }
        searchStarReposNow(allRefresh: true, scrollToTop: true)
        
        //加载webview
        webViewReadMeAction(sender: nil)
    }
    
    /// 取消选中当前行
    func deSelectedTagTableRow() {
        for index in 0..<tagTable.numberOfRows {
            if let rowCell = tagTable.view(atColumn: 0, row: index, makeIfNecessary: false) as? BFStarTagCellView {
                rowCell.didSelectedCell(selected: false)
            }
        }
    }
    
    func reloadTagTableViewData() {
        //TODO:getAllTagsDataNetwork
        getAllTagsDataNetwork()
        self.tagTable.reloadData()
    }
}
