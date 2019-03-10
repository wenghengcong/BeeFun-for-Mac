//
//  BFExploreController+View.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/3.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFExploreController {

    
    func setupView() {
        setupCollectionView()
        setupSelectedTimeAndLanguagePopup()
    }
    
    
    override func viewDidLayout() {
        
        super.viewDidLayout()
        view.backgColor = NSColor.xyGrayDarkBlack
        
        navigationTitleLabel.textColor = NSColor.xyBlackDarkWhite
        navigationSepLine.backgColor = NSColor.xyBlueDarkWhite
        
        detailTitleLabel.textColor = NSColor.xyBlackDarkWhite
        detailSepLine.backgColor = NSColor.xyBlueDarkWhite
        //        navAndDetailSepLine.backgColor = NSColor.thDayBlue
        
        navigationContainView.backgColor = NSColor.xyGrayDarkBlackBackground
        navigationScrollView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        navigationCollectionView.backgColor = NSColor.xyGrayDarkBlackBackground
        navigationClipView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        detailContailView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailScrollView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailCollectionView.backgColor = NSColor.xyGrayDarkBlackBackground
        detailClipView.backgColor = NSColor.xyGrayDarkBlackBackground
        
        setupLangSegmentcontrol()
    }
    
    func setupLangSegmentcontrol() {
        
        let arr = ["swift", "c", "c++", "java"]
        langSegment.segmentCount = arr.count
        langSegment.selectedSegment = 0
        for (index, lan) in arr.enumerated() {
            langSegment.setLabel(lan, forSegment: index)
        }
    }
    
    func setupSelectedTimeAndLanguagePopup() {
        languageSelectedButton.target = self
        languageSelectedButton.action = #selector(handleSelectedLanguage(button:))
    
        timePopup.target = self
        timePopup.action = #selector(handleSelectedTime(popBtn:))
        
        editLanguage.target = self
        editLanguage.action = #selector(showEditLanguageWindow(button:))
    }
    
    @objc func showEditLanguageWindow(button: NSButton) {
        // 下面代码也可以弹窗model window
//        let wc = NSWindowController()
//        let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 400), styleMask: .borderless, backing: .buffered, defer: true)
//        wc.window = window
//        if let wind = wc.window {
//            NSApp.runModal(for: wind)
//            NSApp.beginModalSession(for: wind)
//        }
        
        BFEditLangPanel.shared.panelController().showWindow(button)
    }
    
    @objc func handleSelectedTime(popBtn: NSPopUpButton) {
        if let _ = popBtn.selectedItem?.title {
            reloadTimaAndLanguage()
        }
    }
    
    /// 选中语言
    @objc func handleSelectedLanguage(button: NSButton) {
        BFLangPanel.shared.panelController(state: LangPanelState.SelectShowLanguage).showWindow(button)
    }
    
}
