//
//  BFPathManager.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/4.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

class BFPathManager: NSObject {
    
    static let shared = BFPathManager()
    #if DEBUG
    var zipFileName = "github_debug.zip"
    #else
    var zipFileName = "github.zip"
    #endif
    var unZipTmpDirectory = "sqliteTmp"
    
    // MARK: - For zip
    /// Zip 本地路径
    /// ...../github.zip
    func localZipFilePath() -> URL? {
        return BFPathManager.shared.localDocumentURL(fileName: zipFileName)
    }
    
    /// Zip iCloud路径
    /// ...../github.zip
    func iCloudZipFilePath() -> URL? {
        return BFPathManager.shared.iCloudDocumentURL(fileName: zipFileName)
    }
    
    /// 需要压缩的路径
    /// .../..../github.sqlite
    func needZipFilePath() -> URL? {
        return BFPathManager.shared.localDocumentURL(fileName: SQLManager.githubDatabaseName)
    }
    
    /// 本地数据库路径
    func localGetSqliteFilePath() -> URL? {
        return needZipFilePath()
    }
    
    /// 需要解压缩的路径
    /// .../....com.beefun.mac./tmp
    /// 解压缩后，获取得到的路径是.../....com.beefun.mac./tmp/***.sqlite
    func unZipFilePath() -> URL? {
        return BFPathManager.shared.localDocumentURL(fileName: unZipTmpDirectory)
    }
    
    
    /// 解压缩后数据库所在的路径
    func unZipGetSqliteFilePath() -> URL? {
        return BFPathManager.shared.localDocumentURL()?.appendingPathComponent(unZipTmpDirectory).appendingPathComponent(SQLManager.githubDatabaseName)
    }
    
    // MARK: - Local Path
    func localDocumentURL(fileName: String) -> URL? {
        let docUrl = localDocumentURL()
        var fileUrl = docUrl?.appendingPathComponent(fileName)
        if let urlString = fileUrl?.absoluteString, urlString.lastCharacter == "/" {
            let nweUrlString = urlString.substring(to: urlString.length-1)
            fileUrl = URL.init(string: nweUrlString)
        }
        return fileUrl
    }
    
    func localDocumentURL() -> URL? {
        let fm = FileManager.default
        let bundleid = JSApp.bundleIdentifier
        let urlPaths = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        var userDocumentDirectory = URL(string: "")
        if let appDirectory = urlPaths.last?.appendingPathComponent(bundleid, isDirectory: true) {
            userDocumentDirectory = appDirectory
            if !fm.fileExists(atPath: appDirectory.path) {
                do {
                    try fm.createDirectory(at: appDirectory, withIntermediateDirectories: false, attributes: nil)
                } catch {
                }
            }
        }
        return userDocumentDirectory
    }
    
    // MARK: - iCloud Path
    /// iCloud.../Document/fileName
    func iCloudDocumentURL(fileName: String) -> URL? {
        return iCloudDocumentURL(nil, fileName: fileName)
    }
    
    func iCloudDocumentURL(_ containerId: String?, fileName: String) -> URL? {
        if containerId != nil {
            if let url = FileManager.default.url(forUbiquityContainerIdentifier: containerId) {
                return url.appendingPathComponent("Documents").appendingPathComponent(fileName)
            }
        } else {
            if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil) {
                return url.appendingPathComponent("Documents").appendingPathComponent(fileName)
            }
        }
        return nil
    }
}
