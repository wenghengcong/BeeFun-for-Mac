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
        itemSize = NSMakeSize(338, 55)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionInset = NSEdgeInsetsZero
        headerReferenceSize = NSSize.zero
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
