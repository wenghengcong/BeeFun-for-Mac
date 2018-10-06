//
//  BFExploreReposViewItem.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/9/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFExploreReposViewItem: NSCollectionViewItem {

    @IBOutlet weak var repoNameLabel: NSButton!
    @IBOutlet weak var repoColorLabel: BFButton!
    
    @IBOutlet weak var repoLanguageLabel: NSButton!
    @IBOutlet weak var repoDescLabel: NSTextField!
    
    @IBOutlet weak var starButton: NSButton!
    
    @IBOutlet weak var builtUsersBox: NSBox!
    
    @IBOutlet weak var upLabel: NSTextField!
    @IBOutlet weak var upImageView: NSImageView!
    @IBOutlet weak var starLabel: NSTextField!
    @IBOutlet weak var starImageView: NSImageView!
    @IBOutlet weak var forkLabel: NSTextField!
    @IBOutlet weak var forkImageView: NSImageView!
    
    let viewOriBorderWidth: CGFloat = 1.0
    let viewSelBorderWidth: CGFloat = 5.0
    
    var repoModel: BFGithubTrengingModel? {
        didSet {
            fillDataToUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.borderColor = NSColor.thDayBlue
        view.borderWidth = viewOriBorderWidth
    }
    
    func fillDataToUI() {
        
        if let name = repoModel?.repo_name {
            repoNameLabel.title = name
        }
        
        if let color = repoModel?.repo_language_color {
            repoColorLabel.title = ""
            repoColorLabel.backgColor = NSColor.hex(color)
        }
        
        if let language = repoModel?.repo_language {
            repoLanguageLabel.stringValue = language
        }
        
        if let desc = repoModel?.repo_desc {
            repoDescLabel.stringValue = desc
        } else {
            
        }
        
        if let upNum = repoModel?.up_star_num {
            upImageView.isHidden = false
            upLabel.stringValue = "\(upNum)"
        } else {
            upImageView.isHidden = true
            upLabel.stringValue = "0"
        }
        
        if let starNum = repoModel?.star_num {
            starImageView.isHidden = false
            starLabel.stringValue = "\(starNum)"
        } else {
            starImageView.isHidden = true
            starLabel.stringValue = "0"
        }
        
        if let forkNum = repoModel?.fork_num {
            forkImageView.isHidden = false
            forkLabel.stringValue = "\(forkNum)"
        } else {
            forkImageView.isHidden = true
            forkLabel.stringValue = "0"
        }
    }
    
    
}
