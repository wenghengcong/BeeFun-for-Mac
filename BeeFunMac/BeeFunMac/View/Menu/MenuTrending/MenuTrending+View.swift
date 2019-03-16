//
//  MenuTrendingController+View.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

// MARK: Collection view
extension MenuTrendingController {
    
    func menu_trengding_setupView() {
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.isSelectable = true
    }
    
    func menu_trending_changeFlowLayout() {
        var layout: NSCollectionViewFlowLayout? = isRepository() ? MenuTrendRepoLayout() : MenuTrendDevLayout()
        // 假如直接调用detailCollectionView.collectionViewLayout = layout会crash
        // 必须先调用下面两句
        trendingCollectionView.reloadData()
        trendingCollectionView.collectionViewLayout?.invalidateLayout()
        trendingCollectionView.collectionViewLayout = layout
        //设置滚动区域大小
        trendingCollectionView.size = layout?.collectionViewContentSize ?? CGSize.zero
    }
    
    // MARK: - Collection view datasource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if isRepository() {
            return githubTrendingReposData.count
        } else {
            return githubTrendingDevelopserData.count
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if isRepository() {
            if section < githubTrendingReposData.count {
                return githubTrendingReposData[section].count
            }
            return 0
        } else {
            if section < githubTrendingDevelopserData.count {
                return githubTrendingDevelopserData[section].count
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        if isRepository() {
            if let item =  trendingCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.MenuApp.MenuTrendRepoItem, for: indexPath) as? MenuTrendRepoItem {
                let sectionIndexData = githubTrendingReposData[indexPath.section][indexPath.item]
                //                item.delegate = self as! BFExploreReposViewItemDelete
                item.repoModel = sectionIndexData
                return item
            }
        } else {
            if let item =  trendingCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExploreDevelopersViewItem, for: indexPath) as? BFExploreDevelopersViewItem {
                let sectionIndexData = githubTrendingDevelopserData[indexPath.section][indexPath.item]
                item.userModel = sectionIndexData
                return item
            }
        }
        return NSCollectionViewItem()
    }
}
