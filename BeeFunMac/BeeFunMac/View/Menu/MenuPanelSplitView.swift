//
//  MenuPanelSplitView.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuPanelSplitView: NSSplitView {
    
    /// hide divider completely when the second view (Find All result) is collapsed
    override func drawDivider(in rect: NSRect) {
        guard !self.isSubviewCollapsed(self.subviews[1]) else { return }
        
        super.drawDivider(in: rect)
    }
    
}
