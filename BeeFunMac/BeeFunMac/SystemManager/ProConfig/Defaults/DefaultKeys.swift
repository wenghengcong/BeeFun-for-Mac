//
//  DefaultKeys.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/15.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

extension DefaultKeys {
    
    /// 偏好设置用户上一次的选择
    static let lastPreferencesPaneIdentifier = DefaultKey<String>("lastPreferencesPaneIdentifier")
    /// Menu 上次选中的子Tag页
    static let lastMenuPaneIdentifier = DefaultKey<String>("lastMenuPaneIdentifier")
    
    /// Menu Trending上次选中的语言
    static let lastMenuTrendingLanguage = DefaultKey<String>("lastMenuTrendingLanguage")
    /// Menu Trending上次选中的类型
    static let lastMenuTrendingType = DefaultKey<String>("lastMenuTrendingType")
    
    /// 用户选择喜爱的语言
    static let FavouriteLanguages = "com.luci.userdefault.FavouriteLanguages"
   
    /// 是否在启动时，注册menu app
    static let RegisterMenuWhenAppOpen = DefaultKey<String>("com.luci.userdefault.RegisterMenuWhenAppOpen")
    
    // deprecated
    /// 从iphone app带过来的，这个key不能修改
    static let kAppleLanguageKey = "AppleLanguages"
    /// 从iphone app带过来的，用户选择的语言
    static let kAppUserLanguageKey = "kAppUserLanguageKey"
}
