//
//  BFStarViewController+TextField.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/4.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
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
            //TODO: 未匹配时，是否显示下面提示条，不显示注释下面这行。
            matches.append(textField.stringValue)
        }
        
        return matches
    }
    
    func textField(_ textField: NSTextField, didSelectItem item: String) {
        addTagToRepo()
        resignRepoTagTextFieldFirstResponder()
    }
}
