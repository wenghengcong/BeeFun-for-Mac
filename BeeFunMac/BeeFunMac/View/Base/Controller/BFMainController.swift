//
//  BFMainController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/28.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

enum IconBarButton: Int {
    case person = 0
    case home = 1
    case star = 2
    case broswer = 3
    case settings = 4
}

class BFMainController: BFBaseViewController {
    
    @IBOutlet weak var iconBar: NSView!
    @IBOutlet weak var profileButton: NSButton!
    @IBOutlet weak var homeButton: NSButton!
    @IBOutlet weak var homeBackView: NSView!
    @IBOutlet weak var homeLeftLine: NSView!
    @IBOutlet weak var starButton: NSButton!
    @IBOutlet weak var starBackView: NSView!
    @IBOutlet weak var starLeftLine: NSView!
    @IBOutlet weak var settingButton: NSButton!
    
    @IBOutlet weak var browserButton: NSButton!
    @IBOutlet weak var browserSepLine: NSView!
    
    @IBOutlet weak var pageBox: NSBox!
    
    var homeController = BFExploreController()
    var starController = BFStarViewController()
    var browserController = BFBrowserViewController()
    
    var currentIndex: Int = 0
    var currentIcon: NSButton?
    var iconButtons: [NSButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        customIconBar()
        loadHomeView()
        addWindoeNotification()
        loadProfileInfo()
    }
    
    func loadTheme() {
        iconBar.backgColor = BFThemeManager.shared.iconBarBackgroundColor()
        
        homeButton.alternateImage = BFThemeManager.shared.iconbarGitImage(selected: true)
        homeButton.image = BFThemeManager.shared.iconbarGitImage(selected: false)
        homeLeftLine.backgColor = BFThemeManager.shared.iconSelectedLeftLineColor()
        
        starButton.alternateImage = BFThemeManager.shared.iconbarStarImage(selected: true)
        starButton.image = BFThemeManager.shared.iconbarStarImage(selected: false)
        starLeftLine.backgColor = BFThemeManager.shared.iconSelectedLeftLineColor()
        
        browserButton.alternateImage = BFThemeManager.shared.iconbarBrowserImage(selected: true)
        browserButton.image = BFThemeManager.shared.iconbarBrowserImage(selected: false)
        browserSepLine.backgColor = BFThemeManager.shared.iconSelectedLeftLineColor()
    }
    
    /// 自定义左边icon 按钮
    func customIconBar() {
        
        homeButton.highlight(false)
        //home button
        homeButton.tag = IconBarButton.home.rawValue
        iconButtons.append(homeButton)
        
        //star button
        starButton.tag = IconBarButton.star.rawValue
        iconButtons.append(starButton)
        
        //browser button
        browserButton.tag = IconBarButton.broswer.rawValue
        iconButtons.append(browserButton)
        
        //TODO: 设置按钮隐藏
        settingButton.isHidden = true
        
        if BFConfig.shared.appStoreChannel {
            homeButton.isHidden = true
            homeBackView.isHidden = true
            currentIcon = starButton
        } else {
            homeButton.isHidden = false
            homeBackView.isHidden = false
            currentIcon = homeButton
        }
        loadTheme()
    }
    
    
    /// 加载github home
    func loadHomeView() {
        if BFConfig.shared.appStoreChannel {
            clickIconBarButton(starButton)
        } else {
            clickIconBarButton(homeButton)
        }
        _ = starController.view
    }
    
    func addWindoeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewLogin), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewLogout), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
    }
    
    @IBAction func clickIconBarButton(_ sender: Any) {
        let button: NSButton = sender as! NSButton
        let iconTag = IconBarButton.init(rawValue: button.tag)
        if iconTag == nil {
            return
        }
        
        switch iconTag! {
        case .home:
            self.pageBox.contentView = homeController.view
            homeLeftLine.isHidden = false
            starLeftLine.isHidden = true
            browserSepLine.isHidden = true
        case .star:
            self.pageBox.contentView = starController.view
            homeLeftLine.isHidden = true
            starLeftLine.isHidden = false
            browserSepLine.isHidden = true
            break
        case .broswer:
            self.pageBox.contentView = browserController.view
            homeLeftLine.isHidden = true
            starLeftLine.isHidden = true
            browserSepLine.isHidden = false
        case .settings:
            return
        case .person:
            return
        }
        self.view.window?.makeFirstResponder(self.pageBox.contentView)
        //选中左侧其他按钮
        for iconBtn in iconButtons {
            if iconBtn != button {
                //选中的不是当前的按钮
                iconBtn.state = .off
                iconBtn.superview?.backgColor = BFThemeManager.shared.iconSelectedBackgroundColor()
            } else {
                iconBtn.state = .on
                iconBtn.superview?.backgColor = BFThemeManager.shared.iconNormalBackgroundColor()
            }
        }
        
        //set current
        currentIcon = button
        currentIndex = (iconTag?.rawValue)!
    }
    
    func loadProfileInfo() {
        loadProfileAvatar()
    }
    
    func loadProfileAvatar() {
        if let URLString = UserManager.shared.user?.avatar_url {
            if let avatar = URL(string: URLString) {
                profileButton.kf.setImage(with: avatar)
            }
        }
    }
    
}
