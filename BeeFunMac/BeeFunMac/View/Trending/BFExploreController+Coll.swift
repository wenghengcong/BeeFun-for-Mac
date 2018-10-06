//
//  BFExploreController+Coll.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFExploreController {

    func setupCollectionView() {
        
        navigationCollectionView.dataSource = self
        navigationCollectionView.delegate = self
        
//        navigationCollectionView.register(NSNib(nibNamed: NSNib.Name(rawValue: "BFExpolreNavigationViewItem"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFExpolreNavigationViewItem"))
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        
        
        let layout = navigationCollectionView.collectionViewLayout as! NSCollectionViewFlowLayout
        layout.itemSize = NSSize(width: 240, height: 80)
        layout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)

        
        navigationCollectionView.reloadData()
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
            let sectionTitle = navigationdTitles[section]
            if let sectionData = navigationdData[sectionTitle] {
                return sectionData.count
            }
            return 0
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
        
        if collectionView == navigationCollectionView {
          
            if let item =  navigationCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFExpolreNavigationViewItem"), for: indexPath) as? BFExpolreNavigationViewItem {
                let sectionTitle = navigationdTitles[indexPath.section]
                if let sectionData = navigationdData[sectionTitle] {
                    let model = sectionData[indexPath.item]
                    item.exploreNavModel = model
                }
                return item
            }
        }
        
        return NSCollectionViewItem()
    }
}
