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
        
        openXcodeBtn.backgroundColor = NSColor.clear
        openDesktopBtn.backgroundColor = NSColor.clear
        downloadZipBtn.backgroundColor = NSColor.clear
        
    }
    
}
