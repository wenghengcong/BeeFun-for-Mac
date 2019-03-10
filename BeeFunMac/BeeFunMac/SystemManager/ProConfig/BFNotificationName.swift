//
//  DeviceCfg.swift
//  BeeFun
//
//  Created by wenghengcong on 16/1/3.
//  Copyright © 2016年 JungleSong. All rights reserved.
//
import Foundation

extension Notification.Name {
    
    public struct BeeFun {
        
        public static let appAppearanceChanged =
            NSNotification.Name("appAppearanceChanged")
        
        public static let WillLogin = Notification.Name("com.luci.beefun.mac.willlogin")
        public static let DidLogin = Notification.Name("com.luci.beefun.mac.didlogin")
        
        /// 获取到oauth token
        public static let GetOAuthToken = Notification.Name("com.luci.beefun.mac.gettoken")
        /// 登录后，获取到用户信息
        public static let GetUserInfo = Notification.Name("com.luci.beefun.mac.getuserinfo")
        
        public static let WillLogout = Notification.Name("com.luci.beefun.mac.willlogout")
        public static let DidLogout = Notification.Name("com.luci.beefun.mac.didlogout")
        public static let AddTag = Notification.Name("com.luci.beefun.mac.addtag")
        public static let UpdateTag = Notification.Name("com.luci.beefun.mac.updatetag")
        public static let DelTag = Notification.Name("com.luci.beefun.mac.deltag")
        //同步GitHub数据到服务器端
        public static let SyncStarRepoStart = Notification.Name("com.luci.beefun.mac.SyncStartGithubStar")
        public static let SyncStarRepoEnd = Notification.Name("com.luci.beefun.mac.SyncEndGithubStar")

        public static let RepoUpdateTag = Notification.Name("com.luci.beefun.mac.repoupdatetag")
        
        /// Star Action
        public static let didStarRepo = Notification.Name( "com.luci.beefun.mac.didStarRepo")
        
        /// UnStar Action
        public static let didUnStarRepo = Notification.Name( "com.luci.beefun.mac.ddiUnStarRepo")
        
        public static let AppInReview = Notification.Name( "com.luci.beefun.mac.AppInReview")
        
        
        /// 语言选择
        public static let SelectShowLanguage = Notification.Name( "com.luci.beefun.mac.SelectShowLanguage")
        public static let AddFavouriteLanguage = Notification.Name( "com.luci.beefun.mac.AddFavouriteLanguage")
        public static let EditFavouriteLanguage = Notification.Name( "com.luci.beefun.mac.EditFavouriteLanguage")

        /// 完成喜欢语言的选择
        public static let DoneFavouriteLanguage = Notification.Name( "com.luci.beefun.mac.DoneFavouriteLanguage")
        
    }
    
}
