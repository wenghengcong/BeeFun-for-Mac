//
//  BFStarViewController.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/11/30.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import SnapKit
import WebKit
import FlatButton
import ObjectMapper
import Down

class BFStarViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    enum CellIdentifiers {
        static let StarCell = "StarCellIdentifier"
        static let TagCell = "TagCellIdentifier"
        static let TagTipCell = "BFTagsTipCellView"
    }
    
    // MARK: - Data
    var starReposData: [ObjRepos] = []
    var allTags: [ObjTag] = []

    var searchKey: String?                         //搜索关键字
    var languageArr: [String] = []                 //所有语言项
    var languageAndNum: [String] = []              //所有语言项目及该语言对应的数目
    var filterTags: [ObjTag] = []                  //当前选择的tags
    var ordertType: StarOrderType = .time          //当前排序项目
    var inputTagsTipArr: [String] = []             //当前输入tag的提示列表
    
    //网络请求参数
    var getRepoTagPara = ""
    var getRepoSortPara = "starred_at"
    var getRepoDirectionPara = "desc"
    var getRepoLanguageVar = "All"                       //当前选择的语言
    var getReposPage = 1
    var getReposPerPage = 30
    var getTagsPage = 1
    var getTagePerpage = 20
    //当前是否正在加载下一页
    var getReposNextPageLoading = false
    var getTagsNextPageLoading = false
    var updateBeeFunDBLoading = false

    /// 选中
    var selectedRepoRow: Int = 0
    var selectedTagRow: Int = 0
    /// repoModel原来的tag列表
    var oriSelRepoStatTags: [String]?
    
    var selectedTipRow: Int = 0
    
    var selectedTag: ObjTag? 
    //左边Repos列表+order排序+搜索区域
    @IBOutlet weak var leftContentView: BFView!
    //右边tags列表+input tag区域+web区域
    @IBOutlet weak var rightContentView: BFView!
    //tag管理区域
    var clickAllStar: Bool = true
    var clickUntaggedStar: Bool = false
    var tagSortPara = "name"
    var tagDirectionPara = "desc"
    
    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var tagActionStackView: NSStackView!
    @IBOutlet weak var starSyncBackView: NSView!
    @IBOutlet weak var allTagsBackView: NSView!
    @IBOutlet weak var unTaggedBackView: NSView!
    @IBOutlet weak var tagSortBackView: NSView!
    @IBOutlet weak var newTagBackView: NSView!
    //tag管理区域右边的线
    @IBOutlet weak var tagManagerRightLine: NSView!
    
    @IBOutlet weak var refreshButton: BFImageButton!
    @IBOutlet weak var starSyncLabel: NSTextField!
    
    @IBOutlet weak var allStarsBtn: NSButton!
    @IBOutlet weak var allStarsImageView: NSImageView!
    @IBOutlet weak var untaggedStarBtn: NSButton!
    @IBOutlet weak var untaggedStarsImageView: NSImageView!
    
    @IBOutlet weak var tagSortButton: NSPopUpButton!
    @IBOutlet weak var tagTextLabel: NSTextField!
    
    @IBOutlet weak var newTagTextField: BFTextField!
    @IBOutlet weak var saveNewTagBtn: NSButton!
    
    @IBOutlet weak var tagTable: NSTableView!
    @IBOutlet var tagRightMenu: NSMenu!        //tag右键menu

    //repo检索区域
    @IBOutlet var searchFilterView: BFView!
    @IBOutlet var orderFilterView: BFStarOrderFilterView!
    @IBOutlet var tableViewBackground: BFView!
    @IBOutlet var starTable: NSTableView!
    @IBOutlet weak var searchFilterRightLine: NSBox!
    @IBOutlet weak var languagePop: NSPopUpButton!      //语言复选框
    @IBOutlet weak var searchField: NSSearchField!      //搜索输入框
    @IBOutlet weak var searchFieldCell: NSSearchFieldCell!
    
    //web展示区域，包含tools工具栏
    var repoWebView: WKWebView?
    /// 整个工具栏，webview以上的全部
    @IBOutlet var toolsView: BFView!
    @IBOutlet weak var repoUrlBtn: NSButton!
    @IBOutlet weak var repoOwnerBtn: NSButton!
    @IBOutlet weak var repoNameBtn: NSButton!
    @IBOutlet weak var repoStarBtn: NSButton!
    @IBOutlet weak var repoDwnBtn: NSButton!
    @IBOutlet weak var repoInfoLbl: NSTextField!
    @IBOutlet weak var repoDescLbl: NSTextField!
    
    //webview的四个工具按钮
    @IBOutlet weak var webViewBackBtn: NSButton!
    @IBOutlet weak var webViewForwardBtn: NSButton!
    @IBOutlet weak var webViewRefreshBtn: NSButton!
    @IBOutlet weak var webViewHomeBtn: NSButton!
    
    @IBOutlet weak var toolsViewSepLine: NSBox!
    @IBOutlet weak var webIndicator: NSProgressIndicator!

    // MARK: - repo tag管理区域
    var workingTags: [ObjTag] = []      /// 已添加tags
    var addTagContainView = BFView()   //添加tag的区域，包含inputRepoTagField + workingTagsView
    var workingTagsView = NSScrollView()    //全部tag的区域
    var workingTagsButtongs: [NSButton] = []

    let inputNewTagFieldTag = 2222
    @IBOutlet weak var repoTagsTextField: AutoCompleteTextField!       /// 输入新tag
    var hasTagsMatched: Bool = false
    
    //布局
    var addTagContainLeftMargin: CGFloat = 41 //addTagContainView距离toolsView的左边距，就是tag图标的地方
    let lineH: CGFloat = 23         //tag每行的高度
    var currentTagsOfLines: CGFloat = 1     //总共有几行，注意inputRepoTagField要单独加1行
    var toolsViewHeight: CGFloat = 110
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        starPageReloadAllData()
        starPageCustomAllView()
        firstLoadStarPage()
        addNotification()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    deinit {
        removeNotification()
    }
}
