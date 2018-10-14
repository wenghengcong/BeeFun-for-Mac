//
//  BFExpolreNavigationFlowLayout.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExpolreNavigationFlowLayout: NSCollectionViewFlowLayout {
    
    override init() {
        super.init()
        itemSize = NSMakeSize(260, 90)
        minimumInteritemSpacing = 15.0
        minimumLineSpacing = 15.0
        sectionInset = NSEdgeInsetsMake(10.0, 5, 20.0, 10.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
