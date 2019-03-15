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
    var observer: NSKeyValueObservation?
    
    @IBOutlet weak var mainMenu: NSMenu!
    
    class var sharedInstance: AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //关闭输出
        setenv("CFNETWORK_DIAGNOSTICS", "0", 1);
        
//        BFDarkModeManager.shared.setupDarkMode(aNotification)
        
        if #available(OSX 10.14, *) {
            observer = NSApp.observe(\.effectiveAppearance) { (app, _) in
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name.BeeFun.appAppearanceChanged, object: app)
            }
        } else {
            // Fallback on earlier versions
        }
        
        // oauth: listen to scheme url
        BFConfig.shared.getConfig()
        NSAppleEventManager.shared().setEventHandler(self, andSelector:#selector(AppDelegate.handleGetURL(event:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        BFMonitor.shared.start()
//        BFiCloudManager.shared.startiCloudQuery()
        UserManager.shared.userSignIn()
        BeeFunDBManager.shared.updateServerDB(first: false)
        
        // 加载所有语言
        BFLangPanelUtil.shared.loadAllLanguage()
        
        // 菜单栏app
        MenuAppManage.shared.setupMainMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        observer?.invalidate()
    }
    
    //Dock Menu
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
//        return BFDockMenuManager.shared.dockMenu()
        let menu = NSMenu()
        let menuItem = NSMenuItem(title: "BeeFun", action: #selector(openBeeFunMainWindow), keyEquivalent: "O")
        menu.addItem(menuItem)
        return menu
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        //login
        print(urls)
    }
    
    /// 点击dock 重新打开显示窗口
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        //方法一：
//        mainController?.window?.makeKeyAndOrderFront(self)
        //方法二：
        if !flag{
            for window in sender.windows {
                if !BFPopOverUtils.isCustomPopOver(window: window) {
                    window.makeKeyAndOrderFront(self)
                }
            }
        }
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

extension AppDelegate {
   @objc func openBeeFunMainWindow() {
        mainController?.window?.makeKeyAndOrderFront(self)
    }
}
