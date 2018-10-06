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
        
        navigationCollectionView.register(NSNib(nibNamed: NSNib.Name(rawValue: "BFExpolreNavigationViewItem"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFExpolreNavigationViewItem"))
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        
        
        let layout = navigationCollectionView.collectionViewLayout as! NSCollectionViewFlowLayout
        layout.itemSize = NSSize(width: 40, height: 30)
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if collectionView == navigationCollectionView {
            return navigationdTitles.count
        } else if collectionView == detailCollectionView {
            if navigationType == .githubTrendingRepos {
                return githubTrendingRepos.count
            } else if navigationType == .githubTrendingDevelopers {
                return githubTrendingDevelopser.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == navigationCollectionView {
            return navigationdData[section].count
        } else if collectionView == detailCollectionView {
            if navigationType == .githubTrendingRepos {
                return githubTrendingRepos[section].count
            } else if navigationType == .githubTrendingDevelopers {
                return githubTrendingDevelopser[section].count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
//        if collectionView == navigationCollectionView {
//            let item = navigationCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFExpolreNavigationViewItem"), for: indexPath)
////            guard item is BFExpolreNavigationViewItem
////                else {return item}
//
//        }
        
        return NSCollectionViewItem()
    }
}
