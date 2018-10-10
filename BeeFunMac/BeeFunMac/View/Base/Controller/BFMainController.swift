//
//  BFMainController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/28.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

enum IconBarType: Int {
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
    
    // MARK: - view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        customIconBar()
        loadHomeView()
        addWindoeNotification()
        loadProfileInfo()
    }
    
    // MARK: - View
    
    private func loadTheme() {
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
    private func customIconBar() {
        
        homeButton.highlight(false)
        //home button
        homeButton.tag = IconBarType.home.rawValue
        iconButtons.append(homeButton)
        
        //star button
        starButton.tag = IconBarType.star.rawValue
        iconButtons.append(starButton)
        
        //browser button
        browserButton.tag = IconBarType.broswer.rawValue
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
    
    private func addWindoeNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewLogin), name: NSNotification.Name.BeeFun.DidLogin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewLogout), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
    }
    
    // MARK: - Action
    
    /// 加载github home
    private func loadHomeView() {
        if BFConfig.shared.appStoreChannel {
            clickIconBarButton(starButton)
        } else {
            clickIconBarButton(homeButton)
        }
        loadInitAllView()
    }
    
    func loadInitAllView() {
        _ = starController.view
        _ = homeController.view
        _ = browserController.view
    }
    
    /// 从左侧Icon Bar跳转到某页面
    ///
    /// - Parameters:
    ///   - type: 跳转icon
    ///   - userContent: 该页面所需要的参数
    public func gotoIcanPage(_ type: IconBarType, userContent: [String: Any]?)
    {
        gotoIconBar(type: type, userContent: userContent)
    }
    
    @IBAction private func clickIconBarButton(_ sender: Any) {
        let button: NSButton = sender as! NSButton
        let iconTag = IconBarType.init(rawValue: button.tag)
        if iconTag == nil {
            return
        }
        //直接点击，没有userContent
        gotoIconBar(type: iconTag!, userContent: nil)
    }
    
    private func gotoIconBar(type: IconBarType, userContent: [String: Any]?) {
        switch type {
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
            browserController.userContent = userContent
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
        changeCurrentButton(type: type, userContent: userContent)
    }
    
    private func changeCurrentButton(type: IconBarType, userContent: [String: Any]?)
    {
        //选中左侧其他按钮
        for iconBtn in iconButtons {
            if iconBtn.tag != type.rawValue {
                //选中的不是当前的按钮
                iconBtn.state = .off
                iconBtn.superview?.backgColor = BFThemeManager.shared.iconSelectedBackgroundColor()
            } else {
                iconBtn.state = .on
                iconBtn.superview?.backgColor = BFThemeManager.shared.iconNormalBackgroundColor()
                //set current
                currentIcon = iconBtn
                currentIndex = type.rawValue
            }
        }
    }
    
    internal func loadProfileInfo() {
        loadProfileAvatar()
    }
    
    private func loadProfileAvatar() {
        if let URLString = UserManager.shared.user?.avatar_url {
            if let avatar = URL(string: URLString) {
                profileButton.kf.setImage(with: avatar)
            }
        }
    }
    
}
