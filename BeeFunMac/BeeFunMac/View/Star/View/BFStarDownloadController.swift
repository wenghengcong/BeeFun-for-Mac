//
//  BFStarDownloadController.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/8/18.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

protocol BFStarDownloadControllerProtocol: class {
    func didCopyUrlToClipboard()
    func didClickOpenInDesktop()
    func didClickOpenInXcode()
    func didClickDownloadZIP(name: String, zipUrl: String)
}

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
    
    open weak var delegate: BFStarDownloadControllerProtocol?

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
        
        view.backgroundColor = NSColor.thDayWhite
        
        urlStackView.backgroundColor = NSColor.thDayWhite
        sshBackView.backgroundColor = NSColor.thDayWhite
        httpsBackView.backgroundColor = NSColor.thDayWhite
        openBackView.backgroundColor = NSColor.thDayWhite
        downloadZipBackView.backgroundColor = NSColor.thDayWhite

        sshTitleLabel.backgroundColor = NSColor.thDayWhite
        sshContentLabel.backgroundColor = NSColor.thDayWhite
        sshContentLabel.borderWidth = 1.0
        sshContentLabel.borderColor = NSColor.thDayLightGray
        sshImageBtn.backgroundColor = NSColor.thDayWhite
        
        sshTitleLabel.target = self
        sshTitleLabel.action = #selector(clickSSHURL)
        sshContentLabel.target = self
        sshContentLabel.action = #selector(clickSSHURL)
        sshImageBtn.target = self
        sshImageBtn.action = #selector(clickSSHURL)
        
        httpsTitleLabel.backgroundColor = NSColor.thDayWhite
        httpsContentLabel.backgroundColor = NSColor.thDayWhite
        httpsContentLabel.borderWidth = 1.0
        httpsContentLabel.borderColor = NSColor.thDayLightGray
        httpsImageBtn.backgroundColor = NSColor.thDayWhite
        
        httpsTitleLabel.target = self
        httpsTitleLabel.action = #selector(clickHTTPSURL)
        httpsContentLabel.target = self
        httpsContentLabel.action = #selector(clickHTTPSURL)
        httpsImageBtn.target = self
        httpsImageBtn.action = #selector(clickHTTPSURL)
        
        openXcodeBtn.backgroundColor = NSColor.thDayWhite
        openDesktopBtn.backgroundColor = NSColor.thDayWhite
        downloadZipBtn.backgroundColor = NSColor.thDayWhite
        
        openXcodeBtn.target = self
        openXcodeBtn.action = #selector(clickOpenInXcode)
        
        openDesktopBtn.target = self
        openDesktopBtn.action = #selector(clickOpenInDeskTop)
        
        downloadZipBtn.target = self
        downloadZipBtn.action = #selector(clickDownloadZIP)
    }
    
    @objc func clickSSHURL() {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.clearContents()
        if let sshUrl =  repository?.ssh_url {
            pasteboard.setString(sshUrl, forType: .string)
        }
        self.delegate?.didCopyUrlToClipboard()
    }
    
    @objc func clickHTTPSURL() {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.clearContents()
        if let cloneUrl =  repository?.clone_url {
            pasteboard.setString(cloneUrl, forType: .string)
        }
        self.delegate?.didCopyUrlToClipboard()
    }
    
    @objc func clickOpenInDeskTop() {
        if let url = repository?.html_url {
            let openUrl = "x-github-client://openRepo/" + url
            if let deskURL = URL(string: openUrl) {
                NSWorkspace.shared.open(deskURL)
            }
        }
        self.delegate?.didClickOpenInDesktop()
    }
    
    @objc func clickOpenInXcode() {
        if let url = repository?.html_url {
            let openUrl = "xcode://clone?repo=" + url
            if let deskURL = URL(string: openUrl) {
                NSWorkspace.shared.open(deskURL)
            }
        }
        self.delegate?.didClickOpenInXcode()
    }
    
    @objc func clickDownloadZIP() {
//        NSWorkspace.shared.launchApplication("Finder")
//        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Users")
        if let url = repository?.html_url, let branch = repository?.default_branch, let name = repository?.name {
            let zipUrl = url + "/archive/" + branch + ".zip"
            self.delegate?.didClickDownloadZIP(name: name, zipUrl: zipUrl)
        }
    }
    
    func setterRepositoryData() {
        if let objrepo = repository {
            
            let pstyle = NSMutableParagraphStyle()
            pstyle.alignment = .left
            let titleDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayWhite, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 12.0)] as [NSAttributedStringKey : Any]
            
            let urlConentDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayWhite, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 12.0)] as [NSAttributedStringKey : Any]
            
            let contentDic = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.backgroundColor: NSColor.thDayWhite, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 13.0)] as [NSAttributedStringKey : Any]
            
            sshTitleLabel.attributedStringValue = NSAttributedString(string: "Clone with SSH", attributes: titleDic)
            sshContentLabel.attributedTitle = NSAttributedString(string: " " + objrepo.ssh_url!, attributes: urlConentDic)
            
            httpsTitleLabel.attributedStringValue = NSAttributedString(string: "Clone with HTTPS", attributes: titleDic)
            httpsContentLabel.attributedTitle = NSAttributedString(string:" " + objrepo.clone_url!, attributes: urlConentDic)
            
            openXcodeBtn.attributedTitle = NSAttributedString(string: "  Open in Xcode", attributes: contentDic)
            openDesktopBtn.attributedTitle = NSAttributedString(string: "  Open in Desktop", attributes: contentDic)
            downloadZipBtn.attributedTitle = NSAttributedString(string: "  Download ZIP", attributes: contentDic)
        }
    }
    
}
