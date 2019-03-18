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
        // 先将loading隐藏
        progressStopAnimation()
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
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        var itemSize = NSSize.zero
        if isRepository() {
            itemSize = NSMakeSize(338, 55)
        } else {
            
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return isRepository() ? 0 : 5
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return isRepository() ? 0 : 5
    }
    
    
//    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
//        return nil
//    }
}

extension MenuTrendingController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForFooterInSection section: Int) -> NSSize {
        return NSSize.zero
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize.zero
    }
}

extension MenuTrendingController {
    
    /// 开始加载loading
    func progressStartAnimation() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimation(nil)
    }
    
    /// 停止加载loading
    func progressStopAnimation() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimation(nil)
    }
}
