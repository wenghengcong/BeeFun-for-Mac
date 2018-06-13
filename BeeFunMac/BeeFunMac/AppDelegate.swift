//
//  AppDelegate.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/27.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import OAuthSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainController:BFWindowController?
    @IBOutlet weak var mainMenu: NSMenu!
    
    class var sharedInstance: AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // oauth: listen to scheme url
        NSAppleEventManager.shared().setEventHandler(self, andSelector:#selector(AppDelegate.handleGetURL(event:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        BFMonitor.shared.start()
//        BFiCloudManager.shared.startiCloudQuery()
        UserManager.shared.userSignIn()
        //TODO: 上线打开，现在注释
//        BeeFunDBManager.shared.updateBeeFunDBFromGithub()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        //login
        print(urls)
    }
    
    /// 点击dock 重新打开显示窗口
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        mainController?.showWindow(self)
        return true
    }
    
    /// 关闭后不杀掉应用程序
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    
    /// Menu按钮动作
    @IBAction func openMenuItem(_ item: NSMenuItem) {
        BFMenuManager.shared.openMenuItem(item, menu: self.mainMenu)
    }
}

// MARK: - Oauth URL处理
extension AppDelegate {

    @objc func handleGetURL(event: NSAppleEventDescriptor!, withReplyEvent: NSAppleEventDescriptor!) {
        if let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue, let url = URL(string: urlString) {
            applicationHandle(url: url)
        }
    }
    
    func applicationHandle(url: URL) {
        if (url.host == AppOfficeShortSite) {
            OAuthSwift.handle(url: url)
        } else {
            // Google provider is the only one wuth your.bundle.id url schema.
            OAuthSwift.handle(url: url)
        }
    }
}