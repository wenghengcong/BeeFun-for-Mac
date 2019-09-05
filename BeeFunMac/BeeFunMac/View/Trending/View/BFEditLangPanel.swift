//
//  BFEditLangPanel.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/9.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

final class BFEditLangPanel {
    
    static let shared = BFEditLangPanel()
    
    func panelController() -> NSWindowController {
        let panelController = NSWindowController.instantiate(storyboard: "BFEditLangPanel")
        if (panelController.contentViewController as? BFEditLangViewController) != nil {
            
        }
        return panelController
    }
}


final class BFEditLangWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
//        (self.window as! NSPanel).isFloatingPanel = false
        self.windowFrameAutosaveName = "Favourite Language"
    }
}

final class BFEditLangViewController: NSViewController {

    @IBOutlet var languageArrayController: NSArrayController!
    @IBOutlet weak var faviourLangTableView: NSTableView!
    @IBOutlet weak var addLanButton: NSButton!
    @IBOutlet weak var delLanButton: NSButton!
    @IBOutlet weak var tipsLabel: NSTextField!
    
    var favourLanguage: [BFLangModel] = []
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipsLabel.isHidden = true
        loadUserFavouriteLanguages()
        faviourLangTableView.doubleAction = #selector(doubleEditLanguage)
        NotificationCenter.default.addObserver(self, selector: #selector(addFavouriteLanguageDone(_:)), name: Notification.Name.BeeFun.AddFavouriteLanguage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editFavouriteLanguageDone(_:)), name: Notification.Name.BeeFun.EditFavouriteLanguage, object: nil)
    }
    
    // 处理通知
    @objc func editFavouriteLanguageDone(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            guard let selectedRow = faviourLangTableView?.selectedRow, selectedRow != -1 else { return }
            guard let language: BFLangModel = userInfo["language"] as? BFLangModel
                else {return}
            if selectedRow < favourLanguage.count {
                favourLanguage[selectedRow] = language
                languageArrayController.content = favourLanguage
            }
        }
    }
    
    @objc func addFavouriteLanguageDone(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            //            print(userInfo)
            guard let language: BFLangModel = userInfo["language"] as? BFLangModel
                else {return}
            favourLanguage.append(language)
            languageArrayController.content = favourLanguage
            showTips()
        }
    }
        
    @objc func doubleEditLanguage() {
        BFLangPanel.shared.panelController(state: .EditFavouriteLanguage).showWindow(nil)
//        if let viewController = BFLangPanel.shared.panelController(state: .EditFavouriteLanguage).contentViewController {
//            presentAsSheet(viewController)
//        }
    }
    
    @IBAction func addLanAction(_ sender: Any) {
        // WARN: 让viewcontroller变成modal展示
        BFLangPanel.shared.panelController(state: .AddFavouriteLanguage).showWindow(sender)
//        if let viewController = BFLangPanel.shared.panelController(state: .AddFavouriteLanguage).contentViewController {
//            presentAsSheet(viewController)
//        }
    }
    
    @IBAction func delLanAction(_ sender: Any) {
        guard let selectedRow = faviourLangTableView?.selectedRow, selectedRow != -1 else { return }
        favourLanguage.remove(at: selectedRow)
        languageArrayController.content = favourLanguage
        showTips()
    }
    
    @IBAction func doneEditAction(_ sender: Any) {
        saveUserFavouriteLanguages()
    }
    
    func loadUserFavouriteLanguages() {
        if let langs = BFLangPanelUtil.shared.favouriteLanguages() {
            favourLanguage = langs
        }
        
        if favourLanguage.isEmpty {
            let allModel = BFLangModel()
            allModel.name = "All"
            allModel.color = "#000000"
            favourLanguage = [allModel]
        }
        
        languageArrayController.content = favourLanguage
    }

    func saveUserFavouriteLanguages() {
        showTips()
        if favourLanguage.isEmpty {
            
        } else {
            let _ = BFLangPanelUtil.shared.saveFavouriteLanguages(languages: favourLanguage)
            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.DoneFavouriteLanguage, object: nil, userInfo: nil)
            view.window?.close()
        }
    }
    
    func showTips() {
        tipsLabel.isHidden = validFavouriteLanguages()
    }
    
    /// 喜爱语言的数目校验，1-4个
    func validFavouriteLanguages() -> Bool {
        var valid = false
        if (favourLanguage.count <= 4)  && (favourLanguage.count >= 1) {
            valid = true
        }
        return valid
    }
    
}
