//
//  UserManager.swift
//  BeeFun
//
//  Created by wenghengcong on 16/1/16.
//  Copyright © 2016年 JungleSong. All rights reserved.
//

import Cocoa
import ObjectMapper
import Crashlytics

class UserManager: NSObject {
    
    static let shared = UserManager()

    // MARK: - 初始化
    override init() {
        super.init()
        if isLogin {
            //去请求一次用户数据
            let provider = Provider.sharedProvider
            provider.request(.myInfo) { (result) -> Void in
                switch result {
                case let .success(response):
                    do {
                        if let gitUser: ObjUser = Mapper<ObjUser>().map(JSONObject: try response.mapJSON()) {
                            if gitUser.login != nil {
                                self.user = gitUser
                                self.setCrashlytics()
                            }
                        } else {
                        }
                    } catch {
                    }
                case .failure:
                    break
                }

            }
        }
    }

    /// 初始化Crashlytics参数
    func setCrashlytics() {
        if let username = self.user?.name {
            Crashlytics.sharedInstance().setUserName(username)
        }

        if let email = self.user?.email {
            Crashlytics.sharedInstance().setUserEmail(email)
        }

        if let login = self.user?.login {
            Crashlytics.sharedInstance().setUserIdentifier(login)
        }

        AnswerManager.logLogin(method: "AutoLogin", success: true, attributes: [:])
    }

    // MARK: - User 属性
    // MARK: 判断用户类型
    var isUser: Bool {
        if isLogin && ( (user!.type!) == "User") {
            return true
        }
        return false
    }

    // MARK: 用户名，可能不唯一，也有可能为空
    var name: String? {
        return user?.name
    }

    // MARK: 登录名，唯一，目前看来，不为空
    var login: String? {
        return user?.login
    }

    // MARK: user token
    var userToken: String {
        get {
            return AppToken().access_token!
        }
        set(newtoken) {
            let token = AppToken.shared
            token.access_token = newtoken
            user?.token = newtoken
        }
    }
    
    // MARK: - User数据持久化
    /// 用户对象
    var user: ObjUser? {
        get {
            let user: ObjUser? = ObjUser.loadUserInfo()
            return user
        }
        set(newUser) {
            ObjUser.saveUserInfo(newUser)
        }
    }
    /// 重载用户对象
    func reloadUser() {
        self.user = ObjUser.loadUserInfo()
    }
    /// 保存用户对象
    ///
    /// - Parameter user: user对象
    func saveUser(user: ObjUser) {
        ObjUser.saveUserInfo(user)
        self.reloadUser()
    }

    /// 删除用户对象
    func deleteUser() {
        ObjUser.deleteUserInfo()
        self.reloadUser()
    }

    // MARK: - 是否登录
    /// 检查是否登录，未登录时，执行操作
    ///
    func checkUserLogin() -> Bool {
        return isLogin
    }
    /// 是否登录，不作登录操作
    var isLogin: Bool {
        if user != nil {
            if ((user!.login) != nil) && !((user!.login!).isEmpty) && (AppToken().access_token != nil) {
                return true
            }
        }
        return false
    }
    // MARK: - Sign in/out
    
    /// 用户登录
    func userSignIn() {
        OAuthManager.shared.openWindow()
    }
    
    /// 用户登出
    func userSignOut() {
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.WillLogout, object:nil)
        NetworkHelper.clearCache()
        NetworkHelper.clearCookies()
//        UserManager.shared.deleteUser()
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.DidLogout, object:nil)
        //以下崩溃
        OAuthManager.shared.openWindow()
    }
    
}
