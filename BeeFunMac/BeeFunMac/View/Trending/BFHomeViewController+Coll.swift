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
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if navigationType == .githubTrendingRepos {
            return githubTrendingRepos.count
        } else if navigationType == .githubTrendingDevelopers {
            return githubTrendingDevelopser.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if navigationType == .githubTrendingRepos {
            return githubTrendingRepos[section].count
        } else if navigationType == .githubTrendingDevelopers {
            return githubTrendingDevelopser[section].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        return NSCollectionViewItem()
    }
}
