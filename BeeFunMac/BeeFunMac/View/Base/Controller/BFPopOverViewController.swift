//
//  BFPopOverViewController.swift
//  BeeFun
//
//  Created by WengHengcong on 2019/2/19.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa


struct BFPopOverUtils {
    
    static let downloadPopOverIden: String = "downloadPopOver"
    static let tagsTipPopOverIden: String = "tagsTipPopOver"
    static let menuAppPopOverOverIden: String = "menuAppPopOver"
    
    static func isCustomPopOver(window: NSWindow) -> Bool {
        if let identifier = window.contentView?.identifier?.rawValue, identifier == tagsTipPopOverIden {
            print("tags popover view")
            return true
        } else if let identifier = window.contentViewController?.identifier?.rawValue, identifier == downloadPopOverIden {
            print("download popover viewcontroller")
            return true
        } else if let identifier = window.contentViewController?.identifier?.rawValue, identifier == menuAppPopOverOverIden {
            print("menuApp popover viewcontroller")
            return true
        }
        return false
    }
}

/// 用于在Dock栏中，再次打开app，不会再次打开的NSPopover
/// 因为NSPopover是个特殊的window，给其内部的ViewController加一个特殊的标识，用于在点击Dock时，过滤此类Window
class BFPopOverViewController: NSViewController {

    convenience init(iden: String) {
        self.init()
        self.identifier = NSUserInterfaceItemIdentifier.init(iden)
    }
}

/// 用于在Dock栏中，再次打开app，不会再次打开的NSPopover
/// 因为NSPopover是个特殊的window，给其内部的View加一个特殊的标识，用于在点击Dock时，过滤此类Window
class BFPopOverView: NSView {
    
    convenience init(iden: String) {
        self.init()
        self.identifier = NSUserInterfaceItemIdentifier.init(iden)
    }
}
