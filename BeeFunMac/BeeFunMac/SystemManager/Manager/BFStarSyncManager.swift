//
//  BFStarSyncManager.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/26.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import Alamofire

class BFStarSyncManager: NSObject {
    
    static let shared = BFStarSyncManager()
    
    /// 总页数
    var totalPage = 1
    var action = "auto"
    var syncing: Bool = false
    
    /// 手动同步
    func manualSync(postNotification: Bool) {
        action = "manual"
        checkIsSyncing(postNotification: postNotification)
    }
    
    func checkIsSyncing(postNotification: Bool) {
        if syncing {
            return
        }
        syncing = true
        SQLManager.checkDBValid {
            if postNotification {
                NotificationCenter.default.post(name: NSNotification.Name.BeeFun.syncStarRepoBegin, object: nil)
            }
            requestForAllStarReposCount()
        }
    }
    
    func requestForAllStarReposCount() {
        //  参考  https://stackoverflow.com/questions/30636798/get-user-total-starred-count-using-github-api-v3
        if !UserManager.shared.isLogin {
            syncing = false
            return
        }
        let url = String(format: "https://api.github.com/users/%@/starred?per_page=1", UserManager.shared.login!)
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
            case .success:
                print("Response: \(String(describing: response.response))") // http url response
                if let httpRep = response.response {
                    if let link: String = httpRep.allHeaderFields["Link"] as? String {
                        let arr = link.split(",")
                        if arr.count > 1 {
                            let lastPage = arr[1]
                            if let pageBegin = lastPage.range(of: "&page="), let pageEnd = lastPage.range(of: ">") {
                                let range = pageBegin.upperBound..<pageEnd.lowerBound
                                let pageStr = lastPage.substring(with: range)
                                if let page = pageStr.int {
                                    self.requestForAllStarRepos(count: page)
                                }
                            }
                        }
                        
                    }
                }
                break
            case .failure:
                self.syncing = false
                break
            }
        }
    }
    
    /// 请求所有star数据
    ///
    /// - Parameter count: star总数
    func requestForAllStarRepos(count: Int) {
        let perPage: Int = 100
        totalPage = Int(ceil(Double(count)/Double(perPage)))
        let interval = 1.0
        
        for index in 1...totalPage {
            let delayTime = interval * Double(index)
            let queueLabel = String(format: "com.junglesong.page%d", perPage)
            let queue = DispatchQueue(label: queueLabel)
            queue.asyncAfter(deadline: DispatchTime.now()+delayTime) {
                self.requestForPerPageStarRepos(page: index, perPage: perPage)
            }
        }
    }
    
    /// 请求每页的star数据
    ///
    /// - Parameters:
    ///   - page: 页数
    ///   - perPage: 每页数据量
    func requestForPerPageStarRepos(page: Int, perPage: Int) {
//        print("page:\(page) perpage:\(perPage)")
        Provider.sharedProvider.request(.myStarredRepos(page:page, perpage:perPage, sort: "created", direction: "desc") ) { (result) -> Void in
            switch result {
            case let .success(response):
                do {
                    let starRepos: [ObjStarRepos] = try response.mapArray(ObjStarRepos.self)
                    var allRespos:[ObjRepos] = []
                    for item in starRepos {
                        if let repo = item.repo {
                            allRespos.append(repo)
                        }
                    }
                    SQLStars.insert(repos: allRespos)
                    if page == self.totalPage {
                        print("star data download done")
                        NotificationCenter.default.post(name: NSNotification.Name.BeeFun.syncStarRepoDone, object: nil)
                        self.syncing = false
                    }
                } catch {
                }
            case .failure:
                self.syncing = false
                break
            }
        }
    }
}
