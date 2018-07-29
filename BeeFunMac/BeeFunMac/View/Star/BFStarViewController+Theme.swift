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
        
        //显示点击按钮背景视图
        let bgColor = thManager.tagActionBackgroundColor()
//        TagActionStackView.backgroundColor = bgColor
        allTagsBackView.backgroundColor = bgColor
        unTaggedBackView.backgroundColor = bgColor
        
        //显示文本的视图背景色
        tagSortBackView.backgroundColor = thManager.tagShowBackgroundColor()
        starSyncBackView.backgroundColor = thManager.tagShowBackgroundColor()
                
        //保存新Tag按钮
        saveNewTagBtn.image = thManager.saveTagNormalImage()
        saveNewTagBtn.alternateImage = thManager.saveTagSelectedImage()
        
        //
        
    }
}
