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
    case settings = 3
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
    @IBOutlet weak var pageBox: NSBox!
    
    var homeController = BFHomeController()
    var starController = BFStarViewController()
    
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
        iconBar.backgroundColor = BFThemeManager.shared.iconBarBackgroundColor()
        
        homeButton.alternateImage = BFThemeManager.shared.iconbarGitImage(selected: true)
        homeButton.image = BFThemeManager.shared.iconbarGitImage(selected: false)
        homeLeftLine.backgroundColor = BFThemeManager.shared.iconSelectedLeftLineColor()
        
        starButton.alternateImage = BFThemeManager.shared.iconbarStarImage(selected: true)
        starButton.image = BFThemeManager.shared.iconbarStarImage(selected: false)
        starLeftLine.backgroundColor = BFThemeManager.shared.iconSelectedLeftLineColor()
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
        
        //TODO: 设置按钮隐藏
        settingButton.isHidden = true
        
//        if BFConfig.shared.appStoreChannel {
//            homeButton.isHidden = true
//            homeBackView.isHidden = true
//            currentIcon = starButton
//        } else {
//            homeButton.isHidden = false
//            homeBackView.isHidden = false
//            currentIcon = homeButton
//        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(mainViewLogin), name: NSNotification.Name.BeeFun.DidLogout, object: nil)
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
        case .star:
            self.pageBox.contentView = starController.view
            homeLeftLine.isHidden = true
            starLeftLine.isHidden = false
            break
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
                iconBtn.superview?.backgroundColor = BFThemeManager.shared.iconSelectedBackgroundColor()
            } else {
                iconBtn.state = .on
                iconBtn.superview?.backgroundColor = BFThemeManager.shared.iconNormalBackgroundColor()
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
