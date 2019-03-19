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
        itemSize = NSMakeSize(210, 55)
        minimumInteritemSpacing = 30.0
        minimumLineSpacing = 15.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
