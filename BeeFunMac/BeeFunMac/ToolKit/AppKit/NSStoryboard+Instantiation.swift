//
//  NSStoryboard+Instantiation.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import AppKit

protocol StoryboardInstantiatable: AnyObject {
    
    static func instantiate(storyboard: NSStoryboard.Name, bundle: Bundle?) -> Self
}


extension StoryboardInstantiatable {
    
    /// instantinate control from a storyboard
    static func instantiate(storyboard name: NSStoryboard.Name, bundle: Bundle? = nil) -> Self {
        return NSStoryboard(name: name, bundle: bundle).instantiateInitialController() as! Self
    }
}


extension NSWindowController: StoryboardInstantiatable { }
extension NSViewController: StoryboardInstantiatable { }
