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
        public static let WillLogin = Notification.Name(rawValue:"com.luci.beefun.mac.willlogin")
        public static let DidLogin = Notification.Name(rawValue:"com.luci.beefun.mac.didlogin")
        
        /// 获取到oauth token
        public static let GetOAuthToken = Notification.Name(rawValue:"com.luci.beefun.mac.gettoken")
        /// 登录后，获取到用户信息
        public static let GetUserInfo = Notification.Name(rawValue:"com.luci.beefun.mac.getuserinfo")
        
        public static let WillLogout = Notification.Name(rawValue:"com.luci.beefun.mac.willlogout")
        public static let DidLogout = Notification.Name(rawValue:"com.luci.beefun.mac.didlogout")
        public static let AddTag = Notification.Name(rawValue:"com.luci.beefun.mac.addtag")
        public static let UpdateTag = Notification.Name(rawValue:"com.luci.beefun.mac.updatetag")
        public static let DelTag = Notification.Name(rawValue:"com.luci.beefun.mac.deltag")
        //同步GitHub数据到服务器端
        public static let SyncStarRepoStart = Notification.Name(rawValue:"com.luci.beefun.mac.SyncStartGithubStar")
        public static let SyncStarRepoEnd = Notification.Name(rawValue:"com.luci.beefun.mac.SyncEndGithubStar")

        public static let RepoUpdateTag = Notification.Name(rawValue:"com.luci.beefun.mac.repoupdatetag")
        
    }
    
}
