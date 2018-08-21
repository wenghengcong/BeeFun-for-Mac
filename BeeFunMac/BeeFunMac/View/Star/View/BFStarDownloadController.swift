//
//  BFStarDownloadController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/18.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFStarDownloadController: NSViewController {

    @IBOutlet weak var urlStackView: NSStackView!
    
    @IBOutlet weak var sshBackView: BFView!
    @IBOutlet weak var sshTitleLabel: NSTextField!
    @IBOutlet weak var sshContentLabel: NSButton!
    @IBOutlet weak var sshImageBtn: NSButton!
    
    @IBOutlet weak var httpsBackView: NSView!
    @IBOutlet weak var httpsTitleLabel: NSTextField!
    @IBOutlet weak var httpsContentLabel: NSButton!
    @IBOutlet weak var httpsImageBtn: NSButton!
    
    @IBOutlet weak var openBackView: NSView!
    @IBOutlet weak var openXcodeBtn: NSButton!
    @IBOutlet weak var openDesktopBtn: NSButton!
    
    @IBOutlet weak var downloadZipBackView: NSView!
    @IBOutlet weak var downloadZipBtn: NSButton!
    
    var repository: ObjRepos? {
        didSet {
            setterRepositoryData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        customView()
    }
    
    func customView() {
        urlStackView.backgroundColor = NSColor.thDayWhite
        sshBackView.backgroundColor = NSColor.thDayWhite
        httpsBackView.backgroundColor = NSColor.thDayWhite
        openBackView.backgroundColor = NSColor.thDayWhite
        downloadZipBackView.backgroundColor = NSColor.thDayWhite

        sshTitleLabel.backgroundColor = NSColor.thDayWhite
        sshContentLabel.backgroundColor = NSColor.thDayWhite
        sshImageBtn.backgroundColor = NSColor.thDayWhite
        
        httpsTitleLabel.backgroundColor = NSColor.thDayWhite
        httpsContentLabel.backgroundColor = NSColor.thDayWhite
        httpsImageBtn.backgroundColor = NSColor.thDayWhite
        
        openXcodeBtn.backgroundColor = NSColor.thDayWhite
        openDesktopBtn.backgroundColor = NSColor.thDayWhite
        downloadZipBtn.backgroundColor = NSColor.thDayWhite
        
        
    }
    
    func setterRepositoryData() {
        if let objrepo = repository {
            
            let pstyle = NSMutableParagraphStyle()
            pstyle.alignment = .left
            let titleDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayWhite, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 12.0)] as [NSAttributedStringKey : Any]
            
            let urlConentDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayWhite, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayBlue, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 12.0)] as [NSAttributedStringKey : Any]
            
            let contentDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayWhite, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 13.0)] as [NSAttributedStringKey : Any]
            
            sshTitleLabel.attributedStringValue = NSAttributedString(string: "Clone with SSH", attributes: titleDic)
            sshContentLabel.attributedTitle = NSAttributedString(string: objrepo.ssh_url!, attributes: urlConentDic)
            
            httpsTitleLabel.attributedStringValue = NSAttributedString(string: "Clone with HTTPS", attributes: titleDic)
            httpsContentLabel.attributedTitle = NSAttributedString(string: objrepo.clone_url!, attributes: urlConentDic)
            
            openXcodeBtn.attributedTitle = NSAttributedString(string: "  Open in Xcode", attributes: contentDic)
            openDesktopBtn.attributedTitle = NSAttributedString(string: "  Open in Desktop", attributes: contentDic)
            downloadZipBtn.attributedTitle = NSAttributedString(string: "  Download ZIP", attributes: contentDic)
        }
    }
    
}
