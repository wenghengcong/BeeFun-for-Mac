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
    let viewSelBorderWidth: CGFloat = 2.0
    
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
        view.radius = 6.0
    }
    
    
    override func viewDidLayout() {
        super.viewDidLayout()
        view.backgColor = NSColor.bfWhiteDarkBlack
        view.borderWidth = viewOriBorderWidth
        view.borderColor = NSColor.bfWhiteDarkWhite
        titleLabel.textColor = NSColor.bfBlackDarkWhite
        descLabel.textColor = NSColor.bfLightBlackDarkWhite
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    func setHighlight(selected: Bool) {
        view.layer?.borderWidth = selected ? viewSelBorderWidth : viewOriBorderWidth
        view.backgColor = selected ? NSColor.bfBlueDarkBlue : NSColor.bfWhiteDarkBlack
        titleLabel.textColor = selected ? NSColor.bfWhiteDarkWhite :  NSColor.bfBlackDarkWhite
        descLabel.textColor = selected ? NSColor.bfWhiteDarkWhite : NSColor.bfLightBlackDarkWhite
    }
    
    
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        if event.clickCount == 2 {
            print("double click collection view item")
            itemDelegate?.doubleClickNavigationItem(navigationItem: self)
        }
    }
}
