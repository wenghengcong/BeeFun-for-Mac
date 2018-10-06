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
    
    let viewOriBorderWidth: CGFloat = 1.0
    let viewSelBorderWidth: CGFloat = 5.0

    
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
        view.borderWidth = viewOriBorderWidth
        
        view.radius = 6.0
    }
    
    func setHighlight(selected: Bool) {
        view.layer?.borderWidth = selected ? viewSelBorderWidth : viewOriBorderWidth
        view.backgColor = selected ? NSColor.hex("#2e7dfb", alpha: 0.1)  : NSColor.clear
    }
}
