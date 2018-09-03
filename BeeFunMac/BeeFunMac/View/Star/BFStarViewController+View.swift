//
//  BFStarViewController+Extension.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/10.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import WebKit

extension BFStarViewController: WKUIDelegate, WKNavigationDelegate, NSWindowDelegate {
    
    func starPageCustomAllView() {
        self.view.window?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResize(_:)), name: NSWindow.didResizeNotification, object: self.leftContentView.window)
        //tag管理区域
        starPageCustomTagManagerView()
        //左边repo区域
        starPageCustomLeftView()
        //右边webview区域
        starPageCustomRightView()
        starPageCustomRepoInfoArea()
        self.windowDidResize(Notification(name: Notification.Name(rawValue: "nil")))
        loadTheme()
        configMessageHud()
    }
    
    // MARK: - 管理Tag视图部分
    private func starPageCustomTagManagerView() {
        starButtonsReady()
        starTagRightMenuReady()
    }
    
    // MARK: - 左边视图: repo区域
    private func starPageCustomLeftView() {
        
        starPageCustomTagTableView()

        orderFilterView.delegate = self
        orderFilterView.setupIndicator()

        self.leftContentView.addSubview(tableViewBackground)
        self.leftContentView.addSubview(orderFilterView)
        self.leftContentView.addSubview(searchFilterView)

        starPageCustomLanguageView()
        starPageCustomRepoTableView()
        starPageCustomSearchField()
    }
    // MARK: - 右边视图： web视图
    private func starPageCustomRightView() {
        starPageConfigWebView()
        starPageCustomWebViewTools()
        starPageCustomToolsView()
    }
    
    func windowDidResize(_ notification: Notification) {
        print(notification)
        
        let width: CGFloat = 300
        let x = 0
        leftContentView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(x)
            make.leading.equalTo(0)
            make.width.equalTo(width)
            make.top.equalTo(0)
        }
        
        let orderH: CGFloat = 46-2
        let searchH: CGFloat = 97
        
        searchFilterView.snp.remakeConstraints { (make) in
            make.height.equalTo(searchH)
            make.leading.equalTo(x)
            make.width.equalTo(width)
            make.top.equalTo(self.leftContentView.top).offset(0)
        }
        
        let orderTop = searchH
        orderFilterView.snp.remakeConstraints { (make) in
            make.top.equalTo(orderTop)
            make.height.equalTo(orderH)
            make.leading.equalTo(x)
            make.width.equalTo(width)
        }
        
        let tableTop = searchH + orderH
//        print(orderFilterView.frame)
        
        tableViewBackground.snp.remakeConstraints { (make) in
            make.top.equalTo(tableTop)
            make.leading.equalTo(x)
            make.width.equalTo(width)
            make.bottom.equalTo(0)
        }
        
        let allTasgH = lineH * CGFloat(currentTagsOfLines)
        let toolsH: CGFloat = toolsViewHeight + allTasgH - lineH
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
        
        //重新布局Tags内部布局布局
        layoutWorkingTagsButton()
        repoTagsTextField.popOverWidth = repoTagsTextField.width-10
        
        self.repoWebView!.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.top.equalTo(self.rightContentView).offset(toolsH)
            make.trailing.equalTo(0)
        }
        
        scaleContentPage()
    }
    
}

extension BFStarViewController {
    func starPageCustomSearchField() {
        searchField.delegate = self
        searchFieldCell.cancelButtonCell?.target = self
        searchFieldCell.cancelButtonCell?.action = #selector(searchCancelButtonClick)
    }
}

// MARK: - Language
extension BFStarViewController {
    func starPageCustomLanguageView() {
        self.languagePop.target = self
        self.languagePop.action = #selector(handleSelectedLanguage(popBtn:))
        reloadLanguage()
    }
    
    func reloadLanguage() {
        self.languagePop.removeAllItems()
        self.languagePop.addItems(withTitles: self.languageAndNum)
    }
    
    
    /// 选中语言
    @objc func handleSelectedLanguage(popBtn: NSPopUpButton) {
        if let selTitle = popBtn.selectedItem?.title {
            print(selTitle)
            let index = popBtn.indexOfItem(withTitle: selTitle)
            if index < languageArr.count && index >= 0 {
                getRepoLanguageVar = languageArr[index]
                searchStarReposNow(allRefresh: true, scrollToTop: true)
            }

        }
    }
}

// MARK: - Order
extension BFStarViewController: StarOrderProtocol {
    
    /// 点击排序按钮：时间、star、name
    func didSelected(button: BFImageButton, order: StarOrderType) {
        ordertType = order
        searchStarReposNow(allRefresh: true, scrollToTop: true)
    }
}
