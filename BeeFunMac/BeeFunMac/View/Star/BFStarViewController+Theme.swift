//
//  BFStarViewController+Theme.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/7/29.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    func loadTheme() {
        let thManager = BFThemeManager.shared
        
        //分割线的颜色
        tagManagerRightLine.backgColor = thManager.sepLineBackgroundColor()
        searchFilterRightLine.backgColor = thManager.sepLineBackgroundColor()
        
        //显示点击按钮背景视图
        let bgColor = thManager.tagActionBackgroundColor()
        tagActionStackView.backgColor = bgColor
        allTagsBackView.backgColor = bgColor
        unTaggedBackView.backgColor = bgColor

        //显示文本的视图背景色
        tagSortBackView.backgColor = thManager.tagShowBackgroundColor()
        tagSortButton.backgColor = thManager.tagShowBackgroundColor()
        tagTextLabel.backgroundColor = thManager.tagShowBackgroundColor()
        tagTextLabel.textColor = thManager.tagShowTitleColor()
        
        refreshButton.image = thManager.starSyncImage(selected: false)
        starSyncLabel.backgroundColor = thManager.tagShowBackgroundColor()
        starSyncLabel.textColor = thManager.tagShowTitleColor()
        starSyncBackView.backgColor = thManager.tagShowBackgroundColor()
                
        //保存新Tag按钮
        saveNewTagBtn.image = thManager.starSaveTagImage(selected: false)
        saveNewTagBtn.alternateImage = thManager.starSaveTagImage(selected: true)
        
        //
        
        tableViewBackground.backgColor = NSColor.white
        
//        tagTable.borderColor = thManager.sepLineBackgroundColor()
//        tagTable.borderWidth = 0.5
//        starTable.borderColor = thManager.sepLineBackgroundColor()
//        starTable.borderWidth = 0.5
        
        addTagContainView.backgColor = NSColor.white
        workingTagsView.backgroundColor = NSColor.green

        orderFilterView.backgColor = NSColor.white
        searchFilterView.backgColor = thManager.tagShowBackgroundColor()
        toolsView.backgColor = thManager.tagShowBackgroundColor()

    }
}
