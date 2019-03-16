//
//  MenuTrendRepoFlowLayout.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuTrendRepoLayout: NSCollectionViewFlowLayout {
    override init() {
        super.init()
        itemSize = NSMakeSize(120, 160)
        minimumInteritemSpacing = 15.0
        minimumLineSpacing = 15.0
        sectionInset = NSEdgeInsetsMake(10.0, 10.0, 20.0, 10.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
