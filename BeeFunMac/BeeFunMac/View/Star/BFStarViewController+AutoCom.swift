//
//  BFStarViewController+AutoCom.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/6/13.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

// MARK: - AutoCompleteTableViewDelegate
extension BFStarViewController: AutoCompleteTableViewDelegate{
    func textField(_ textField: NSTextField, completions words: [String], forPartialWordRange charRange: NSRange, indexOfSelectedItem index: Int) -> [String] {
        var matches = [String]()
        
        for tag in allTags {
            if let tagName = tag.name {
                if let _ = tagName.range(of: textField.stringValue, options: NSString.CompareOptions.anchored)
                {
                    matches.append(tagName)
                }
            }
        }

        if(matches.isEmpty)
        {
            for tag in allTags {
                if let tagName = tag.name {
                    matches.append(tagName)
                }
            }
        }
        
        return matches
    }
    
    func textField(_ textField: NSTextField, didSelectItem item: String) {
        addTagToRepo()
        inputRepoTagField.stringValue = ""
    }
}

