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
        
        langSegment.target = self
        langSegment.action = #selector(clickLanguageSegment)
        reloadLangSegmentcontrol()
        
        
        webProgress.minValue = 0.0
        webProgress.maxValue = 1.0
        webProgress.usesThreadedAnimation = true
        webProgress.controlTint = NSControlTint.defaultControlTint
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

    }
    
    
    /// 选中segment语言
    @objc func clickLanguageSegment() {
        let sel = langSegment.selectedSegment
        let lang = langSegment.label(forSegment: sel)
        selectedLanguage = lang ?? "All"
        reloadTimaAndLanguage()
    }
    
    func reloadLangSegmentcontrol() {
        if let langs = BFLangPanelUtil.shared.favouriteLanguages() {
            langSegment.segmentCount = langs.count
            langSegment.selectedSegment = 0
            for (index, lan) in langs.enumerated() {
                langSegment.setLabel(lan.name ?? "All", forSegment: index)
            }
            if let lan = langSegment.label(forSegment: 0) {
                selectedLanguage = lan
            }
        }
        clickLanguageSegment()
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
        
        if let viewController = BFEditLangPanel.shared.panelController().contentViewController {
            presentAsSheet(viewController)
        }        
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
