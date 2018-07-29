//
//  SyncPreferenceController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/1/25.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import MASPreferences

class SyncPreferenceController:NSViewController {
    
    @IBOutlet weak var syncTimeIntervalPopButton: NSPopUpButton!
    
    @IBOutlet weak var syncNowButton: NSButton!
    @IBOutlet weak var restoreDataButton: NSButton!
    
    
    init() {
        super.init(nibName: NSNib.Name(rawValue: "SyncPreferenceController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        loadSettings()
    }
    
    private func configView() {
        
        self.syncTimeIntervalPopButton.target = self
        self.syncTimeIntervalPopButton.action = #selector(handleSelectedTime(popBtn:))
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = .center
        let syncDic = [NSAttributedStringKey.foregroundColor: NSColor.black, NSAttributedStringKey.paragraphStyle: paraStyle]
        self.syncNowButton.attributedTitle = NSAttributedString(string: "Sync Now", attributes: syncDic)
        
        let restoreDic = [NSAttributedStringKey.foregroundColor: NSColor.bfRedColor, NSAttributedStringKey.paragraphStyle: paraStyle]
        self.restoreDataButton.attributedTitle = NSAttributedString(string: "Restore", attributes: restoreDic)
    
    }
    
    func loadSettings() {
        self.syncTimeIntervalPopButton.selectItem(withTitle: syncTimeInterval)
    }
    
    @objc func handleSelectedTime(popBtn: NSPopUpButton) {
        if let selTitle = popBtn.selectedItem?.title {
            print(selTitle)
            syncTimeInterval = selTitle
        }
    }
    
    var syncTimeInterval: String {
        get{
            let timeStr = timeConvertString(second: SyncPreferenceManager.shared.syncTimeInterval)
            return timeStr
        }
        set{
            SyncPreferenceManager.shared.syncTimeInterval = stringConvertTime(timeString: newValue)
//            NotificationCenter.default.post(name: NSNotification.Name.BeeFun.syncTimeChanged, object: nil)
        }
    }
    
    @IBAction func syncNow(_ sender: Any) {
//        BFiCloudManager.shared.startiCloudQuery()
    }
    
    @IBAction func restoreData(_ sender: Any) {
        //TODO: 数据恢复
        
    }
    
    func timeConvertString(second: Int) -> String {
        var timeNum = "2min"
        let secPerMin: Int = 60
        let secPerHour = secPerMin * 60
        let secperDay = secPerHour * 60
        
        switch second {
        case 1*secPerMin..<60*secPerMin:
            timeNum = String("\(second/secPerMin)min")
        case 1*secPerHour..<24*secPerHour:
            timeNum = String("\(second/secPerHour)h")
        case secperDay...:
            timeNum = String("\(second/secperDay)d")
        default:
            break
        }
        return timeNum
    }
    
    func stringConvertTime(timeString: String) -> Int {
        var unit = 60
        if timeString.contains("min") {
            unit = 60
        } else if timeString.contains("h") {
            unit = 60 * 60
        } else if timeString.contains("d") {
            unit = 60 * 60 * 60
        }
        
        if let num = Int(timeString.numbers) {
            return num * unit
        }
        return 120
    }
}

extension SyncPreferenceController: MASPreferencesViewController {
    
    var toolbarItemLabel: String? {
        return "Sync"
    }
    
    var viewIdentifier: String {
        return "SyncPreferences"
    }
    
    var toolbarItemImage: NSImage? {
        return NSImage.init(named: NSImage.Name.init("pre_cloud-sync"))
    }
    
}
