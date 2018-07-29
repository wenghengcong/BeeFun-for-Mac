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
        tagManagerRightLine.backgroundColor = thManager.sepLineBackgroundColor()
        searchFilterRightLine.backgroundColor = thManager.sepLineBackgroundColor()
        
        //显示点击按钮背景视图
        let bgColor = thManager.tagActionBackgroundColor()
        tagActionStackView.backgroundColor = bgColor
        allTagsBackView.backgroundColor = bgColor
        unTaggedBackView.backgroundColor = bgColor
  

        //显示文本的视图背景色
        tagSortBackView.backgroundColor = thManager.tagShowBackgroundColor()
        tagSortButton.backgroundColor = thManager.tagShowBackgroundColor()
        tagTextLabel.backgroundColor = thManager.tagShowBackgroundColor()
        tagTextLabel.textColor = thManager.tagShowTitleColor()
        
        starSyncLabel.backgroundColor = thManager.tagShowBackgroundColor()
        starSyncLabel.textColor = thManager.tagShowTitleColor()
        starSyncBackView.backgroundColor = thManager.tagShowBackgroundColor()
                
        //保存新Tag按钮
        saveNewTagBtn.image = thManager.saveTagNormalImage()
        saveNewTagBtn.alternateImage = thManager.saveTagSelectedImage()
        
        //
        
        tableViewBackground.backgroundColor = NSColor.white
        
//        tagTable.borderColor = thManager.sepLineBackgroundColor()
//        tagTable.borderWidth = 0.5
//        starTable.borderColor = thManager.sepLineBackgroundColor()
//        starTable.borderWidth = 0.5
        
        addTagContainView.backgroundColor = NSColor.white
        workingTagsView.backgroundColor = NSColor.green

        orderFilterView.backgroundColor = NSColor.white
        searchFilterView.backgroundColor = thManager.tagShowBackgroundColor()
        toolsView.backgroundColor = thManager.tagShowBackgroundColor()

    }
}
