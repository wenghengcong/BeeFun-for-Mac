//
//  BFLangPanel.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/3.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

// final 也就是说这个类或方法不希望被继承和重写，具体情况如下：
// （1）类或者方法的功能确实已经完备了（2）避免子类继承和修改造成危险（3）为了让父类中某些代码一定会执行
final class LangPanel {
    
    static let shared = LangPanel()
    
    let panelController = NSWindowController.instantiate(storyboard: "BFLangPanel")
}

final class BFLangWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        (self.window as! NSPanel).isFloatingPanel = false
        self.windowFrameAutosaveName = "All Language"
    }
}

final class BFLangViewController: NSViewController {
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.size = NSSize(width: 350, height: 560)
    }
}

