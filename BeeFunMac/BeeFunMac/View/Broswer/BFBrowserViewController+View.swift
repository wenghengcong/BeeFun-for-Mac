//
//  BFBrowserViewController+View.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/10.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFBrowserViewController {
    
    func setupWebsiteInputTextField() {
        
        websiteInputTextField.delegate = self
    }
    
    //回车后，调用：doCommandBy-> searchFieldDidEndSearching
    //点击输入框，回到搜索，noop方法调用
    //删除键，doCommandBy-> controlTextDidBeginEditing->controlTextDidChange
    //删除键，doCommandBy-> searchFieldDidEndSearching(删除后无字符)->controlTextDidChange->controlTextDidEndEditing
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        let textfield = control as? NSTextField
        //取消某些按鍵的功能，只要在返回true就能取消
        var result = false
        let selectorString = NSStringFromSelector(commandSelector)
        print("text field selector: \(selectorString)")
        //回车：insertNewline:
        //删除: deleteBackward
        if commandSelector == #selector(insertNewline(_:)) {
            if let modifierFlags = NSApplication.shared.currentEvent?.modifierFlags, (modifierFlags.rawValue & NSEvent.ModifierFlags.shift.rawValue) != 0 {
                print("Shift-Enter detected.")
            } else {
                print("Enter detected.")
                if textfield == websiteInputTextField {
                    loadWebsite(websiteInputTextField.stringValue)
                }
            }
            result = true
        } else if( commandSelector == #selector(moveUp(_:)) ){
            result = true
        } else if( commandSelector ==  #selector(moveDown(_:) )){
            result = true
        }
        return result
    }
}
