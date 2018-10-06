//
//  BFExpolreNavigationViewItem.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/10/6.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExpolreNavigationViewItem: NSCollectionViewItem {

    @IBOutlet weak var logoImageView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descLabel: NSTextField!
    
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
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        titleLabel.textColor = BFThemeManager.shared.explre_nav_title_color()
        descLabel.textColor = BFThemeManager.shared.explre_nav_subTitle_color()
        
        view.borderColor = NSColor.thDayBlue
        view.borderWidth = 1.0
        
        view.radius = 6.0
    }
}
