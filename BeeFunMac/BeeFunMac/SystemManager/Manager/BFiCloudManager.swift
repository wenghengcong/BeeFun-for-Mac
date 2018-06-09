//
//  BFiCloudManager.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/7.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import SwiftDate

class BFiCloudManager: NSObject {

    static let shared = BFiCloudManager()
    var githubMetaQuery = NSMetadataQuery()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(metadataQueryDidFinishGathering(notification:)), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: self.githubMetaQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(metadataQueryDidUpdate(notification:)), name: NSNotification.Name.NSMetadataQueryDidUpdate, object: self.githubMetaQuery)
    }
    
    // MARK: - iCloud 查询
    /// 开始查询
    func startiCloudQuery() {
        if !UserManager.shared.isLogin {
            BFMonitor.shared.stop()
            return
        }
        self.githubMetaQuery.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
        self.githubMetaQuery.start()
    }
    
    /// 查询后结果返回
    @objc func metadataQueryDidFinishGathering(notification: NSNotification) {

        let items = self.githubMetaQuery.results
        var zipItem: NSMetadataItem? = nil
        var iCloudChangeDate: Date? = nil
        
        items.forEachEnumerated { (index, obj) in
            if let item: NSMetadataItem = obj as? NSMetadataItem {
                if let filename: String = item.value(forAttribute: NSMetadataItemFSNameKey) as? String {
                    let date = item.value(forAttribute: NSMetadataItemFSContentChangeDateKey)
                    print("\(filename), \(String(describing: date))")
                    if filename.contains(".zip") {
                        if let _ = item.value(forAttribute: NSMetadataItemURLKey) as? URL {
                            zipItem = item
                        }
                        if let change = item.value(forAttribute: NSMetadataItemFSContentChangeDateKey) as? Date {
                            iCloudChangeDate = change
                        }
                    }
                }
            }
        }
        
        if zipItem != nil {
            //云端数据库有该数据
            if fileExists(BFPathManager.shared.localZipFilePath()) {
                //本地也有该数据库zip，对比最新数据库，采用最新的数据库
                if let local = BFPathManager.shared.localZipFilePath() {
                    do {
                        let attri = try FileManager.default.attributesOfItem(atPath: local.path)
                        let localChangeDate = attri[FileAttributeKey.modificationDate] as? Date
                        if let localD = localChangeDate, let icloudD = iCloudChangeDate {
                            //时间小于2s，不作同步
                            let timeInterval = abs(localD.timeIntervalSinceReferenceDate - icloudD.timeIntervalSinceReferenceDate)
                            if  timeInterval < 2 {
                            } else {
                                let compare = localD.compare(icloudD)
                                if compare == ComparisonResult.orderedAscending  {
                                    synciCloudDBToLocal()
                                } else if compare == ComparisonResult.orderedDescending {
                                    syncLocalDBToiCloud()
                                }
                            }
                        }
                        //两边都有zip文件，假如就检测github.sqlite数据库文件
                        SQLManager.checkDBValid {
                            
                        }
                    } catch {
                        
                    }
                }
                
            } else {
                //本地无数据库，直接从云端下载数据库压缩包，并解压
                synciCloudDBToLocal()
            }
        } else {
            //云端无数据库
            
            if fileExists(BFPathManager.shared.localZipFilePath()) {
                //本地有数据库，上传本地数据库到云端
                syncLocalDBToiCloud()
            } else {
                //本地无数据库，创建表格
                SQLManager.checkDBValid {
                    
                }
            }
        }
    }
    
    @objc func metadataQueryDidUpdate(notification: NSNotification) {
        
    }
    
    // MARK: - iCloud上传、下载
    /// 同步本地数据给云端
    func syncLocalDBToiCloud() {
        if !UserManager.shared.isLogin {
            BFMonitor.shared.stop()
            return
        }
        //压缩成功，并上传iCloud
        if BFZipManager.shared.zipDB() {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                self.transferFileBetweeniCloudAndLocal(upload: true)
            })
        }
    }
    
    /// 同步云端数据给本地
    func synciCloudDBToLocal() {
        if !UserManager.shared.isLogin {
            BFMonitor.shared.stop()
            return
        }
        transferFileBetweeniCloudAndLocal(upload: false)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
           _ = BFZipManager.shared.unZipDB()
        })
    }
    
    func transferFileBetweeniCloudAndLocal(upload: Bool) {
        if let local = BFPathManager.shared.localZipFilePath(), let icloud = BFPathManager.shared.iCloudZipFilePath() {
            if upload {
                iCludCopyItem(at: local, to: icloud)
            } else {
                iCludCopyItem(at: icloud, to: local)
            }
        }
    }
    
    // MARK: - private util method
    
    private func fileExists(_ path: URL?) -> Bool {
        if let filePath = path {
            if FileManager.default.fileExists(atPath: filePath.path) {
                return true
            }
        }
        return false
    }
    
    private func iCludCopyItem(at srcURL: URL, to dstURL: URL) {
        if fileExists(dstURL) {
            do {
                try FileManager.default.removeItem(atPath: dstURL.path)
                print("Existing file deleted.")
            } catch {
                print("Failed to delete existing file:\n\((error as NSError).description)")
            }
        }
        
        do {
            try FileManager.default.copyItem(atPath: srcURL.path, toPath: dstURL.path)
            print("File saved.")
        } catch {
            print("File not saved:\n\((error as NSError).description)")
        }
    }

}
