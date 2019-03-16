//
//  MenuTabViewController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/16.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Cocoa

class MenuTabViewController: NSTabViewController {
    
    private var lastFrameSize: NSSize?
    
    // MARK: -
    // MARK: Tab View Controller Methods
    
    override var selectedTabViewItemIndex: Int {
        
        didSet {
            if self.isViewLoaded {  // avoid storing initial state (set in the storyboard)
                UserDefaults.standard[.lastMenuPaneIdentifier] = self.tabViewItems[selectedTabViewItemIndex].identifier as? String
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // workaround for that NSTabViewItem is not localized by storyboard (2018-11 macOS 10.14)
        self.localizeTabViewItems()
        
        // select last used pane
        if
            let identifier = UserDefaults.standard[.lastMenuPaneIdentifier],
            let item = self.tabViewItems.enumerated().first(where: { ($0.element.identifier as? String) == identifier })
        {
            self.selectedTabViewItemIndex = item.offset
        }
    }
    
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        
        self.view.window!.title = self.tabViewItems[self.selectedTabViewItemIndex].label
    }
    
    
    override func tabView(_ tabView: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        
        super.tabView(tabView, willSelect: tabViewItem)
        
        self.lastFrameSize = tabViewItem?.view?.frame.size
    }
    
    
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        
        super.tabView(tabView, didSelect: tabViewItem)
        
        guard let tabViewItem = tabViewItem else { return assertionFailure() }
        
        self.switchPane(to: tabViewItem)
    }
    
    
    
    // MARK: Private Methods
    
    /// resize window to fit to new view
    private func switchPane(to tabViewItem: NSTabViewItem) {
        
        guard let contentSize = self.lastFrameSize ?? tabViewItem.view?.frame.size else { return assertionFailure() }
        
        // initialize tabView's frame size
        guard let window = self.view.window else {
            self.view.frame.size = contentSize
            return
        }
        
        NSAnimationContext.runAnimationGroup({ _ in
            self.view.isHidden = true
            window.animator().setFrame(for: contentSize)
            
        }, completionHandler: { [weak self] in
            self?.view.isHidden = false
            window.title = tabViewItem.label
        })
    }
    
}


private extension MenuTabViewController {
    
    private static let ibIdentifiers: [String: String] = [
        "Trendind": "Nt8-vs-J0f",
        ]
    
    
    /// localize tabViewItems using storyboard's .string
    func localizeTabViewItems() {
        
        for item in self.tabViewItems {
            guard
                let identifier = item.identifier as? String,
                let ibIdentifier = type(of: self).ibIdentifiers[identifier]
                else { assertionFailure(); continue }
            
            let key = ibIdentifier + ".label"
            let localized = key.localized
            
            guard key != localized else { continue }
            
            item.label = localized
        }
    }
    
}



private extension NSWindow {
    
    /// calculate window frame for the given contentSize
    func setFrame(for contentSize: NSSize, flag: Bool = false) {
        
        let frameSize = self.frameRect(forContentRect: NSRect(origin: .zero, size: contentSize)).size
        let frame = NSRect(origin: self.frame.origin, size: frameSize)
            .offsetBy(dx: 0, dy: self.frame.height - frameSize.height)
        
        self.setFrame(frame, display: flag)
    }
    
}


