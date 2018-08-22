//
//  BFStarViewController+Hud.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/8/22.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    func configMessageHud() {
        messageHud = MBProgressHUD.init(view: self.view)
        messageHud.mode = MBProgressHUDModeText
        messageHud.delegate = self
        messageHud.color = NSColor.hex("16191c", alpha: 0.6)    //背景色
        messageHud.labelFont = NSFont.bfBoldSystemFont(ofSize: 18.0)
        messageHud.labelColor = NSColor.white
        messageHud.removeFromSuperViewOnHide = true
    }
    
    func showHudAutoHide(message: String, delay: TimeInterval) {
        messageHud.labelText = message
        self.view.addSubview(messageHud)
        messageHud.show(true)
        messageHud.hide(true, afterDelay: delay)
    }
    
    func showHud(message: String) {
        messageHud.labelText = message
        self.view.addSubview(messageHud)
        messageHud.show(true)
    }
    
    func hideHud() {
        messageHud.hide(true)
    }
    
    func hideHud(delay: TimeInterval) {
        messageHud.hide(true, afterDelay: delay)
    }
}

extension BFStarViewController: MBProgressHUDDelegate {
    
    public func hudWasHidden(_ hud: MBProgressHUD!) {
        messageHud.removeFromSuperview()
    }
}
