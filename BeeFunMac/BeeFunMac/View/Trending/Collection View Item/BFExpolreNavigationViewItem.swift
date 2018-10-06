//
//  BFExpolreNavigationViewItem.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/6.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

protocol BFExpolreNavigationViewItemDelete: class {
    func doubleClickNavigationItem(navigationItem: BFExpolreNavigationViewItem)
}

class BFExpolreNavigationViewItem: NSCollectionViewItem {

    @IBOutlet weak var logoImageView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descLabel: NSTextField!
    
    open weak var itemDelegate: BFExpolreNavigationViewItemDelete?
    
    let viewOriBorderWidth: CGFloat = 1.0
    let viewSelBorderWidth: CGFloat = 3.0
    
    var exploreNavModel: BFExploreNavigationModel? {
        didSet {
            if let logoImage = exploreNavModel?.logo  {
                logoImageView.image = NSImage(named: NSImage.Name(logoImage))
            }
            titleLabel.stringValue = exploreNavModel?.title ?? ""
            descLabel.stringValue = exploreNavModel?.desc ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.backgColor = NSColor.clear
        titleLabel.textColor = BFThemeManager.shared.explre_nav_title_color()
        descLabel.textColor = BFThemeManager.shared.explre_nav_subTitle_color()
        view.radius = 6.0
        view.borderColor = NSColor.thDayBlue
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func setHighlight(selected: Bool) {
        view.layer?.borderWidth = selected ? viewSelBorderWidth : viewOriBorderWidth
        view.backgColor = selected ? NSColor.hex("#2e7dfb", alpha: 0.1)  : NSColor.clear
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if event.clickCount == 2 {
            print("double click collection view item")
            itemDelegate?.doubleClickNavigationItem(navigationItem: self)
        }
    }
}
