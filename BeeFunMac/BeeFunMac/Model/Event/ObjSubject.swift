//
//  ObjSubject.swift
//  BeeFun
//
//  Created by WengHengcong on 2/23/16.
//  Copyright © 2016 JungleSong. All rights reserved.
//
/**
"title": "marked designated initializers (issue #1142)",
"url": "https://api.github.com/repos/jessesquires/JSQMessagesViewController/pulls/1460",
"latest_comment_url": "https://api.github.com/repos/jessesquires/JSQMessagesViewController/pulls/1460",
"type": "PullRequest"
*/

import Cocoa
import ObjectMapper

public enum SubjectType: String {

    case issue = "Issue"
    case pullRequest = "PullRequest"
    case release = "Release"
    case commit = "Commit"

}

class ObjSubject: NSObject, Mappable {

    var title: String?
    var url: String?
    var latest_comment_url: String?
    var type: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        //        super.mapping(map)

        title <- map["title"]
        url <- map["url"]
        latest_comment_url <- map["latest_comment_url"]
        type <- map["type"]

    }
}
