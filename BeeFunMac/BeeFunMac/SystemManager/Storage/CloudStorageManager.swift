//
//  CloudStorageManager.swift
//  BeeFun
//
//  Created by WengHengcong on 2017/4/1.
//  Copyright © 2017年 JungleSong. All rights reserved.
//

import AppKit
//import AVOSCloud

//管理台 https://leancloud.cn/dashboard/data.html?appid=ghlejYYQiuNbEQftPzNzVlCQ-gzGzoHsz#/
//文档 https://leancloud.cn/docs/leanstorage_guide-objc.html

class CloudStorageManager: NSObject {
    /*
    class func storageInit() {
        AVOSCloud.setApplicationId(LeanCloudAppID, clientKey: LeanCloudAppKey)
//        AVOSCloud.setAllLogsEnabled(true)

        //获取设置
        getAppRewardSwitch()
    }

    /// 设置reward的开关
    class func getAppRewardSwitch() {
        let query = AVQuery.init(className:CloudAppSetting)
        query.getObjectInBackground(withId: AppSettingsRewardObjectId) { (avobject, error) in
            if error == nil && avobject != nil {
                if (avobject?["switch"]) != nil {
                    UserManager.shared.rewarSwitch = (avobject?["switch"] as? Bool)!
                }
            }
        }
    }
    */
}
