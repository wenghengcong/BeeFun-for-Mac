//
//  OAuthManager.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/24.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import OAuthSwift
import ObjectMapper
import AppKit

class OAuthManager: NSObject {
    
    static let shared = OAuthManager()
    var oauthswift: OAuthSwift?
    lazy var internalWebViewController: OAuthGithubWebController = {
        let controller = OAuthGithubWebController()
        controller.view = NSView(frame: NSRect(x:0, y:0, width: 450, height: 600)) // needed if no nib or not loaded from storyboard
        controller.delegate = self
        controller.viewDidLoad() // allow WebViewController to use this ViewController as parent to be presented
        return controller
    }()
    
    // MARK: - Github Oauth and save Token
    func beginOauth(onlyPublicRepo: Bool){
        let scope = onlyPublicRepo ? GithubPublicAppScope : GithubAppScope
        //全局通知：将要登录
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.WillLogin, object:nil)

        let oauthswift = OAuth2Swift(
            consumerKey:    GithubAppClientId,
            consumerSecret: GithubAppClientSecret,
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType:   "code"
        )
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = getURLHandler(external: false)
        let state = generateState(withLength: 20)
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: GithubAppRedirectUrl)!, scope: scope, state: state,
            success: { credential, response, parameters in
                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.GetOAuthToken, object:nil)
                self.saveOauthToken(credential: credential, parameters: parameters)
        },
            failure: { error in
                print(error.description)
            }
        )
    }

    func getURLHandler(external: Bool) -> OAuthSwiftURLHandlerType {
        if external {
            return OAuthSwiftOpenURLExternally.sharedInstance
        } else {
            if internalWebViewController.parent == nil {
                AppDelegate.sharedInstance.mainController?.contentViewController?.addChild(self.internalWebViewController)
            }
            return internalWebViewController
        }
    }

    func saveOauthToken(credential: OAuthSwiftCredential, parameters: Dictionary<String, Any>) {
        
        let token = AppToken.shared
        token.access_token = String(format: "token %@", credential.oauthToken)
        if let token_type: String = parameters["token_type"] as? String {
            token.token_type = token_type
        }
        if let token_scope: String = parameters["scope"] as? String {
            token.scope = token_scope
        }
        if let token_expireDate: Date = credential.oauthTokenExpiresAt {
            token.token_expire_date = token_expireDate
        }
        
        print(credential.oauthToken)
        self.getUserinfo(token.access_token!)
    }
    
    // MARK: - 获取个人信息
    private func getUserinfo(_ token: String) {
        let provider = Provider.sharedProvider
        provider.request(.myInfo) { (result) -> Void in
            switch result {
            case let .success(response):
                do {
                    if let gitUser: ObjUser = Mapper<ObjUser>().map(JSONObject: try response.mapJSON()) {
                        ObjUser.saveUserInfo(gitUser)
                        self.didLogin()
                    } else {
                    }
                } catch {
                }
            case .failure:
                break
            }
        }
    }
    
    private func didLogin() {
        //全局通知：已经登录
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.DidLogin, object:nil)
        AnswerManager.logLogin(method: "Github", success: true, attributes: [:])
        BFWindowManager.shared.openMainWindow()
        BeeFunDBManager.shared.updateServerDB(first: true)
        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.GetUserInfo, object:nil)
        ObjUser.updateUserForBeeFun()
    }
    
    
}

// MARK: - OAuthWebViewControllerDelegate
extension OAuthManager: OAuthWebViewControllerDelegate {
    
    func oauthWebViewControllerWillAppear() {
        
    }
    func oauthWebViewControllerDidAppear() {
        
    }
    func oauthWebViewControllerWillDisappear() {
        
    }
    func oauthWebViewControllerDidDisappear() {
        // Ensure all listeners are removed if presented web view close
        oauthswift?.cancel()
    }
}
