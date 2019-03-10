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
        if let viewCont = panelController.contentViewController as? BFEditLangViewController {
            
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
    
    var favourLanguage: [BFLangModel]?
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allModel = BFLangModel()
        allModel.name = "All"
        allModel.color = "#000000"
        
        let unknownModel = BFLangModel()
        unknownModel.name = "Unknown"
        unknownModel.color = "#000000"
        favourLanguage = [allModel, unknownModel]
        
        languageArrayController.content = favourLanguage
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
            favourLanguage?[selectedRow] = language
            languageArrayController.content = favourLanguage
        }
    }
    
    @objc func addFavouriteLanguageDone(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            //            print(userInfo)
            guard let language: BFLangModel = userInfo["language"] as? BFLangModel
                else {return}
            favourLanguage?.append(language)
            languageArrayController.content = favourLanguage
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
        favourLanguage?.remove(at: selectedRow)
        languageArrayController.content = favourLanguage
    }
    
    @IBAction func doneEditAction(_ sender: Any) {
        self.view.window?.close()
        UserDefaults.standard.set(favourLanguage, forKey: BFUserDefaultKey.FavouriteLanguages)
    }
}
