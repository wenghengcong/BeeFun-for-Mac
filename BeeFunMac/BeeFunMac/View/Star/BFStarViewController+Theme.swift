//
//  BFStarViewController+Theme.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        loadTheme()
    }
    
    func loadTheme() {
        let thManager = BFThemeManager.shared
        
        //all / untagged star button
        refreshAllAndUntaggedButton()
        
        //分割线的颜色
        tagManagerRightLine.backgColor = NSColor.xyLineGrayDarkGray
        tagManagerLeftLne.backgColor = NSColor.xyLineGrayDarkGray
        searchFilterRightLine.backgColor = NSColor.xyLineGray
        
        //显示点击按钮背景视图
        tagActionStackView.backgColor = NSColor.xyWhiteDarkBlack
        allTagsBackView.backgColor = NSColor.xyWhiteDarkBlack
        unTaggedBackView.backgColor = NSColor.xyWhiteDarkBlack

        //显示文本的视图背景色
        tagSortBackView.backgColor = NSColor.xyWhiteDarkBlack
        tagSortButton.backgColor = NSColor.xyWhiteDarkBlack
        tagTextLabel.backgroundColor = NSColor.xyWhiteDarkBlack
        tagTextLabel.textColor = NSColor.xyBlackDarkWhite
        
        refreshButton.image = thManager.starSyncImage(selected: false)
        starSyncLabel.backgroundColor = NSColor.xyWhiteDarkBlack
        starSyncLabel.textColor = NSColor.xyBlackDarkWhite
        starSyncBackView.backgColor = NSColor.xyWhiteDarkBlack
                
        //保存新Tag按钮
        saveNewTagBtn.image = thManager.starSaveTagImage(selected: false)
        saveNewTagBtn.alternateImage = thManager.starSaveTagImage(selected: true)
        
        //
        
        tableViewBackground.backgColor = NSColor.xyWhiteDarkBlack
        
//        tagTable.borderColor = thManager.sepLineBackgroundColor()
//        tagTable.borderWidth = 0.5
//        starTable.borderColor = thManager.sepLineBackgroundColor()
//        starTable.borderWidth = 0.5
        
        addTagContainView.backgColor = NSColor.xyWhiteDarkBlack
        addTagContainView.borderColor = NSColor.lineGrayColor

        workingTagsView.backgroundColor = NSColor.xyWhiteDarkBlack

        orderFilterView.backgColor = NSColor.xyWhiteDarkBlack
        searchFilterView.backgColor = NSColor.xyWhiteDarkBlack
        toolsView.backgColor = NSColor.xyWhiteDarkBlack

        //右边readme上面区域
        let diction = AttributedDictionary.attributeDictionary(foreColor: NSColor.xyBlackDarkWhite, backColor: NSColor.xyWhiteDarkBlack, alignment: .left, lineBreak: nil, baselineOffset: nil, font: NSFont.bfBoldSystemFont(ofSize: 14.0))
        
        repoOwnerBtn.attributedTitle = NSAttributedString(string: "--------/", attributes: diction)
        repoNameBtn.attributedTitle = NSAttributedString(string: "-----------", attributes: diction)
        repoInfoLbl.textColor = NSColor.xyGrayDarkWhite
        repoDescLbl.textColor = NSColor.xyGrayDarkWhite
        
        repoTagsTextField.placeholderString = "Add new tag"
        
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            oriSelRepoStatTags = objrepo.star_tags
            loadRepoInfomation(objRepo: objrepo)
        }
    }
}
