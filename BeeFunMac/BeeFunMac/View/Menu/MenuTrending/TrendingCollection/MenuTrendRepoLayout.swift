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
        itemSize = NSMakeSize(330, 60)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
