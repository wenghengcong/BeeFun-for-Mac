//
//  BFExploreReposViewFlowLayout.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/7.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExploreRepositiesFlowLayout: NSCollectionViewFlowLayout {

    override init() {
        super.init()
        itemSize = NSMakeSize(270, 138)
        minimumInteritemSpacing = 10.0
        minimumLineSpacing = 20.0
        sectionInset = NSEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> NSCollectionViewLayoutAttributes? {
//        let attributes = super.layoutAttributesForItem(at: indexPath)
//        attributes?.zIndex = indexPath.item
//        return attributes
//    }
//    
//    override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
//        let layoutAttributesArray = super.layoutAttributesForElements(in: rect)
//        for attri in layoutAttributesArray {
//            attri.zIndex = attri.indexPath!.item
//        }
//        return layoutAttributesArray
//    }
}
