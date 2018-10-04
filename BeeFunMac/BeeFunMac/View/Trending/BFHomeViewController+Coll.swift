//
//  BFHomeViewController+Coll.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFHomeViewController {

    func setupCollectionView() {
        navigationCollectionView.dataSource = self
        navigationCollectionView.delegate = self
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        return NSCollectionViewItem()
    }
}
