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
        navigationCollectionView.isSelectable = true
        
//        navigationCollectionView.register(NSNib(nibNamed: NSNib.Name(rawValue: "BFExpolreNavigationViewItem"), bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFExpolreNavigationViewItem"))
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        detailCollectionView.isSelectable = true
        
        navigationCollectionView.collectionViewLayout = BFExpolreNavigationFlowLayout()
    }

    
    // MARK: - layout
    func changeFlowLayout() {
        var layout: NSCollectionViewFlowLayout?
        switch navigationType {
        case .githubTrendingDevelopers:
            layout = BFExploreDeveloperFlowLayout()
        case .githubTrendingRepos:
            layout = BFExploreRepositiesFlowLayout()
        default:
            layout = BFExploreRepositiesFlowLayout()
        }
        // 假如直接调用detailCollectionView.collectionViewLayout = layout会crash
        // 必须先调用下面两句
        detailCollectionView.reloadData()
        detailCollectionView.collectionViewLayout?.invalidateLayout()
        detailCollectionView.collectionViewLayout = layout
        //设置滚动区域大小
        detailCollectionView.size = layout?.collectionViewContentSize ?? CGSize.zero
    }
    
    
    // MARK: - Collection view datasource
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if collectionView == navigationCollectionView {
            return navigationdTitles.count
        } else if collectionView == detailCollectionView {
            if navigationType == .githubTrendingRepos {
                return githubTrendingReposData.count
            } else if navigationType == .githubTrendingDevelopers {
                return githubTrendingDevelopserData.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == navigationCollectionView {
            if section < navigationdTitles.count {
                let sectionTitle = navigationdTitles[section]
                if let sectionData = navigationdData[sectionTitle] {
                    return sectionData.count
                }
            }
            return 0
        } else if collectionView == detailCollectionView {
            if navigationType == .githubTrendingRepos {
                if section < githubTrendingReposData.count {
                    return githubTrendingReposData[section].count
                }
                return 0
            } else if navigationType == .githubTrendingDevelopers {
                if section < githubTrendingDevelopserData.count {
                    return githubTrendingDevelopserData[section].count
                }
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        if collectionView == navigationCollectionView {
          
            if let item =  navigationCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExpolreNavigationViewItem, for: indexPath) as? BFExpolreNavigationViewItem {
                
                let sectionTitle = navigationdTitles[indexPath.section]
                if let sectionData = navigationdData[sectionTitle] {
                    let model = sectionData[indexPath.item]
                    item.exploreNavModel = model
                }
                item.itemDelegate = self
                return item
            }
        } else if collectionView == detailCollectionView {
            switch navigationType {
            case .githubTrendingDevelopers:
                if let item =  detailCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExploreDevelopersViewItem, for: indexPath) as? BFExploreDevelopersViewItem {
                    let sectionIndexData = githubTrendingDevelopserData[indexPath.section][indexPath.item]
                    item.userModel = sectionIndexData
                    return item
                }
            case .githubTrendingRepos:
               
                if let item =  detailCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExploreReposViewItem, for: indexPath) as? BFExploreReposViewItem {
                    let sectionIndexData = githubTrendingReposData[indexPath.section][indexPath.item]
                    item.delegate = self
                    item.repoModel = sectionIndexData
                    return item
                }
              
            default:
                break
            }
        }
        
        return NSCollectionViewItem()
    }
    
    // MARK: - Collection view delegate

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first else {return}
        guard let item = collectionView.item(at: indexPath) else {return}
        
        if collectionView == navigationCollectionView {
            let navItem = item as! BFExpolreNavigationViewItem
            navItem.setHighlight(selected: true)
            clickNavigationArea(navigationItem: navItem)
            changeFlowLayout()
        } else if collectionView == detailCollectionView {
            
        }
      
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {return}
        guard let item = collectionView.item(at: indexPath) else {return}
        
        if collectionView == navigationCollectionView {
            let navItem = item as! BFExpolreNavigationViewItem
            navItem.setHighlight(selected: false)
        } else if collectionView == detailCollectionView {
            
        }
    }
    
    // MARK: - Navigation area action
    // MARK: click
    func clickNavigationArea(navigationItem: BFExpolreNavigationViewItem) {
        
        navigationType = BFExploreNavigationProductType(rawValue: (navigationItem.exploreNavModel?.navType)!) ?? .githubTrendingRepos

        switch navigationType {
        case .githubTrendingDevelopers:
            getGithubTrendingDeveloper(refresh: false)
        case .githubTrendingRepos:
            getGithubTrendingReopsitories(refresh: false)
        default:
            getGithubTrendingReopsitories(refresh: false)
        }
    }
    
    // MARK: double click
    func doubleClickNavigationItem(navigationItem: BFExpolreNavigationViewItem) {
        navigationType = BFExploreNavigationProductType(rawValue: (navigationItem.exploreNavModel?.navType)!) ?? .githubTrendingRepos

        switch navigationType {
        case .githubTrendingDevelopers:
            getGithubTrendingDeveloper(refresh: true)
        case .githubTrendingRepos:
            getGithubTrendingReopsitories(refresh: true)
        default:
            getGithubTrendingReopsitories(refresh: true)
        }
    }
    
    /// Collection view的点击事件如下实现
    ///
    /// - Parameter navigationItem: <#navigationItem description#>
    func singleClickNavigationItem(navigationItem: BFExpolreNavigationViewItem) {
        let indexPath = navigationCollectionView.indexPath(for: navigationItem)
        navigationCollectionView.selectItems(at: [indexPath ?? IndexPath(item: 0, section: 0)] , scrollPosition: NSCollectionView.ScrollPosition.top)
        
        navigationItem.setHighlight(selected: true)
        clickNavigationArea(navigationItem: navigationItem)
        changeFlowLayout()

//        let indexSet:Set<IndexPath> = [indexPath ?? IndexPath(item: 0, section: 0)]
//        collectionView(navigationCollectionView, didSelectItemsAt: indexSet)
    }
}

extension BFExploreController {
    
    func starReposStateChange(repoViewItem: BFExploreReposViewItem, starState: Bool) {
        BeeFunDBManager.shared.updateServerDB(first: false)
    }
}
