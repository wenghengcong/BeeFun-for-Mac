//
//  BFExploreDeveloperViewFlowLayout.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/7.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExploreDeveloperFlowLayout: NSCollectionViewFlowLayout {

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
//    
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
