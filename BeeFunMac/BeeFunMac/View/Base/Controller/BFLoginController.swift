//
//  BFLoginController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/23.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFLoginController: BFBaseViewController {

    @IBOutlet weak var signInBtn: NSButton!
    @IBOutlet weak var officeWebBtn: NSButton!
    @IBOutlet weak var signInPrivateBtn: NSButton!
    
    var loadingHud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        configView()
        configHud()
        addNoti()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        BFWindowManager.shared.closeLoginWindow()
        OAuthManager.shared.beginOauth(onlyPublicRepo: false)
    }
    
    @IBAction func loginPrivateAction(_ sender: Any) {
        BFWindowManager.shared.closeLoginWindow()
        OAuthManager.shared.beginOauth(onlyPublicRepo: true)
    }
    
    func configView() {
        
        signInBtn.toolTip = "BeeFun will have access to your public repositories,beside private!"
        signInPrivateBtn.toolTip = "BeeFun will have access to your private repositories"
    
        signInBtn.isBordered = false
        signInBtn.wantsLayer = true
        signInBtn.layer?.backgroundColor = NSColor.xyWhiteDarkBlack.cgColor
        signInBtn.setTitleTextColor(color: NSColor.xyBlackDarkWhite)
        signInBtn.layer?.cornerRadius = 2.0
        
        signInPrivateBtn.isBordered = false
        signInPrivateBtn.wantsLayer = true
        signInPrivateBtn.layer?.backgroundColor = NSColor.xyWhiteDarkBlack.cgColor
        signInPrivateBtn.setTitleTextColor(color: NSColor.xyBlackDarkWhite)
        signInPrivateBtn.layer?.cornerRadius = 2.0
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        let dic = [NSAttributedString.Key.foregroundColor : NSColor.cpBlueLinkColor, NSAttributedString.Key.paragraphStyle : pstyle] as [NSAttributedString.Key : Any]
        self.officeWebBtn.attributedTitle = NSAttributedString(string: "@2017-2019 54nemo.com", attributes: dic)
        
        
        let width: CGFloat = 260
        let height: CGFloat = 348
        self.view.bounds = NSRect(x: 0, y: 0, width: width, height: height)
        self.view.window?.center()
    }
    
    func configHud() {
        loadingHud = MBProgressHUD.init(view: self.view)
        loadingHud.mode = MBProgressHUDModeIndeterminate
        loadingHud.delegate = self
        loadingHud.removeFromSuperViewOnHide = true
        loadingHud.labelText = "Loading..."
    }
    
    func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTokenSuccessful), name: NSNotification.Name.BeeFun.GetOAuthToken, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getUserInfoSuccessful), name: NSNotification.Name.BeeFun.GetUserInfo, object: nil)
    }
    
    @IBAction func oepnOfficeWebsite(_ sender: Any) {
        BFJumpWebStie.shared.jump(BFWebsiteURL.AppOfficeSite)
    }
}

extension BFLoginController: NSPopoverDelegate {
    
    // MARK: - Popover Delegate
    func popoverShouldDetach(_ popover: NSPopover) -> Bool {
        return true
    }
    
    func popoverDidShow(_ notification: Notification) {
        
    }
    
    func popoverDidClose(_ notification: Notification) {
        let closeReason = notification.userInfo![NSPopover.closeReasonUserInfoKey] as! String
        if (closeReason == NSPopover.CloseReason.standard.rawValue) {
            
        }
    }
}


extension BFLoginController: MBProgressHUDDelegate {
    
    @objc func getTokenSuccessful() {
//        signInBtn.isHidden = true
        self.view.addSubview(loadingHud)
        loadingHud.show(true)
    }
    
    @objc func getUserInfoSuccessful() {
        loadingHud.hide(true)
    }
    
    public func hudWasHidden(_ hud: MBProgressHUD!) {
        loadingHud.removeFromSuperview()
    }
}

