//
//  BFLanguageModel.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation
import ObjectMapper

public class BFLangModel: NSObject, Mappable, NSCoding {

    @objc dynamic var name: String?
    // 语言类型：programming\data
    @objc dynamic var type: String?
    
    // 颜色
    @objc dynamic var color: String?
    // 对应的文件后缀
    @objc dynamic var extensions: [String]?
    // source.isabelle.theory\source.json\source.js
    @objc dynamic var tm_scope: String?
    
    // 语言：text\json\yaml
    @objc dynamic var ace_mode: String?
    @objc dynamic var language_id: Int = 0

    // 别名
    @objc dynamic var aliases: [String]?
    
    @objc dynamic var wrap: Bool = false
    
    @objc dynamic var filenames: [String]?
    
    @objc dynamic var interpreters: [String]?
    
    // 分组:JavaScript\Java\Lex\CoffeeScript
    @objc dynamic var group: String?
    
    //
    @objc dynamic var searchable: String?
    
    // 针对Code Mirror
    // javascript
    @objc dynamic var codemirror_mode: String?
    
    // codemirror对应的mime类型application/json
    @objc dynamic var codemirror_mime_type: String?
    
    struct LanguageKey {
        static let name = "name"
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
        //name
        name <- map[LanguageKey.name]
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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init()
        name = aDecoder.decodeObject(forKey: LanguageKey.name) as? String
        type = aDecoder.decodeObject(forKey: LanguageKey.type) as? String
        extensions = aDecoder.decodeObject(forKey: LanguageKey.extensions) as? [String]
        tm_scope = aDecoder.decodeObject(forKey: LanguageKey.tm_scope) as? String
        ace_mode = aDecoder.decodeObject(forKey: LanguageKey.ace_mode) as? String
        if let lanID = aDecoder.decodeObject(forKey: LanguageKey.language_id) as? Int {
            language_id = lanID
        }
        aliases = aDecoder.decodeObject(forKey: LanguageKey.aliases) as? [String]

        color = aDecoder.decodeObject(forKey: LanguageKey.color) as? String
        if let wrapBool = aDecoder.decodeObject(forKey: LanguageKey.wrap) as? Bool {
            wrap = wrapBool
        }
        filenames = aDecoder.decodeObject(forKey: LanguageKey.filenames) as? [String]
        interpreters = aDecoder.decodeObject(forKey: LanguageKey.interpreters) as? [String]
        group = aDecoder.decodeObject(forKey: LanguageKey.group) as? String
        searchable = aDecoder.decodeObject(forKey: LanguageKey.searchable) as? String

        codemirror_mode = aDecoder.decodeObject(forKey: LanguageKey.codemirror_mode) as? String
        codemirror_mime_type = aDecoder.decodeObject(forKey: LanguageKey.codemirror_mime_type) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: LanguageKey.name)
        aCoder.encode(type, forKey: LanguageKey.type)
        aCoder.encode(extensions, forKey: LanguageKey.extensions)
        aCoder.encode(tm_scope, forKey: LanguageKey.tm_scope)
        aCoder.encode(ace_mode, forKey: LanguageKey.ace_mode)
        aCoder.encode(language_id, forKey: LanguageKey.language_id)
        aCoder.encode(aliases, forKey: LanguageKey.aliases)
        aCoder.encode(color, forKey: LanguageKey.color)
        aCoder.encode(wrap, forKey: LanguageKey.wrap)

        aCoder.encode(filenames, forKey: LanguageKey.filenames)
        aCoder.encode(interpreters, forKey: LanguageKey.interpreters)
        aCoder.encode(group, forKey: LanguageKey.group)
        aCoder.encode(searchable, forKey: LanguageKey.searchable)
        aCoder.encode(codemirror_mode, forKey: LanguageKey.codemirror_mode)
        aCoder.encode(codemirror_mime_type, forKey: LanguageKey.codemirror_mime_type)
    }
    
}
