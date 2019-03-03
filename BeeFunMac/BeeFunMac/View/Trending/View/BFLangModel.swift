//
//  BFLanguageModel.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation
import ObjectMapper

public class BFLangModel: NSObject, Mappable {

    var name: String?
    // 语言类型：programming\data
    var type: String?
    
    // 颜色
    var color: String?
    // 对应的文件后缀
    var extensions: [String]?
    // source.isabelle.theory\source.json\source.js
    var tm_scope: String?
    
    // 语言：text\json\yaml
    var ace_mode: String?
    var language_id: Int?

    // 别名
    var aliases: [String]?
    
    var wrap: Bool?
    
    var filenames: [String]?
    
    var interpreters: [String]?
    
    // 分组:JavaScript\Java\Lex\CoffeeScript
    var group: String?
    
    //
    var searchable: String?
    
    // 针对Code Mirror
    // javascript
    var codemirror_mode: String?
    
    // codemirror对应的mime类型application/json
    var codemirror_mime_type: String?
    
    struct LanguageKey {
        static let type = "type"
        static let extensions = "extensions"
        static let tm_scope = "tm_scope"
        static let ace_mode = "ace_mode"
        static let color = "color"
        static let language_id = "language_id"
        static let aliases = "aliases"
        static let wrap = "wrap"
        static let filenames = "filenames"
        static let interpreters = "interpreters"
        static let group = "group"
        static let searchable = "searchable"
        static let codemirror_mode = "codemirror_mode"
        static let codemirror_mime_type = "codemirror_mime_type"
    }
    
    // MARK: init and mapping
    required public init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        
        type <- map[LanguageKey.type]
        extensions <- map[LanguageKey.extensions]
        tm_scope <- map[LanguageKey.tm_scope]
        ace_mode <- map[LanguageKey.ace_mode]
        language_id <- map[LanguageKey.language_id]
        aliases <- map[LanguageKey.aliases]
        color <- map[LanguageKey.color]

        wrap <- map[LanguageKey.wrap]
        filenames <- map[LanguageKey.filenames]
        interpreters <- map[LanguageKey.interpreters]
        group <- map[LanguageKey.group]
        searchable <- map[LanguageKey.searchable]
        searchable <- map[LanguageKey.searchable]
        
        codemirror_mode <- map[LanguageKey.codemirror_mode]
        codemirror_mime_type <- map[LanguageKey.codemirror_mime_type]
    }
    
}
