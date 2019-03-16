//
//  NSUserInterfaceItemIdentifier.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/6.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension NSUserInterfaceItemIdentifier {

    public struct BeeFun {
        
        /// Explore 部分
        public static let BFExpolreNavigationViewItem = NSUserInterfaceItemIdentifier( "BFExpolreNavigationViewItem")
        public static let BFExploreReposViewItem = NSUserInterfaceItemIdentifier( "BFExploreReposViewItem")
        public static let BFExploreDevelopersViewItem = NSUserInterfaceItemIdentifier( "BFExploreDevelopersViewItem")
        
        
        /// Star部分
        public static let StarCellIdentifier = NSUserInterfaceItemIdentifier( "StarCellIdentifier")
        public static let TagCellIdentifier = NSUserInterfaceItemIdentifier( "TagCellIdentifier")
        public static let BFTagsTipCellView = NSUserInterfaceItemIdentifier( "BFTagsTipCellView")
    }
    
    public struct MenuApp {
        public static let MenuTrendRepoItem = NSUserInterfaceItemIdentifier( "MenuTrendRepoItem")
        public static let MenuTrendDevItem = NSUserInterfaceItemIdentifier( "MenuTrendDevItem")
    }
    
}
