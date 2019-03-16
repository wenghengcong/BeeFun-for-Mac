//
//  MenuTrendingController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper

class MenuTrendingController: NSViewController {
    @IBOutlet weak var topLineView: NSBox!
    
    @IBOutlet weak var trendingCollectionView: NSCollectionView!
    @IBOutlet weak var languageSegmentControl: NSSegmentedControl!
    @IBOutlet weak var typeSegmentControl: NSSegmentedControl!
    
    @IBOutlet weak var refreshButton: NSButton!
    
    
    private var requesRepostModel: BFGithubTrendingRequsetModel?
    private var requesDeveloperModel: BFGithubTrendingRequsetModel?
    
    //Detail data: 均是二维数组
    private var githubTrendingReposData: [[BFGithubTrengingModel]] = []
    private var githubTrendingDevelopserData: [[BFGithubTrengingModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
}

// MARK: - Request
extension MenuTrendingController {
    
    func setRequestModel(language: String) {
        let source = 2
        requesRepostModel?.type = 1
        requesRepostModel?.source = source
        requesRepostModel?.time = BFGihubTrendingTimeEnum.daily
        requesRepostModel?.language = language
        requesRepostModel?.page = 1
        requesRepostModel?.perpage = 100
        requesRepostModel?.sort = "up_star_num"
        requesRepostModel?.direction = "desc"
        
        requesDeveloperModel?.type = 2
        requesDeveloperModel?.source = source
        requesDeveloperModel?.time = BFGihubTrendingTimeEnum.daily
        requesDeveloperModel?.language = language
        requesDeveloperModel?.page = 1
        requesDeveloperModel?.perpage = 100
        requesDeveloperModel?.sort = "pos"
        requesDeveloperModel?.direction = "asc"
    }
    
    
    func getGithubTrendingDeveloper(refresh: Bool) {
        
        if !refresh && githubTrendingDevelopserData.count > 0  {
            detailCollectionView.reloadData()
            return
        }

        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesDeveloperModel!)) { (result) in
            self.endRequestProgress()
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<BFGithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
                                //                                if self.githubTrendingDevelopserData.count > 0 {
                                //                                    self.githubTrendingDevelopserData[0] = data
                                //                                } else {
                                self.githubTrendingDevelopserData.removeAll()
                                self.githubTrendingDevelopserData.append(data)
                                //                                }
                                self.trendingCollectionView.reloadData()
                                self.trendingCollectionView.scroll(NSPoint.zero)
                            }
                        }
                    }
                } catch {
                }
                break
            case .failure:
                break
            }
        }
    }
    
    func getGithubTrendingReopsitories(refresh: Bool) {
        
        if !refresh && githubTrendingDevelopserData.count > 0  {
            detailCollectionView.reloadData()
            return
        }
        self.beginRequestProgress()
        BeeFunProvider.sharedProvider.request(BeeFunAPI.getGithubTrending(model: requesRepostModel!), callbackQueue: DispatchQueue.main, progress: { (progress) in
            print(progress.progress)
        }) { (result) in
            self.endRequestProgress()
            switch result {
            case let .success(response):
                do {
                    if let reposResponse = Mapper<BeeFunResponseModel<BFGithubTrengingModel>>().map(JSONObject: try response.mapJSON()) {
                        if let code = reposResponse.codeEnum, code == BFStatusCode.bfOk {
                            if let data = reposResponse.data {
                                self.githubTrendingReposData.removeAll()
                                self.githubTrendingReposData.append(data)
                                self.trendingCollectionView.reloadData()
                                self.trendingCollectionView.scroll(NSPoint.zero)
                            }
                        }
                    }
                } catch {
                }
                break
            case .failure:
                break
            }
        }
    }
    
}
