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
        //先按简拼  再按全拼  并保留上一次的match
        matches.append("weare")
        matches.append("good")
        matches.append("fine")
        matches.append("haha")

        if(matches.isEmpty)
        {
          
        }
        
        return matches
    }
    
    func textField(_ textField: NSTextField, didSelectItem item: String) {
        
    }
}

