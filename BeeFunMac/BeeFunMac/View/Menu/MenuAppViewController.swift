//
//  MenuAppViewController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/15.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuAppViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension MenuAppViewController {
    
    // MARK: Storyboard instantiation
    static func menuAppController() -> MenuAppViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("MenuApp"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("MenuAppViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MenuAppViewController else {
            fatalError("Why cant i find MenuAppViewController? - Check MenuApp.storyboard")
        }
        viewcontroller.identifier = NSUserInterfaceItemIdentifier(BFPopOverUtils.menuAppPopOverOverIden)
        return viewcontroller
    }
    
}
