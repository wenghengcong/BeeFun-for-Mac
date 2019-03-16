//
//  JSLanguage.swift
//  BeeFun
//
//  Created by WengHengcong on 2017/3/17.
//  Copyright © 2017年 JungleSong. All rights reserved.
//

import Cocoa

/// 语言管理类，分为系统语言、APP语言、用户选择语言
class JSLanguage: NSObject {

    /// 获取系统的两位语言代码
    class var languageCode: String {
        return  Locale.current.languageCode!
    }

    /// 获取两位区域代码
    class var regionCode: String {
        return  Locale.current.regionCode!
    }

    /// 获取系统的语言
    class var systemLanguage: String {
        //NSLocale.preferredLanguages.first获取到的仍然是app内设置的语言选择
//            let system = NSLocale.preferredLanguages.first!
        var system = languageCode
        if system.contains("zh") {
            system = kChineseLanguage
        } else if system.contains("en") {
            system = kEnglishLanguage
        } else {
            system = kEnglishLanguage
        }
        return system
    }

    /// 用户选择的语言，默认是系统的语言
    class var userLanguage: String? {
        set {
            let def = UserDefaults.standard
            def.set(newValue, forKey: DefaultKeys.kAppUserLanguageKey)
            def.synchronize()
        }

        get {
            let def = UserDefaults.standard
            let choose = def.object(forKey: DefaultKeys.kAppUserLanguageKey)
            return choose as? String
        }
    }

    /// APP语言
    class var appLanguage: String {
        set {
            let def = UserDefaults.standard
            def.set([newValue], forKey: DefaultKeys.kAppleLanguageKey)
            def.synchronize()
        }

        get {
            let def = UserDefaults.standard
            let langArray = def.object(forKey: DefaultKeys.kAppleLanguageKey) as? NSArray
            var current = kEnglishLanguage
            if let lan = langArray?.firstObject as? String {
                current = lan
                if current.contains("zh") {
                    current = kChineseLanguage
                } else if current.contains("en") {
                    current = kEnglishLanguage
                } else {
                    current = kEnglishLanguage
                }
            }
            return current
        }
    }

    /// 设置用户选择语言
    class func switchLanguage(to lang: String) {
        userLanguage = lang
    }

    /// 将用户选择的语言同步到App语言
    class func synchronize() {
        appLanguage = userLanguage!
    }

    /// 初始化语言，默认为系统的语言
    class func initUserLanguage() {
        if userLanguage == nil {
            userLanguage = systemLanguage
        }
        synchronize()
    }

    /// 设置APP语言为英文语言
    class func setEnglish() {
        userLanguage = kEnglishLanguage
    }

    /// 设置APP语言为中文语言
    class func setChinese() {
        userLanguage = kChineseLanguage
    }

}
