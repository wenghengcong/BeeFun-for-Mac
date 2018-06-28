//
//  IssueAPI.swift
//  BeeFun
//
//  Created by WengHengcong on 2017/4/14.
//  Copyright © 2017年 JungleSong. All rights reserved.
//

import AppKit
import Foundation
import Moya
import Alamofire
import ObjectMapper

class InsideIssueProvider<Target>: MoyaProvider<Target> where Target: TargetType {
    
    override init(endpointClosure: @escaping (Target) -> Endpoint, requestClosure: @escaping (Endpoint, @escaping MoyaProvider<IssueAPI>.RequestResultClosure) -> Void, stubClosure: @escaping (Target) -> StubBehavior, callbackQueue: DispatchQueue?, manager: Manager, plugins: [PluginType], trackInflights: Bool) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
}

struct IssueProvider {

    fileprivate static var endpointsClosure = { (target: IssueAPI) -> Endpoint in
        var endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        return endpoint
    }
    
    static func stubBehaviour(_: GitHubAPI) -> Moya.StubBehavior {
        return .never
    }
    
    static func DefaultProvider() -> InsideIssueProvider<IssueAPI> {
        return InsideIssueProvider(endpointClosure: endpointsClosure, requestClosure: MoyaProvider<IssueAPI>.defaultRequestMapping, stubClosure: MoyaProvider.neverStub, callbackQueue: DispatchQueue.main, manager: Alamofire.SessionManager.default, plugins: [], trackInflights: false)
    }
    
    fileprivate struct SharedProvider {
        static var instance = IssueProvider.DefaultProvider()
    }
    static var sharedProvider: InsideIssueProvider<IssueAPI> {
        get {
            return SharedProvider.instance
        }
        
        set (newSharedProvider) {
            SharedProvider.instance = newSharedProvider
        }
        
    }
}

/// Issue https://developer.github.com/v3/issues/
///
/// - allIssues: List all issues assigned to the authenticated user across all visible repositories including owned repositories, member repositories, and organization repositories

/// - myIssues: List all issues across owned and member repositories assigned to the authenticated user

/// - orgIssues: List all issues for a given organization assigned to the authenticated user

/// - repoIssues: List issues for a repository
/// - repoSigleIssue: Get a single issue
/// - createIssue: Create an issue
/// - editIssue: Edit an issue
/// - lockIssue: Lock an issue
/// - unlockIssue: Unlock an issue
public enum IssueAPI {
    
    case allIssues(page:Int, perpage:Int, filter:String, state:String, labels:String, sort:String, direction:String)
    case myIssues(page:Int, perpage:Int, filter:String, state:String, labels:String, sort:String, direction:String)
    case orgIssues(page:Int, perpage:Int, organization:String, filter:String, state:String, labels:String, sort:String, direction:String)
    case repoIssues(page:Int, perpage:Int, owner:String, repo:String, milestone:Int, state:String, assignee:String, creator:String, mentioned:String, labels:String, sort:String, direction:String)
    case repoSigleIssue(owner:String, repo:String, number:Int)
    case createIssue(owner:String, repo:String, title:String, body:String, assignee:String, milestone:Int, labels:String)
    case editIssue(owner:String, repo:String, number:Int, title:String, body:String, assignee:String, milestone:Int, labels:String)
    case lockIssue(owner:String, repo:String, number:Int)
    case unlockIssue(owner:String, repo:String, number:Int)
    
}

extension IssueAPI: TargetType {
    
    public var headers: [String : String]? {
        var header = ["User-Agent": "BeeFunMac","Authorization": AppToken.shared.access_token ?? "", "timeoutInterval": "15.0", "Accept": "application/vnd.github.v3.star+json"]
        switch self {
        default:
            header = ["User-Agent": "BeeFunMac","Authorization": AppToken.shared.access_token ?? "", "timeoutInterval": "15.0"]
            return header
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return Alamofire.ParameterEncoding.self as! ParameterEncoding
    }
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.github.com")!
        }
    }
    
    public var path: String {
        switch self {
        //issue
        case .allIssues:
            return "/issues"
        case .myIssues:
            return "/user/issues"
        case .orgIssues(_, _, let organization, _, _, _, _, _):
            return "/orgs/\(organization)/issues"
        case .repoIssues(_, _, let owner, let repo, _, _, _, _, _, _, _, _):
            return "/repos/\(owner)/\(repo)/issues"
        case .repoSigleIssue(let owner, let repo, let number):
            return "/repos/\(owner)/\(repo)/issues/\(number)"
        case .createIssue(let owner, let repo, _, _, _, _, _):
            return "/repos/\(owner)/\(repo)/issues"
        case .editIssue(let owner, let repo, let number, _, _, _, _, _):
            return "/repos/\(owner)/\(repo)/issues/\(number)"
        case .lockIssue(let owner, let repo, let number):
            return "/repos/\(owner)/\(repo)/issues/\(number)/lock"
        case .unlockIssue(let owner, let repo, let number):
            return "/repos/\(owner)/\(repo)/issues/\(number)/lock"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .createIssue(_, _, _, _, _, _, _):
            return .post
        case .editIssue(_, _, _, _, _, _, _, _):
            return .patch
        case .lockIssue(_, _, _):
            return .put
        case .unlockIssue(_, _, _):
            return .delete
        default:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .allIssues(let page, let perpage, let filter, let state, let labels, let sort, let direction):
            return [
                "page": page as AnyObject,
                "per_page": perpage as AnyObject,
                "filter": filter as AnyObject,
                "state": state as AnyObject,
                "labels": labels as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
        case .myIssues(let page, let perpage, let filter, let state, let labels, let sort, let direction):
            return [
                "page": page as AnyObject,
                "per_page": perpage as AnyObject,
                "filter": filter as AnyObject,
                "state": state as AnyObject,
                "labels": labels as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
            
        case .orgIssues(let page, let perpage, _, let filter, let state, let labels, let sort, let direction):
            return [
                "page": page as AnyObject,
                "per_page": perpage as AnyObject,
                "filter": filter as AnyObject,
                "state": state as AnyObject,
                "labels": labels as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
        case .repoIssues(let page, let perpage, _, _, let milestone, let state, let assignee, let creator, let mentioned, let labels, let sort, let direction):
            return [
                "page": page as AnyObject,
                "per_page": perpage as AnyObject,
                "milestone": milestone as AnyObject,
                "state": state as AnyObject,
                "assignee": assignee as AnyObject,
                "creator": creator as AnyObject,
                "mentioned": mentioned as AnyObject,
                "labels": labels as AnyObject,
                "sort": sort as AnyObject,
                "direction": direction as AnyObject
            ]
            
        case .createIssue(_, _, let title, let body, let assignee, let milestone, let labels):
            return [
                "title": title as AnyObject,
                "body": body as AnyObject,
                "assignee": assignee as AnyObject,
                "milestone": milestone as AnyObject,
                "labels": labels as AnyObject
            ]
        case .editIssue(_, _, _, let title, let body, let assignee, let milestone, let labels):
            return [
                
                "title": title as AnyObject,
                "body": body as AnyObject,
                "assignee": assignee as AnyObject,
                "milestone": milestone as AnyObject,
                "labels": labels as AnyObject
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


