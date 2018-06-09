//
//  BFTextField.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/21.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

protocol BFTextFieldDelegate: class {
    func didBecomeFirstResponder(textField: BFTextField)
    func didResignFirstResponder(textField: BFTextField)
}

class BFTextField: NSTextField {

    open weak var responDelegate: BFTextFieldDelegate?
    
    override func becomeFirstResponder() -> Bool {
        let flag = super.becomeFirstResponder()
        if flag {
            self.responDelegate?.didBecomeFirstResponder(textField: self)
        }
        return flag
    }
    
    override func resignFirstResponder() -> Bool {
        let flag = super.resignFirstResponder()
        if flag {
            self.responDelegate?.didResignFirstResponder(textField: self)
        }
        return flag
    }
}
