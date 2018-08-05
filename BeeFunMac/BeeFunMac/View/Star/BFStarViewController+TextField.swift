//
//  BFStarViewController+TextField.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/4.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController: AutoCompleteTextFieldDelegate {
    
    // MARK: - Become first responder
    func becomeNewTagTextFieldFirstResponder() {
        _ = newTagTextField.becomeFirstResponder()
    }
    
    func becomeRepoTagsTextFieldFirstResponder() {
        _ = repoTagsTextField.becomeFirstResponder()
    }
    
    func becomeSearchTextFieldFirstResponder() {
        searchField.becomeFirstResponder()
    }
    
    // MARK: - Resign
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

// MARK: - AutoCompleteTableViewDelegate
extension BFStarViewController: AutoCompleteTableViewDelegate{
    
    func textField(_ textField: NSTextField, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: Int) -> [String] {
        var matches = [String]()
        
        for tag in allTags {
            if let tagName = tag.name {
                if let _ = tagName.lowercased().range(of: textField.stringValue.lowercased(), options: NSString.CompareOptions.anchored)
                {
                    hasTagsMatched = true
                    matches.append(tagName)
                }
            }
        }
        
        if(matches.isEmpty)
        {
            hasTagsMatched = false
            matches.append(textField.stringValue)
        }
        
        return matches
    }
    
    func textField(_ textField: NSTextField, didSelectItem item: String) {
        addTagToRepo()
        repoTagsTextField.stringValue = ""
    }
}
