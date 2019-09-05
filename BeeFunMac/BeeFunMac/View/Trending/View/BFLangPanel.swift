//
//  BFLangPanel.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation
import ObjectMapper

// final 也就是说这个类或方法不希望被继承和重写，具体情况如下：
// （1）类或者方法的功能确实已经完备了（2）避免子类继承和修改造成危险（3）为了让父类中某些代码一定会执行
final class BFLangPanel {
    
    static let shared = BFLangPanel()
    
    func panelController() -> NSWindowController {
        let panelController = NSWindowController.instantiate(storyboard: "BFLangPanel")
        if (panelController.contentViewController as? BFLangViewController) != nil {
        }
        return panelController
    }
    
    func panelController(state: LangPanelState) -> NSWindowController {
        let panelController = NSWindowController.instantiate(storyboard: "BFLangPanel")
        if let viewCont = panelController.contentViewController as? BFLangViewController {
            viewCont.state = state
        }
        return panelController
    }
}

final class BFLangPanelUtil {
    
    static let shared = BFLangPanelUtil()
    var languages: [ [BFLangModel] ] = []
    var languageIndexs: [ String ] = []

    static let documentDirectory = BFPathManager.shared.localDocumentURL()!
    static let archiveURL = documentDirectory.appendingPathComponent("favouriteLanguage")
    
    /// 用户选择的喜欢语言
    func favouriteLanguages() -> [BFLangModel]? {
        NSKeyedUnarchiver.setClass(BFLangModel.self, forClassName: "BFLangModel")
        let fileM = FileManager.default
//        do  { try fileM.removeItem(at: BFLangPanelUtil.archiveURL) } catch { }
        if fileM.fileExists(atPath: BFLangPanelUtil.archiveURL.path) {
            if let array = NSKeyedUnarchiver.unarchiveObject(withFile: BFLangPanelUtil.archiveURL.path) as? [BFLangModel] {
                return array
            }
        }
        return nil
    }
    
    
    /// 保存用户选择的喜欢语言
    func saveFavouriteLanguages(languages: [BFLangModel]) -> Bool {
        NSKeyedArchiver.setClassName("BFLangModel", for: BFLangModel.self)
        let isScuessfulSave = NSKeyedArchiver.archiveRootObject(languages, toFile: BFLangPanelUtil.archiveURL.path)
        if !isScuessfulSave {
            print("failed to save favourite languages ...")
        }
        return isScuessfulSave
    }
    
    /// 返回全部语言
    func loadAllLanguage() {
        if let path = Bundle.main.path(forResource: "all_language", ofType: "json") {
            
            let allIndex = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                var allData: [BFLangModel] = [] //总数据

                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>  {
                    for (key, value) in jsonResult {
//                        print("\(key)")
                        if let model = Mapper<BFLangModel>().map(JSON: value as! Dictionary) {
                            model.name = key
                            allData.append(model)
                        }
                    }
                }
                
 
                for sectionIndex in allIndex {
                    let sectionArr: [BFLangModel] = allData.filter({ $0.name!.lowercased().hasPrefix(sectionIndex.lowercased()) })
                    if !sectionArr.isEmpty {
                        languageIndexs.append(sectionIndex)
                        languages.append(sectionArr)
                    }
                }
                
                //添加两种，一种是All，一种是Unknown
                let allModel = BFLangModel()
                allModel.name = "All"
                allModel.color = "#000000"
                
                let unknownModel = BFLangModel()
                unknownModel.name = "Unknown"
                unknownModel.color = "#000000"
                
                let sepModels = [allModel, unknownModel]
                languages.insert(sepModels, at: 0)
                languageIndexs.insert("#", at: 0)
                
//               print("log")
            } catch {
                // handle error
            }
        }
    }
}

final class BFLangWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        (self.window as! NSPanel).isFloatingPanel = false
        self.windowFrameAutosaveName = "All Language"
    }
}

enum LangPanelState: String {
    // 用户临时选择一种语言进行展示
    case SelectShowLanguage
    // 添加喜欢的语言
    case AddFavouriteLanguage
    // 编辑喜欢的语言
    case EditFavouriteLanguage
}

final class BFLangViewController: NSViewController {
    
    var searching: Bool = false
    @IBOutlet weak var langCollectionView: NSCollectionView!
    @IBOutlet weak var searchTextField: NSSearchField!
    @IBOutlet weak var searchTextFieldCell: NSSearchFieldCell!
    var state: LangPanelState = LangPanelState.SelectShowLanguage
    
    // 全量数据
    var languages = BFLangPanelUtil.shared.languages
    var languageIndexs = BFLangPanelUtil.shared.languageIndexs
    
    // 搜索数据
    var waitSelectionLanguages: [BFLangModel] = []
    
    override func viewWillAppear() {
        super.viewWillAppear()
        langCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.size = NSSize(width: 350, height: 560)
        view.wantsLayer = true
        
        langCollectionView.allowsMultipleSelection = false
        langCollectionView.delegate = self
        langCollectionView.dataSource = self
        //
        searchTextField.delegate = self
        searchTextFieldCell.cancelButtonCell?.target = self
        searchTextFieldCell.cancelButtonCell?.action = #selector(searchCancelButtonClick)
    }

}

extension BFLangViewController: NSSearchFieldDelegate {
    
    func controlTextDidBeginEditing(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchTextField {
//                print("controlTextDidBeginEditing search \(searchTextField.stringValue)")
            }
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchTextField {
//                print("controlTextDidChange search \(searchTextField.stringValue)")
                searching = !textfield.stringValue.isEmpty
                searchAllDataWithKey()
            }
        }
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if let textfield = obj.object as? NSTextField {
            if textfield == searchTextField {
//                print("controlTextDidEndEditing search \(searchTextField.stringValue)")
            }
        }
    }
    
    @objc func searchCancelButtonClick() {
        searching = false
        searchTextField.stringValue = ""
        waitSelectionLanguages.removeAll()
        langCollectionView.reloadData()
    }
    
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        searching = true
//        searchAllDataWithKey()
    }
    // 也会进入textDidChange
    func searchFieldDidEndSearching(_ sender: NSSearchField) {
        searching = false
    
    }
    
    func searchAllDataWithKey() {
        let key = searchTextField.stringValue.lowercased()
        if key == "" {
            searching = false
            langCollectionView.reloadData()
        }
        waitSelectionLanguages.removeAll()
        for section in languages {
            for model in section {
                if let lan = model.name, lan.lowercased().contains(key) {
                    waitSelectionLanguages.append(model)
                }
            }
        }
        langCollectionView.reloadData()
//        print(waitSelectionLanguages)
    }
    
}

extension BFLangViewController: NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if let selIndexPath = indexPaths.first {
            var language: BFLangModel? = nil
            if searching {
                language = waitSelectionLanguages[selIndexPath.item]
            } else {
                language = languages[selIndexPath.section][selIndexPath.item]
            }
            let userInfo: [String : Any] = ["language": language!, "state": state]
            switch state {
            case .SelectShowLanguage:
                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.SelectShowLanguage, object: nil, userInfo: userInfo)
            case .AddFavouriteLanguage:
                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.AddFavouriteLanguage, object: nil, userInfo: userInfo)
            case .EditFavouriteLanguage:
                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.EditFavouriteLanguage, object: nil, userInfo: userInfo)
            }
            view.window?.close()
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
        
    }
}

extension BFLangViewController: NSCollectionViewDataSource{
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if searching && waitSelectionLanguages.count > 0 {
            return 1
        }
        return languageIndexs.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching && waitSelectionLanguages.count > 0 {
            return waitSelectionLanguages.count
        }
        return languages[section].count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        // 4
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFLanguageViewItem"), for: indexPath)
        guard let collectionViewItem = item as? BFLanguageViewItem else {return item}
        
        // 5
        var language: BFLangModel? = nil
        if searching && waitSelectionLanguages.count > 0 {
            language = waitSelectionLanguages[indexPath.item]
        } else {
            language = languages[indexPath.section][indexPath.item]
        }
        if let lan = language {
            collectionViewItem.language = lan
        }
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {

        // 1
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BFLanguageHeaderView"), for: indexPath) as! BFLanguageHeaderView
        // 2
        let title = "\(languageIndexs[indexPath.section]) —— \(languages[indexPath.section].count) languages"
        view.title = title
        return view
    }

}

// 头部的大小
extension BFLangViewController : NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout:
        NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        if searching && waitSelectionLanguages.count > 0 {
            return NSSize.zero
        }
        return NSSize(width: 325, height: 28)
    }
}
