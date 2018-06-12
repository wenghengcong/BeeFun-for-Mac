//
//  BeeFunAPI.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/4/22.
//  Copyright © 2018年 JungleSong. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper

class InsideBeeFunProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    override init(endpointClosure: @escaping (Target) -> Endpoint, requestClosure: @escaping (Endpoint, @escaping MoyaProvider<BeeFunAPI>.RequestResultClosure) -> Void, stubClosure: @escaping (Target) -> StubBehavior, callbackQueue: DispatchQueue?, manager: Manager, plugins: [PluginType], trackInflights: Bool) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
}

struct BeeFunProvider {
    
    fileprivate static var endpointsClosure = { (target: BeeFunAPI) -> Endpoint in
        
        var endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        return endpoint
    }
    static func stubBehaviour(_: BeeFunAPI) -> Moya.StubBehavior {
        return .never
    }
    
    static func DefaultProvider() -> InsideBeeFunProvider<BeeFunAPI> {
        
        return InsideBeeFunProvider(endpointClosure: endpointsClosure, requestClosure: MoyaProvider<BeeFunAPI>.defaultRequestMapping, stubClosure: MoyaProvider.neverStub, callbackQueue: DispatchQueue.main, manager: Alamofire.SessionManager.default, plugins: [], trackInflights: false)
    }
    
    fileprivate struct SharedProvider {
        static var instance = BeeFunProvider.DefaultProvider()
    }
    static var sharedProvider: InsideBeeFunProvider<BeeFunAPI> {
        get {
            return SharedProvider.instance
        }
        
        set (newSharedProvider) {
            SharedProvider.instance = newSharedProvider
        }
        
    }
}

public enum BeeFunAPI {
    
    //更新数据库
    //1. 每次启动时 2.
    case updateBeeFunDBFromGithub()
    
    //从BeeFun获取到github starrd 的页数，每页100
    case repoPage(owner: String)
    case repos(tag: String, language: String,  page:Int, perpage:Int, sort:String, direction:String)
    case delRepo(repoid: Int)
    case addRepo(repo: ObjRepos)
    
    //tag
    // MARK: - page或perpage传0，就返回所有数据
    case getAllTags(page:Int, perpage:Int, sort:String, direction:String, containAll: String)
    case getTag(name: String)
    case addTag(tagModel: ObjTag)
    case addTagToRepo(star_tags: String, repoId: Int)
    case updateTag(name: String, to: String)
    case deleteTag(name: String)
    
    //language
    case getLanguages(page:Int, perpage:Int, sort:String, direction:String)
}
extension BeeFunAPI: TargetType {
    
    public var headers: [String: String]? {
        let token = AppToken.shared.access_token ?? ""
        let owner = UserManager.shared.login ?? ""
        var header = ["User-Agent": "BeeFuniOS", "Authorization": token, "timeoutInterval": "15.0", "owner": owner]
        switch self {
        default:
            header = ["User-Agent": "BeeFuniOS", "Authorization": token, "timeoutInterval": "15.0", "owner": owner]
            return header
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return Alamofire.ParameterEncoding.self as! ParameterEncoding
    }
    public var baseURL: URL {
        switch self {
        default:
                    //远程部署环境
            //            return URL(string: "http://106.14.174.202:8081/beefun")!     //远程测试环境
//            return URL(string: "http://106.14.174.202:8082/beefun")!     //远程正式环境
                    //本地部署环境
            //            return URL(string: "http://localhost:8081/beefun")!          //本地测试环境
            //            return URL(string: "http://localhost:8082/beefun")!            //本地正式环境
                    //本地运行环境
            //            return URL(string: "http://localhost:8081/beefun")!          //本地测试环境
                        return URL(string: "http://localhost:8082")!            //本地正式环境
        }
    }
    
    public var path: String {
        switch self {
        case .addRepo(_):
            return "/repo/client"
        case .updateBeeFunDBFromGithub():
            return "/updatedb"
            
        case .repoPage(let owner):
            return "/reponum/\(owner)"
        case .repos(let tag,_, _, _, _, _):
            return "/repos/\(tag)"
        case .delRepo(let repoid):
            return "/repo/\(repoid)"
            
            // tag操作
        case .getAllTags(_, _, _, _, _):
            return "/tags"
        case .getTag(let name):
            return "/tag/\(name)"
        case .addTag(_):
            return "/tag"
        case .addTagToRepo(_, let repoId):
            return "/repo/tag/\(repoId)"
        case .updateTag(let name, _):
            return "/tag/\(name)"
        case .deleteTag(let name):
            return "/tag/\(name)"
        case .getLanguages(_, _, _, _):
            return "/lans"
        }
        
    }
    
    public var method: Moya.Method {
        
        switch self {
        case .addRepo(_):
            return .post
        case .addTag(_):
            return .post
        case .updateTag(_, _):
            return .put
        case .deleteTag(_):
            return .delete
        case .addTagToRepo(_, _):
            return .post
        case .delRepo(_):
            return .delete
        default:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .addRepo(let repo):
            return repo.toJSON()
        case .getAllTags(let page, let perpage, let sort, let direction, let containAll):
            return [
                "page": page as AnyObject,
                "perpage": perpage as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject,
                "containAll": containAll as AnyObject
            ]
        case .updateTag(_, let to):
            return [
                "to": to
            ]
        case .addTag(let tagModel):
            return [
                "name": tagModel.name!,
                "owner": tagModel.owner ?? ""
            ]
            
        case .addTagToRepo(let star_tags, _):
            return [
                "star_tags": star_tags
            ]
        case .repos(_,let language, let page, let perpage, let sort, let direction):
            return [
                "language": language as AnyObject,
                "page": page as AnyObject,
                "perpage": perpage as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
        case .getLanguages(let page, let perpage, let sort, let direction):
            return [
                "page": page as AnyObject,
                "perpage": perpage as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
        default:
            return nil
        }
    }
    
    public var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }
    
    //Any target you want to hit must provide some non-nil NSData that represents a sample response. This can be used later for tests or for providing offline support for developers. This should depend on self.
    public var sampleData: Data {
        switch self {
            
        default :
            return "default".data(using: String.Encoding.utf8)!
        }
        
    }
}
