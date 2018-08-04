//
//  BFStarViewController+TextField.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/4.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController: AutoCompleteTextFieldDelegate {
    
    func resignAllTextFieldFirstResponder() {
        resignNewTagTextFieldFirstResponder()
        resignRepoTagTextFieldFirstResponder()
        resignSearchTextFieldFirstResponder()
    }
    
    func resignNewTagTextFieldFirstResponder() {
       _ = newTagTextField.resignFirstResponder()
    }
    
    func resignRepoTagTextFieldFirstResponder() {
        _ = repoTagsTextField.resignFirstResponder()
        repoTagsTextField.stringValue = ""
        repoTagsTextField.autoCompletePopover?.close()
    }
    
    func resignSearchTextFieldFirstResponder() {
        searchField.resignFirstResponder()
    }
    
    // MARK: - Responder Delegate
    func didBecomeFirstResponder(textField: AutoCompleteTextField) {
        print("become first responder")
        if textField == repoTagsTextField {
            
        }
    }
    
    //进入输入框，先调用resign，后才是become
    func didResignFirstResponder(textField: AutoCompleteTextField) {
        print("resign first responder")
        
    }
}
