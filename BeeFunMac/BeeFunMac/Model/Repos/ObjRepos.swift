//
//  ObjRepos.swift
//  BeeFun
//
//  Created by wenghengcong on 16/1/23.
//  Copyright © 2016年 JungleSong. All rights reserved.
//

import Foundation
import Cocoa
import ObjectMapper
/*
 {
 "archive_url": "https://api.github.com/repos/wenghengcong/BeeFun/{archive_format}{/ref}",
 "assignees_url": "https://api.github.com/repos/wenghengcong/BeeFun/assignees{/user}",
 "blobs_url": "https://api.github.com/repos/wenghengcong/BeeFun/git/blobs{/sha}",
 "branches_url": "https://api.github.com/repos/wenghengcong/BeeFun/branches{/branch}",
 "clone_url": "https://github.com/wenghengcong/BeeFun.git",
 "collaborators_url": "https://api.github.com/repos/wenghengcong/BeeFun/collaborators{/collaborator}",
 "comments_url": "https://api.github.com/repos/wenghengcong/BeeFun/comments{/number}",
 "commits_url": "https://api.github.com/repos/wenghengcong/BeeFun/commits{/sha}",
 "compare_url": "https://api.github.com/repos/wenghengcong/BeeFun/compare/{base}...{head}",
 "contents_url": "https://api.github.com/repos/wenghengcong/BeeFun/contents/{+path}",
 "contributors_url": "https://api.github.com/repos/wenghengcong/BeeFun/contributors",
 "created_at": "2015-12-21T22:18:35Z",
 "default_branch": "master",
 "deployments_url": "https://api.github.com/repos/wenghengcong/BeeFun/deployments",
 "description": "Github client for iOS in Swift.",
 "downloads_url": "https://api.github.com/repos/wenghengcong/BeeFun/downloads",
 "events_url": "https://api.github.com/repos/wenghengcong/BeeFun/events",
 "fork": false,
 "forks": 22,
 "forks_count": 22,
 "forks_url": "https://api.github.com/repos/wenghengcong/BeeFun/forks",
 "full_name": "wenghengcong/BeeFun",
 "git_commits_url": "https://api.github.com/repos/wenghengcong/BeeFun/git/commits{/sha}",
 "git_refs_url": "https://api.github.com/repos/wenghengcong/BeeFun/git/refs{/sha}",
 "git_tags_url": "https://api.github.com/repos/wenghengcong/BeeFun/git/tags{/sha}",
 "git_url": "git://github.com/wenghengcong/BeeFun.git",
 "has_downloads": true,
 "has_issues": true,
 "has_pages": false,
 "has_projects": true,
 "has_wiki": true,
 "homepage": "",
 "hooks_url": "https://api.github.com/repos/wenghengcong/BeeFun/hooks",
 "html_url": "https://github.com/wenghengcong/BeeFun",
 "id": 48397107,
 "issue_comment_url": "https://api.github.com/repos/wenghengcong/BeeFun/issues/comments{/number}",
 "issue_events_url": "https://api.github.com/repos/wenghengcong/BeeFun/issues/events{/number}",
 "issues_url": "https://api.github.com/repos/wenghengcong/BeeFun/issues{/number}",
 "keys_url": "https://api.github.com/repos/wenghengcong/BeeFun/keys{/key_id}",
 "labels_url": "https://api.github.com/repos/wenghengcong/BeeFun/labels{/name}",
 "language": "Objective-C",
 "languages_url": "https://api.github.com/repos/wenghengcong/BeeFun/languages",
 "merges_url": "https://api.github.com/repos/wenghengcong/BeeFun/merges",
 "milestones_url": "https://api.github.com/repos/wenghengcong/BeeFun/milestones{/number}",
 "mirror_url": null,
 "name": "BeeFun",
 "network_count": 22,
 "notifications_url": "https://api.github.com/repos/wenghengcong/BeeFun/notifications{?since,all,participating}",
 "open_issues": 1,
 "open_issues_count": 1,
 "owner": {
     "avatar_url": "https://avatars0.githubusercontent.com/u/3964406?v=3",
     "events_url": "https://api.github.com/users/wenghengcong/events{/privacy}",
     "followers_url": "https://api.github.com/users/wenghengcong/followers",
     "following_url": "https://api.github.com/users/wenghengcong/following{/other_user}",
     "gists_url": "https://api.github.com/users/wenghengcong/gists{/gist_id}",
     "gravatar_id": "",
     "html_url": "https://github.com/wenghengcong",
     "id": 3964406,
     "login": "wenghengcong",
     "organizations_url": "https://api.github.com/users/wenghengcong/orgs",
     "received_events_url": "https://api.github.com/users/wenghengcong/received_events",
     "repos_url": "https://api.github.com/users/wenghengcong/repos",
     "site_admin": false,
     "starred_url": "https://api.github.com/users/wenghengcong/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/wenghengcong/subscriptions",
     "type": "User",
     "url": "https://api.github.com/users/wenghengcong"
 },
 "private": false,
 "pulls_url": "https://api.github.com/repos/wenghengcong/BeeFun/pulls{/number}",
 "pushed_at": "2017-05-17T22:32:50Z",
 "releases_url": "https://api.github.com/repos/wenghengcong/BeeFun/releases{/id}",
 "size": 271899,
 "ssh_url": "git@github.com:wenghengcong/BeeFun.git",
 "stargazers_count": 151,
 "stargazers_url": "https://api.github.com/repos/wenghengcong/BeeFun/stargazers",
 "statuses_url": "https://api.github.com/repos/wenghengcong/BeeFun/statuses/{sha}",
 "subscribers_count": 3,
 "subscribers_url": "https://api.github.com/repos/wenghengcong/BeeFun/subscribers",
 "subscription_url": "https://api.github.com/repos/wenghengcong/BeeFun/subscription",
 "svn_url": "https://github.com/wenghengcong/BeeFun",
 "tags_url": "https://api.github.com/repos/wenghengcong/BeeFun/tags",
 "teams_url": "https://api.github.com/repos/wenghengcong/BeeFun/teams",
 "trees_url": "https://api.github.com/repos/wenghengcong/BeeFun/git/trees{/sha}",
 "updated_at": "2017-05-14T12:46:49Z",
 "url": "https://api.github.com/repos/wenghengcong/BeeFun",
 "watchers": 151,
 "watchers_count": 151
 }

 
 {
 "archive_url": "https://api.github.com/repos/AFNetworking/AFNetworking/{archive_format}{/ref}",
 "assignees_url": "https://api.github.com/repos/AFNetworking/AFNetworking/assignees{/user}",
 "blobs_url": "https://api.github.com/repos/AFNetworking/AFNetworking/git/blobs{/sha}",
 "branches_url": "https://api.github.com/repos/AFNetworking/AFNetworking/branches{/branch}",
 "clone_url": "https://github.com/AFNetworking/AFNetworking.git",
 "collaborators_url": "https://api.github.com/repos/AFNetworking/AFNetworking/collaborators{/collaborator}",
 "comments_url": "https://api.github.com/repos/AFNetworking/AFNetworking/comments{/number}",
 "commits_url": "https://api.github.com/repos/AFNetworking/AFNetworking/commits{/sha}",
 "compare_url": "https://api.github.com/repos/AFNetworking/AFNetworking/compare/{base}...{head}",
 "contents_url": "https://api.github.com/repos/AFNetworking/AFNetworking/contents/{+path}",
 "contributors_url": "https://api.github.com/repos/AFNetworking/AFNetworking/contributors",
 "created_at": "2011-05-31T21:28:44Z",
 "default_branch": "master",
 "deployments_url": "https://api.github.com/repos/AFNetworking/AFNetworking/deployments",
 "description": "A delightful networking framework for iOS, OS X, watchOS, and tvOS.",
 "downloads_url": "https://api.github.com/repos/AFNetworking/AFNetworking/downloads",
 "events_url": "https://api.github.com/repos/AFNetworking/AFNetworking/events",
 "fork": false,
 "forks": 9209,
 "forks_count": 9209,
 "forks_url": "https://api.github.com/repos/AFNetworking/AFNetworking/forks",
 "full_name": "AFNetworking/AFNetworking",
 "git_commits_url": "https://api.github.com/repos/AFNetworking/AFNetworking/git/commits{/sha}",
 "git_refs_url": "https://api.github.com/repos/AFNetworking/AFNetworking/git/refs{/sha}",
 "git_tags_url": "https://api.github.com/repos/AFNetworking/AFNetworking/git/tags{/sha}",
 "git_url": "git://github.com/AFNetworking/AFNetworking.git",
 "has_downloads": true,
 "has_issues": true,
 "has_pages": false,
 "has_projects": true,
 "has_wiki": true,
 "homepage": "http://afnetworking.com",
 "hooks_url": "https://api.github.com/repos/AFNetworking/AFNetworking/hooks",
 "html_url": "https://github.com/AFNetworking/AFNetworking",
 "id": 1828795,
 "issue_comment_url": "https://api.github.com/repos/AFNetworking/AFNetworking/issues/comments{/number}",
 "issue_events_url": "https://api.github.com/repos/AFNetworking/AFNetworking/issues/events{/number}",
 "issues_url": "https://api.github.com/repos/AFNetworking/AFNetworking/issues{/number}",
 "keys_url": "https://api.github.com/repos/AFNetworking/AFNetworking/keys{/key_id}",
 "labels_url": "https://api.github.com/repos/AFNetworking/AFNetworking/labels{/name}",
 "language": "Objective-C",
 "languages_url": "https://api.github.com/repos/AFNetworking/AFNetworking/languages",
 "merges_url": "https://api.github.com/repos/AFNetworking/AFNetworking/merges",
 "milestones_url": "https://api.github.com/repos/AFNetworking/AFNetworking/milestones{/number}",
 "mirror_url": null,
 "name": "AFNetworking",
 "network_count": 9209,
 "notifications_url": "https://api.github.com/repos/AFNetworking/AFNetworking/notifications{?since,all,participating}",
 "open_issues": 332,
 "open_issues_count": 332,
 "organization": {
     "avatar_url": "https://avatars1.githubusercontent.com/u/1181541?v=3",
     "events_url": "https://api.github.com/users/AFNetworking/events{/privacy}",
     "followers_url": "https://api.github.com/users/AFNetworking/followers",
     "following_url": "https://api.github.com/users/AFNetworking/following{/other_user}",
     "gists_url": "https://api.github.com/users/AFNetworking/gists{/gist_id}",
     "gravatar_id": "",
     "html_url": "https://github.com/AFNetworking",
     "id": 1181541,
     "login": "AFNetworking",
     "organizations_url": "https://api.github.com/users/AFNetworking/orgs",
     "received_events_url": "https://api.github.com/users/AFNetworking/received_events",
     "repos_url": "https://api.github.com/users/AFNetworking/repos",
     "site_admin": false,
     "starred_url": "https://api.github.com/users/AFNetworking/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/AFNetworking/subscriptions",
     "type": "Organization",
     "url": "https://api.github.com/users/AFNetworking"
 },
 "owner": {
     "avatar_url": "https://avatars1.githubusercontent.com/u/1181541?v=3",
     "events_url": "https://api.github.com/users/AFNetworking/events{/privacy}",
     "followers_url": "https://api.github.com/users/AFNetworking/followers",
     "following_url": "https://api.github.com/users/AFNetworking/following{/other_user}",
     "gists_url": "https://api.github.com/users/AFNetworking/gists{/gist_id}",
     "gravatar_id": "",
     "html_url": "https://github.com/AFNetworking",
     "id": 1181541,
     "login": "AFNetworking",
     "organizations_url": "https://api.github.com/users/AFNetworking/orgs",
     "received_events_url": "https://api.github.com/users/AFNetworking/received_events",
     "repos_url": "https://api.github.com/users/AFNetworking/repos",
     "site_admin": false,
     "starred_url": "https://api.github.com/users/AFNetworking/starred{/owner}{/repo}",
     "subscriptions_url": "https://api.github.com/users/AFNetworking/subscriptions",
     "type": "Organization",
     "url": "https://api.github.com/users/AFNetworking"
 },
 "private": false,
 "pulls_url": "https://api.github.com/repos/AFNetworking/AFNetworking/pulls{/number}",
 "pushed_at": "2017-05-14T08:25:42Z",
 "releases_url": "https://api.github.com/repos/AFNetworking/AFNetworking/releases{/id}",
 "size": 17223,
 "ssh_url": "git@github.com:AFNetworking/AFNetworking.git",
 "stargazers_count": 29181,
 "stargazers_url": "https://api.github.com/repos/AFNetworking/AFNetworking/stargazers",
 "statuses_url": "https://api.github.com/repos/AFNetworking/AFNetworking/statuses/{sha}",
 "subscribers_count": 1799,
 "subscribers_url": "https://api.github.com/repos/AFNetworking/AFNetworking/subscribers",
 "subscription_url": "https://api.github.com/repos/AFNetworking/AFNetworking/subscription",
 "svn_url": "https://github.com/AFNetworking/AFNetworking",
 "tags_url": "https://api.github.com/repos/AFNetworking/AFNetworking/tags",
 "teams_url": "https://api.github.com/repos/AFNetworking/AFNetworking/teams",
 "trees_url": "https://api.github.com/repos/AFNetworking/AFNetworking/git/trees{/sha}",
 "updated_at": "2017-05-22T07:50:04Z",
 "url": "https://api.github.com/repos/AFNetworking/AFNetworking",
 "watchers": 29181,
 "watchers_count": 29181
 }
 
*/

public class ObjRepos: NSObject, Mappable {
    
    //1
    var archive_url: String?
    var assignees_url: String?
    var blobs_url: String?
    var branches_url: String?
    var clone_url: String?
    var collaborators_url: String?
    var comments_url: String?
    var commits_url: String?
    var compare_url: String?
    var contents_url: String?
    
    //11
    var contributors_url: String?
    var created_at: String?
    var default_branch: String?
    var deployments_url: String?
    var cdescription: String?            //description同关键字冲突，加c前缀
    var downloads_url: String?
    var events_url: String?
    var fork: Bool?
    var forks: Int?
    var forks_count: Int?
    
    //21
    var forks_url: String?
    var full_name: String?
    var git_commits_url: String?
    var git_refs_url: String?
    var git_tags_url: String?
    var git_url: String?
    var has_downloads: Bool?
    var has_projects: Bool?
    var has_issues: Bool?
    var has_pages: Bool?
    var has_wiki: Bool?
    
    //31
    var homepage: String?
    var hooks_url: String?
    var html_url: String?
    var id: Int?
    var issue_comment_url: String?
    var issue_events_url: String?
    var issues_url: String?
    var keys_url: String?
    var labels_url: String?
    var language: String?
    
    //41
    var languages_url: String?
    var merges_url: String?
    var milestones_url: String?
    var mirror_url: String?
    var name: String?
    var notifications_url: String?
    var open_issues: Int?
    var open_issues_count: Int?
    var owner: ObjUser?
    var star_owner: String?
    var permissions: ObjPermissions?
    
    //51
    var cprivate: Bool?              //private同关键字冲突，加c前缀
    var pulls_url: String?
    var pushed_at: String?
    var releases_url: String?
    var size: Int?
    var ssh_url: String?
    var stargazers_count: Int?
    var stargazers_url: String?
    var statuses_url: String?
    var subscribers_url: String?
    
    //61
    var subscription_url: String?
    var svn_url: String?
    var tags_url: String?
    var teams_url: String?
    var trees_url: String?
    var updated_at: String?
    var url: String?
    var watchers: Int?
    var watchers_count: Int?
    var subscribers_count: Int?
    
    //以下字段为单独增加
    var star_tags: [String]?
    var star_lists: [String]?
    /// 是否订阅该项目
    var watched: Bool? = false
    /// 是否关注该项目
    var starred: Bool? = false
    /// 关注该repo的时间，从网络请求中截取
    var starred_at: String?
    
    /// Trending中
    var trending_star_text: String?                       /// star
    var trending_fork_text: String?                       /// star
    var trending_star_interval_text: String?                     /// 200 stars this week
    var trending_showcase_update_text: String?              ///Updated Jul 5, 2017
    var score: Double?  //搜索得分
    
    struct ReposKey {
        
        static let archiveUrlKey = "archive_url"
        static let assigneesUrlKey = "assignees_url"
        static let blobsUrlKey = "blobs_url"
        static let branchesUrlKey = "branches_url"
        
        static let cloneUrlKey = "clone_url"
        static let collaboratorsUrlKey = "collaborators_url"
        static let commentsUrlKey = "comments_url"
        static let commitsUrlKey = "commits_url"
        
        static let compareUrlKey = "compare_url"
        static let contentsUrlKey = "contents_url"
        static let contributorsUrlKey = "contributors_url"
        static let createdAtKey = "created_at"
        static let defaultBranchKey = "default_branch"
        static let deploymentsUrlKey = "deployments_url"
        static let descriptionKey = "description"
        static let downloadsUrlKey = "downloads_url"
        static let eventsUrlKey = "events_url"
        static let forkKey = "fork"
        
        static let forksKey = "forks"
        static let forksCountKey = "forks_count"
        static let forksUrlKey = "forks_url"
        
        static let fullNameKey = "full_name"
        static let gitCommitsUrlKey = "git_commits_url"
        static let gitRefsUrlKey = "git_refs_url"
        static let gitTagsUrlKey = "git_tags_url"
        static let gitUrlKey = "git_url"
        static let hasDownloadsKey = "has_downloads"
        static let hasProjects = "has_projects"
        static let hasIssuesKey = "has_issues"
        static let hasPagesKey = "has_pages"
        static let hasWikiKey = "has_wiki"
        static let homepageKey = "homepage"
        static let hooksUrlKey = "hooks_url"
        static let htmlUrlKey = "html_url"
        static let idKey = "id"
        static let issueCommentUrlKey = "issue_comment_url:"
        static let issueEventsUrlKey = "issue_events_url"
        
        static let issuesUrlKey = "issues_url"
        static let keysUrlKey = "keys_url"
        static let labelsUrlKey = "labels_url"
        static let languageKey = "language"
        static let languagesUrlKey = "languages_url"
        static let mergesUrlKey = "merges_url"
        static let milestonesUrlKey = "milestones_url"
        static let mirrorUrlKey = "mirror_url"
        static let nameKey = "name"
        static let notificationsUrlKey = "notifications_url"
        static let openIssuesKey = "open_issues"
        static let openIssuesCountKey = "open_issues_count"
        static let ownerKey = "owner"
        static let starOwnerKey = "star_owner"
        static let permissionsKey = "permissions"
        static let privateKey = "private"
        
        static let pullsUrlKey = "pulls_url"
        static let pushedAtKey = "pushed_at"
        static let releasesUrlKey = "releases_url"
        static let sizeKey = "size"
        static let sshUrley = "ssh_url"
        static let stargazersCountKey = "stargazers_count"
        static let stargazersUrlKey = "stargazers_url"
        static let statusesUrlKey = "statuses_url"
        static let subscribersUrlKey = "subscribers_url"
        static let subscriptionUrlKey = "subscription_url"
        static let svnUrlKey = "svn_url"
        static let tagsUrlKey = "tags_url"
        static let teamsUrlKey = "teams_url"
        static let treesUrlKey = "trees_url:"
        static let updatedAtKey = "updated_at"
        
        static let urlKey = "url"
        static let watchersKey = "watchers"
        static let watchersCountKey = "watchers_count"
        static let subscribersCountKey = "subscribers_count"
        
        static let starTagsKey = "star_tags"
        static let starListKey = "star_lists"
        static let watchedKey = "watched"
        static let scoreKey = "score"
        
        static let starred_atKey = "starred_at"
        
        static let trending_star_textKey = "trending_star_text"
        static let trending_fork_textKey = "trending_fork_text"
        static let trending_star_interval_textKey = "trending_star_interval_text"
        static let trending_showcase_update_textKey = "trending_showcase_update_text"
    }
    
    // MARK: init and mapping
    required public init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        //        super.mapping(map)
        archive_url <- map[ReposKey.archiveUrlKey]
        assignees_url <- map[ReposKey.assigneesUrlKey]
        blobs_url <- map[ReposKey.blobsUrlKey]
        branches_url <- map[ReposKey.branchesUrlKey]
        
        clone_url <- map[ReposKey.cloneUrlKey]
        collaborators_url <- map[ReposKey.collaboratorsUrlKey]
        comments_url <- map[ReposKey.commentsUrlKey]
        commits_url <- map[ReposKey.commitsUrlKey]
        
        compare_url <- map[ReposKey.compareUrlKey]
        contents_url <- map[ReposKey.contentsUrlKey]
        contributors_url <- map[ReposKey.contributorsUrlKey]
        created_at <- map[ReposKey.createdAtKey]
        default_branch <- map[ReposKey.defaultBranchKey]
        deployments_url <- map[ReposKey.deploymentsUrlKey]
        cdescription <- map[ReposKey.descriptionKey]
        downloads_url <- map[ReposKey.downloadsUrlKey]
        events_url <- map[ReposKey.eventsUrlKey]
        fork <- map[ReposKey.forkKey]
        
        forks <- map[ReposKey.forksKey]
        forks_count <- map[ReposKey.forksCountKey]
        forks_url <- map[ReposKey.forksUrlKey]
        
        full_name <- map[ReposKey.fullNameKey]
        git_commits_url <- map[ReposKey.gitCommitsUrlKey]
        git_refs_url <- map[ReposKey.gitRefsUrlKey]
        git_tags_url <- map[ReposKey.gitTagsUrlKey]
        git_url <- map[ReposKey.gitUrlKey]
        has_downloads <- map[ReposKey.hasDownloadsKey]
        has_projects <- map[ReposKey.hasProjects]
        has_issues <- map[ReposKey.hasIssuesKey]
        has_pages <- map[ReposKey.hasPagesKey]
        has_wiki <- map[ReposKey.hasWikiKey]
        homepage <- map[ReposKey.homepageKey]
        hooks_url <- map[ReposKey.hooksUrlKey]
        html_url <- map[ReposKey.htmlUrlKey]
        id <- map[ReposKey.idKey]
        issue_comment_url <- map[ReposKey.issueCommentUrlKey]
        issue_events_url <- map[ReposKey.issueEventsUrlKey]
        
        issues_url <- map[ReposKey.issuesUrlKey]
        keys_url <- map[ReposKey.keysUrlKey]
        labels_url <- map[ReposKey.labelsUrlKey]
        language <- map[ReposKey.languageKey]
        languages_url <- map[ReposKey.languagesUrlKey]
        merges_url <- map[ReposKey.mergesUrlKey]
        milestones_url <- map[ReposKey.milestonesUrlKey]
        mirror_url <- map[ReposKey.mirrorUrlKey]
        name <- map[ReposKey.nameKey]
        notifications_url <- map[ReposKey.notificationsUrlKey]
        open_issues <- map[ReposKey.openIssuesKey]
        open_issues_count <- map[ReposKey.openIssuesCountKey]
        owner <- map[ReposKey.ownerKey]
        star_owner <- map[ReposKey.starOwnerKey]
        permissions <- map[ReposKey.permissionsKey]
        cprivate <- map[ReposKey.privateKey]
        
        pulls_url <- map[ReposKey.pullsUrlKey]
        pushed_at <- map[ReposKey.pushedAtKey]
        releases_url <- map[ReposKey.releasesUrlKey]
        size <- map[ReposKey.sizeKey]
        ssh_url <- map[ReposKey.sshUrley]
        stargazers_count <- map[ReposKey.stargazersCountKey]
        stargazers_url <- map[ReposKey.stargazersUrlKey]
        statuses_url <- map[ReposKey.statusesUrlKey]
        subscribers_url <- map[ReposKey.subscribersUrlKey]
        subscription_url <- map[ReposKey.subscriptionUrlKey]
        svn_url <- map[ReposKey.svnUrlKey]
        tags_url <- map[ReposKey.gitTagsUrlKey]
        teams_url <- map[ReposKey.teamsUrlKey]
        trees_url <- map[ReposKey.treesUrlKey]
        updated_at <- map[ReposKey.updatedAtKey]
        
        url <- map[ReposKey.urlKey]
        watchers <- map[ReposKey.watchersKey]
        watchers_count <- map[ReposKey.watchersCountKey]
        subscribers_count <- map[ReposKey.subscribersCountKey]
        score <- map[ReposKey.scoreKey]
        starred_at <- map[ReposKey.starred_atKey]
        
        star_tags <- map[ReposKey.starTagsKey]
        star_lists <- map[ReposKey.starListKey]
        trending_fork_text <- map[ReposKey.trending_fork_textKey]
        trending_star_text <- map[ReposKey.trending_star_textKey]
        trending_star_interval_text <- map[ReposKey.trending_star_interval_textKey]
        trending_showcase_update_text <- map[ReposKey.trending_showcase_update_textKey]
    }
}
