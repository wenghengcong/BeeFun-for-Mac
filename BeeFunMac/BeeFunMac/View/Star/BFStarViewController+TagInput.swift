//
//  BFStarViewController+Tag.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/18.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import FlatButton
import ObjectMapper

extension BFStarViewController: NSTextFieldDelegate {
    
    func starPageCustomToolsView() {
    
        self.toolsView.backgroundColor = NSColor.white
        self.toolsView.layer?.masksToBounds = false
        
        self.rightContentView.addSubview(self.toolsView, positioned: .above, relativeTo: nil)
        
        //下面是通知方式来监察text change
        //        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notification:)), name: NSControl.textDidChangeNotification, object: nil)
        starPageCustomTagsContainer()
    }
    
    func starPageCustomTagsContainer() {
        
        //TEST:
//        workingTags = ["UI", "Swift", "iOS Developerment", "Objectivie-C", "Future", "ME", "Tools", "Quick", "Books", "awesome", "Guide", "View" ,"UI", "Swift", "iOS Developerment", "Objectivie-C", "Future", "ME", "Tools", "Quick", "Books", "awesome", "Guide", "View"]
        
        addTagContainView.backgroundColor = NSColor.white
        addTagContainView.borderWidth = 1.0
        addTagContainView.borderColor = NSColor.lineBackgroundColor
        addTagContainView.layer?.masksToBounds = false
        
        addTagContainView.radius = 2.0
        toolsView.addSubview(addTagContainView)
        
        workingTagsView.backgroundColor = NSColor.green
        addTagContainView.addSubview(workingTagsView)
        //首次加载toolsView区域
        layoutTagsContainView()
        addInputRepoTagField()
    }
    
    // MARK: - Add subview
    func addWorkingTagsButtons() {
        
        workingTagsButtongs.removeAll()
        for subview in workingTagsView.subviews {
            if subview is NSButton {
                subview.removeFromSuperview()
            }
        }
        for (index, tag) in workingTags.enumerated() {
            let tagB = NSButton(title: tag.name!, target: self, action: #selector(clickWorkingTagsButton(sender:)))
            tagB.tag = index
            tagB.font = NSFont.bfSystemFont(ofSize: 11.0)
//            tagB.bezelStyle = .regularSquare
            tagB.setButtonType(.pushOnPushOff)
            tagB.tag = index
            workingTagsButtongs.append(tagB)
            workingTagsView.addSubview(tagB)
        }
    }
    
    func addInputRepoTagField() {
        if !workingTagsView.subviews.contains(inputRepoTagField) {
            let tagStyle = NSMutableParagraphStyle()
            tagStyle.alignment = .left
            let tagAttrbute = [NSAttributedStringKey.foregroundColor : NSColor.textViewPlaceholderTextColor, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 11.0), NSAttributedStringKey.paragraphStyle : tagStyle] as [NSAttributedStringKey : Any]
            inputRepoTagField.placeholderAttributedString = NSAttributedString(string: "Add new tag", attributes: tagAttrbute)
            inputRepoTagField.tag = inputNewTagFieldTag
            inputRepoTagField.usesSingleLineMode = true
//            inputRepoTagField.delegate = self
            inputRepoTagField.responDelegate = self
            inputRepoTagField.tableViewDelegate = self
            workingTagsView.addSubview(inputRepoTagField)
        }
    }
    
    // MARK: - layout
    
    //重新布局repo tags 列表
    func reLayoutWorkingLayout() {
        addWorkingTagsButtons()
        layoutWorkingTagsButton()
//        self.windowDidResize(Notification(name: Notification.Name(rawValue: "nil")))
        reLayoutRightContentViewAfterWorkingTagsChange()
    }
    
    /// Tag更改后，重新绘制右边视图布局
    func reLayoutRightContentViewAfterWorkingTagsChange() {
        let allTasgH = lineH * CGFloat(currentTagsOfLines)
        let toolsH: CGFloat = 65 + allTasgH - lineH
        toolsView.backgroundColor = NSColor.white
        toolsView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.rightContentView).offset(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(toolsH)
        }
        
        toolsViewSepLine.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(1)
        }
                
        self.repoWebView!.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(self.rightContentView).offset(toolsH)
            make.trailing.equalTo(0)
        }
    }
    
    func layoutWorkingTagsButton() {
        //包含inputNewTagField的布局
        let width = tagsContainViewWidth()
        let btnH: CGFloat = 25
        let btnInsideXMargin:CGFloat = 0.0
        let firstColumnX: CGFloat = 3.0
        
        var lineTagsWidth = firstColumnX
        currentTagsOfLines = 1
        if workingTagsButtongs.count == 0 {
            currentTagsOfLines = 1
        } else {
            for button in workingTagsButtongs {
                button.sizeToFit()
                let nowW = button.width
                lineTagsWidth += nowW + btnInsideXMargin
                //10是tag右边距
                if lineTagsWidth + 10 > width {
                    currentTagsOfLines += 1
                    lineTagsWidth = firstColumnX
                }
                print("title: \(button.title) width: \(nowW) allWidth: \(lineTagsWidth) allLine: \(currentTagsOfLines)")
            }
            
            //为inputRepoTagField单独开一行
            currentTagsOfLines += 1
        }

        let allTasgH = lineH * CGFloat(currentTagsOfLines)
        workingTagsView.frame = CGRect(x: 0, y: 0, width: width, height: allTasgH)
        
        let containX: CGFloat = addTagContainLeftMargin
        let containY: CGFloat = 5.0
        addTagContainView.frame = CGRect(x: containX, y: containY, width: width, height: allTasgH)
        
        let firstRowY: CGFloat = 0
        for (index, button) in workingTagsButtongs.enumerated() {
            var lastF = CGRect.zero
            var nowX: CGFloat = firstColumnX
            var nowY: CGFloat = firstRowY
            if index != 0 {
                lastF = workingTagsButtongs[index-1].frame
                nowY = lastF.minY
                nowX = lastF.maxX+btnInsideXMargin
            }
            
            button.sizeToFit()
            let nowW = button.width
            let nextX = nowX + nowW
            if nextX > width {
                nowY = nowY+lineH
                nowX = firstColumnX
            }
            let nowF = CGRect(x: nowX, y: nowY, width: nowW, height: btnH)
            button.frame = nowF
        }
        
        let fieldH: CGFloat = 18
        var lastBtnY = (lineH-fieldH)/2.0
        if let lastButton = workingTagsButtongs.last {
            lastBtnY = lastButton.frame.minY+1.0
        }
    
        let fieldX = firstColumnX
        var fieldY = lastBtnY + lineH
        if workingTagsButtongs.count == 0 {
            fieldY = lastBtnY
        }
        inputRepoTagField.frame = CGRect(x: fieldX, y: fieldY, width: width-5, height: fieldH)
    }
    
    //left距离左边边距，right距离右边边距
    func tagsContainViewWidth() -> CGFloat {
        //默认为左边离tag图标距离9+25+7，右边距10
        return toolsView.width-addTagContainLeftMargin-10
    }
    
    func layoutTagsContainView() {
        let allTasgH = lineH * CGFloat(currentTagsOfLines)
        let containW = tagsContainViewWidth()
        let containX: CGFloat = addTagContainLeftMargin
        let containY: CGFloat = 5.0
        addTagContainView.frame = CGRect(x: containX, y: containY, width: containW, height: allTasgH)
        workingTagsView.frame = addTagContainView.bounds
    }
    
    // MARK: - Action
    @objc func clickAllTagsButton(sender: NSButton) {
        
    }
    
    /*自动完成
     func textField(_ textField: NSTextField, textView: NSTextView, candidatesForSelectedRange selectedRange: NSRange) -> [Any]?
     
     
     func textField(_ textField: NSTextField, textView: NSTextView, candidates: [NSTextCheckingResult], forSelectedRange selectedRange: NSRange) -> [NSTextCheckingResult]
     
     
     func textField(_ textField: NSTextField, textView: NSTextView, shouldSelectCandidateAt index: Int) -> Bool
     
     
     @objc func textDidChange(notification: NSNotification) {
     print(self.tagsTextField.stringValue)
     }
     */
    

    // MARK: - Text field delegate callback
    // 点击搜索框时，输入字符后，controlTextDidBeginEditing (此时字符还未改变)-> controlTextDidChange（字符已改变） ->searchFieldDidStartSearching (字符以改变)
    override func controlTextDidBeginEditing(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchField {
                print("controlTextDidBeginEditing search \(self.searchField.stringValue)")
            } else if textfield == inputRepoTagField {
                print("controlTextDidBeginEditing input new tag \(self.inputRepoTagField.stringValue)")
            }
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchField {
                print("controlTextDidChange search \(self.searchField.stringValue)")
                //TODO: 评估下是否需要每次在输入文字时拿到最新的数据
                searchStarReposNow(allRefresh: true, scrollToTop: true)
            } else if textfield == inputRepoTagField {
                print("controlTextDidChange input new tag \(self.inputRepoTagField.stringValue)")
                //TODO:
                inputTagsTipArr = ["Good", "Fine", "hahaha"]
//                tagTipsTableShow()
            }
        }
    }
    
    //离开输入框，调用该方法
    //搜索框，右边取消按钮：调用controlTextDidEndEditing->controlTextDidBeginEditing->searchFieldDidEndSearching->controlTextDidChange->controlTextDidEndEditing
    override func controlTextDidEndEditing(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchField {
                print("controlTextDidEndEditing search \(self.searchField.stringValue)")
            } else if textfield == inputRepoTagField {
                print("controlTextDidEndEditing input new tag \(self.inputRepoTagField.stringValue)")
            }
        }
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
                if textfield == searchField {
                    searchStarReposNow(allRefresh: true, scrollToTop: true)
                } else if textfield == inputRepoTagField {
                    //TODO: 在AutoCompleteTextField中动作被截获，所以注释掉
//                    addTagToRepo()
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
    
    // MARK: - Add tag to repo
    func addTagToRepo() {
        
        if inputRepoTagField.stringValue.isBlank {
            //TODO: 弹框
            return
        }
        //增加tag到workingTags数组
        if inputRepoTagField.stringValue.trimmed.length > 0 {
            addTagToWorkingArea(tag: inputRepoTagField.stringValue.trimmed)
        }
        
        updateRepoTagNetwork()
        inputRepoTagField.stringValue = ""
        self.view.window?.makeFirstResponder(inputRepoTagField)
    }
        
    // MARK: - Remove Tag From Repo
    /// 点击输入tag区域中的tag按钮，显示删除按钮
    @objc func clickWorkingTagsButton(sender: NSButton) {
        let delImage = NSImage.init(named: NSImage.Name(rawValue: "tag_delete"))
        if sender.state == .on {
            let delButton = NSButton()
            delButton.bezelStyle = .texturedSquare
            delButton.setButtonType(.momentaryLight)
            delButton.alphaValue = 0.8
            delButton.backgroundColor = NSColor.clear
            delButton.image = delImage
            delButton.alternateImage = delImage
            delButton.tag = sender.tag
            delButton.target = self
            delButton.action = #selector(deleteTagFromRepo(sender:))
            let width: CGFloat = 18
            let height: CGFloat = 10
            let x: CGFloat = sender.width-width+2
            let y: CGFloat = 0
            delButton.frame = CGRect(x: x, y: y, width: width, height: height)
            sender.addSubview(delButton)
        } else {
            for subview in sender.subviews {
                if subview.isKind(of: NSButton.self) {
                    let button: NSButton = subview as! NSButton
                    if  button.image! == delImage {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    @objc func deleteTagFromRepo(sender: NSButton) {
        let index = sender.tag
        //1. 视图中移除
        workingTags.remove(at: index)
        reLayoutWorkingLayout()
        
        //2. 更新repo的tag
        updateRepoTagNetwork()
    }
    
}

// MARK: - Responder Delegate
extension BFStarViewController: AutoCompleteTextFieldDelegate {
    func didBecomeFirstResponder(textField: AutoCompleteTextField) {
        print("become first responder")
        if textField == inputRepoTagField {
            
        }
    }
    
    //进入输入框，先调用resign，后才是become
    func didResignFirstResponder(textField: AutoCompleteTextField) {
        print("resign first responder")

    }
}

extension BFStarViewController {
    func addTagToWorkingArea(tag: String) {
        let newTag = ObjTag()
        newTag.name = tag
        
        var has = false
        for tagObj in workingTags {
            if tagObj.name == newTag.name {
                has = true
            }
        }
        if !has {
            workingTags.append(newTag)
        }
    }
}
