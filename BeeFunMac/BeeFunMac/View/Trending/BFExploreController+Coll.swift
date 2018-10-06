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

//        let detaiLlayout = detailCollectionView.collectionViewLayout as! NSCollectionViewFlowLayout
//        detaiLlayout.itemSize = NSSize(width: 350, height: 190)
//        detaiLlayout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)

        
    }
    
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
            let sectionTitle = navigationdTitles[section]
            if let sectionData = navigationdData[sectionTitle] {
                return sectionData.count
            }
            return 0
        } else if collectionView == detailCollectionView {
            if navigationType == .githubTrendingRepos {
                return githubTrendingReposData[section].count
            } else if navigationType == .githubTrendingDevelopers {
                return githubTrendingDevelopserData[section].count
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
                return item
            }
        } else if collectionView == detailCollectionView {
            switch navigationType {
            case .githubTrendingDevelopers:
                if let item =  detailCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExploreDevelopersViewItem, for: indexPath) as? BFExploreDevelopersViewItem {
                    let sectionIndexData = githubTrendingDevelopserData[indexPath.section][indexPath.item]
                    //                    item.repoModel = sectionIndexData
                }
            case .githubTrendingRepos:
               
                if let item =  detailCollectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.BeeFun.BFExploreReposViewItem, for: indexPath) as? BFExploreReposViewItem {
                    let sectionIndexData = githubTrendingReposData[indexPath.section][indexPath.item]
                    item.repoModel = sectionIndexData
                    return item
                }
              
            default:
                break
            }
        }
        
        return NSCollectionViewItem()
    }
    
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first else {return}
        guard let item = collectionView.item(at: indexPath) else {return}
        
        if collectionView == navigationCollectionView {
            (item as! BFExpolreNavigationViewItem).setHighlight(selected: true)
            clickNavigationArea()
        }
      
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {return}
        guard let item = collectionView.item(at: indexPath) else {return}
        
        if collectionView == navigationCollectionView {
            (item as! BFExpolreNavigationViewItem).setHighlight(selected: false)
            
        }
    }
    
    // MARK: - Navigation area action
    func clickNavigationArea() {
        
        switch navigationType {
        case .githubTrendingDevelopers:
            getGithubTrendingDeveloper(refresh: false)
        case .githubTrendingRepos:
            getGithubTrendingReopsitories(refresh: false)
        default:
            getGithubTrendingReopsitories(refresh: false)
        }
    }
    
    func doubleClickNavigationItem(navigationItem: BFExpolreNavigationViewItem) {
        switch navigationType {
        case .githubTrendingDevelopers:
            getGithubTrendingDeveloper(refresh: true)
        case .githubTrendingRepos:
            getGithubTrendingReopsitories(refresh: true)
        default:
            getGithubTrendingReopsitories(refresh: true)
        }
    }
}
