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
    var loadingHud = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        configView()
        configHud()
        addNoti()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        OAuthManager.shared.beginOauth()
    }
    
    func configView() {
        self.signInBtn.backgroundColor = NSColor.clear
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        let dic = [NSAttributedStringKey.foregroundColor : NSColor.cpBlueLinkColor, NSAttributedStringKey.paragraphStyle : pstyle] as [NSAttributedStringKey : Any]
        self.officeWebBtn.attributedTitle = NSAttributedString(string: BFWebsiteURL.AppOfficeSite, attributes: dic)
        
        let width: CGFloat = 260
        let height: CGFloat = 320
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

extension BFLoginController: MBProgressHUDDelegate {
    
    @objc func getTokenSuccessful() {
        signInBtn.isHidden = true
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

