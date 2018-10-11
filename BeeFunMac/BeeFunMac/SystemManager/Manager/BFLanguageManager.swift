//
//  BFLanguageManager.swift
//  BeeFun
//
//  Created by 翁恒丛 on 2018/10/11.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFLanguageManager: NSObject {
    
    static let shared = BFLanguageManager()
    let resourceDirectory = "resource"
    
    
    func popLanguages() -> [[String: String]]? {
        let desPath = resourcePath()?.appendingPathComponent("BFPopularLanguage.plist")
        if let des = desPath, let desUrl = URL(string: des) {
            if !FileManager.default.fileExists(atPath: des) {
                copyLanguagePlistToDocument()
            }
            if let array = NSArray(contentsOfFile: desUrl.path) as? [[String: String]] {
                print("array  is \(array)")
                return array
            }
        }
        return nil
    }
    
    func copyLanguagePlistToDocument() {
        
        let fileM = FileManager.default
        let desPath = resourcePath()?.appendingPathComponent("BFPopularLanguage.plist")
        if let des = desPath {
            if let from = Bundle.appBundle.path(forResource: "BFPopularLanguage", ofType: "plist") {
                if !fileM.fileExists(atPath: des) {
                    do {
                        try fileM.copyItem(atPath: from, toPath: des)
                    } catch {
                        
                    }
                }
            }
            
            if let from = Bundle.appBundle.path(forResource: "BFLanguage", ofType: "plist") {
                if !fileM.fileExists(atPath: des) {
                    do {
                        try fileM.copyItem(atPath: from, toPath: des)
                    } catch {
                        
                    }
                }
            }
        }
     
    }
    
    func saveLangugePlistFile(languages: [[String: String]]?) {
        let desPath = resourcePath()?.appendingPathComponent("BFPopularLanguage.plist")
        if let lanArr = languages, let des = desPath {
            let nsarray = lanArr as! NSArray
            nsarray.write(toFile: des, atomically: true)
        }
    }
    
    func resourcePath() -> String? {
        return resourceUrl()?.path
    }
    
    func resourceUrl() -> URL?   {
        if let docUrl = documentUrl() {
            let resourceUrl = docUrl.appendingPathComponent(resourceDirectory)
            if !FileManager.default.fileExists(atPath: resourceUrl.path) {
                do {
                    try FileManager.default.createDirectory(atPath: resourceUrl.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    
                }
            }
            return resourceUrl
        }
        return nil
    }
    
    func documentPath() -> String? {
        return documentUrl()?.path
    }
    
    func documentUrl() -> URL?   {
        let fileM = FileManager.default
        return fileM.urls(for: .documentDirectory, in: .userDomainMask).last
    }
}
