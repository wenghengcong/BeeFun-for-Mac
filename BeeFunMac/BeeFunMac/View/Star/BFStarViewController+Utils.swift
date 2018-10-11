//
//  BFStarViewController+Utils.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/18.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    

    
    
    // MARK: - Tags string
    /// 将tag对象列表转为一个字符串
    func convertObjListToString(tags: [ObjTag]?) -> String {
        if tags == nil {
            return ""
        }
        
        var star_tagsStr = ""
        for (index, tag) in tags!.enumerated() {
            if index == 0 {
                star_tagsStr = tag.name!.trimmed
            } else {
                star_tagsStr += ",\(tag.name!.trimmed)"
            }
        }
        return star_tagsStr
    }

    /// 将tag对象列表转为一个字符串
    func convertStarTagStringListToString(tags: [String]?) -> String {
        if tags == nil {
            return ""
        }
        
        var star_tagsStr = ""
        for (index, tag) in tags!.enumerated() {
            if index == 0 {
                star_tagsStr = tag.trimmed
            } else {
                star_tagsStr += ",\(tag.trimmed)"
            }
        }
        return star_tagsStr
    }

    
    /// 将tag对象转为字符数组
    func convertObjListToStringList(tags: [ObjTag]?) -> [String] {
        if tags == nil {
            return []
        }
        var star_list: [String] = []
        for tag in tags! {
            if let tagName = tag.name {
                star_list.append(tagName)
            }
        }
        return star_list
    }
    
    // MARK: - Network
    /// 网络错误后，getReposPage恢复请求前
    func resetGetReposPageAfterNetworkError() {
        if getReposPage > 1 {
            getReposPerPage -= 1
        } else {
        }
    }
    
    /// 网络错误后，getTagsPage恢复请求前
    func resetGetTagsPageAfterNetworkError() {
        if getTagsPage > 1 {
            getTagsPage -= 1
        } else {
        }
    }
    
}
