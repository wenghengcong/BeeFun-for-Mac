//
//  BFStarTableCellView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/9.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

@IBDesignable class BFStarTableCellView: LCBaseTableCellView {

    @IBOutlet weak var tagContentView: NSView!
    @IBOutlet weak var avatarImg: NSButton!
    @IBOutlet weak var repoNameLbl: NSButton!
    @IBOutlet weak var repoDescLbl: NSTextField!
    @IBOutlet weak var starImg: NSImageView!
    @IBOutlet weak var langImg: NSImageView!
    @IBOutlet weak var forkImg: NSImageView!
    @IBOutlet weak var langLbl: NSTextField!
    @IBOutlet weak var starLbl: NSTextField!
    @IBOutlet weak var forkLbl: NSTextField!
    @IBOutlet weak var timeLbl: NSTextField!
    
    private var bottomLine: NSView = NSView()
    private var selectedMask: NSView = NSView()

    /// Color
    @IBInspectable var titleColor: NSColor = NSColor.black
    @IBInspectable var subTitleColor: NSColor = NSColor.thDayLightBlack

    var selected: Bool = false
    
    var objRepos: ObjRepos? {
        didSet {
            fillDataToUI()
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.origin = CGPoint(x: 0, y: 0)
        //是return row height中，或者xib中的height+2，return row height = xib height
        self.size = CGSize(width: 300, height: 124)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customStarCellView()
    }
    
    fileprivate func customStarCellView() {

        self.backgColor = NSColor.white
        tagContentView.backgColor = NSColor.white
        
        bottomLine.backgColor = NSColor.lineGrayColor
        self.addSubview(bottomLine)
        
        bottomLine.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(1)
        }
        
        selectedMask.backgColor = NSColor(hex: "#2e7dfb", alpha: 0.1)
        self.addSubview(selectedMask)
        selectedMask.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(124)
        }
        selectedMask.isHidden = true
        
        repoNameLbl.isHidden = true
        tagContentView.isHidden = true
        repoDescLbl.isHidden = true
        
//        repoNameLbl.font = NSFont.bfBoldSystemFont(ofSize: 11.0)
        repoDescLbl.font = NSFont.bfSystemFont(ofSize: 11.0)
        repoDescLbl.maximumNumberOfLines = 0
        repoDescLbl.usesSingleLineMode = false
        repoDescLbl.cell?.wraps = true
        repoDescLbl.cell?.isScrollable = false
        
        timeLbl.font = NSFont.bfSystemFont(ofSize: 10.0)
        starLbl.font = NSFont.bfSystemFont(ofSize: 10.0)
        langLbl.font = NSFont.bfSystemFont(ofSize: 10.0)
        forkLbl.font = NSFont.bfSystemFont(ofSize: 10.0)
    }
    
    func didSelectedCell(selected: Bool) {
        self.selected = selected
        selectedMask.isHidden = !selected
        refreshSelectionStyle()
    }
    
    func refreshSelectionStyle() {
        
        let textColor: NSColor = subTitleColor
        
        timeLbl.textColor = textColor
        starLbl.textColor = textColor
        forkLbl.textColor = textColor
        langLbl.textColor = textColor
        repoDescLbl.textColor = textColor
//        tagContentView.backgroundColor = backgroundColor
//        self.backgroundColor = backgroundColor
    }
    
    fileprivate func fillDataToUI() {
        
        if let avatarUrl = objRepos?.owner?.avatar_url {
            if let url = URL(string: avatarUrl) {
                avatarImg.kf.setImage(with: url)
            }
        }
    
        if let starred_at = objRepos?.starred_at {
            timeLbl.stringValue = BFTimeHelper.shared.readableTime(rare: starred_at, prefix: nil)!
        } else if let showcaseUpdate = objRepos?.trending_showcase_update_text {
            timeLbl.stringValue = showcaseUpdate
        }
        if let starCount = objRepos?.stargazers_count {
            starLbl.stringValue = "\(starCount)"
        } else if let trend_star = objRepos?.trending_star_text {
            starLbl.stringValue = trend_star
        } else {
            starLbl.stringValue = "0"
        }
        
        if let forkNum = objRepos?.forks_count {
            forkLbl.stringValue = "\(forkNum)"
        } else if let trend_fork = objRepos?.trending_fork_text {
            forkLbl.stringValue = trend_fork
        } else {
            forkLbl.stringValue = "0"
        }
        
        if let lang = objRepos?.language {
            langLbl.stringValue = lang
        } else {
            langLbl.stringValue = ""
        }
        
        let tagStyle = NSMutableParagraphStyle()
        tagStyle.alignment = .left
        let tagAttrbute = AttributedDictionary.attributeDictionary(foreColor: NSColor.thDayWhite, backColor: nil
            , alignment: .center, lineBreak: nil, baselineOffset: NSNumber(value: 1.5), font: NSFont.bfSystemFont(ofSize: 12.0))

//        let tagAttrbute = [NSAttributedStringKey.foregroundColor : NSColor.thDayBlack, NSAttributedStringKey.paragraphStyle : tagStyle, NSAttributedStringKey.font: NSFont.bfSystemFont(ofSize: 12.0)] as [NSAttributedStringKey : Any]

        let repoNameY: CGFloat = 103
        let repoTagY: CGFloat = 78
        let moveY: CGFloat = 10.0
        
        if let allTags = objRepos?.star_tags {
            tagContentView.isHidden = false
            repoNameLbl.frame = CGRect(x: 46, y: repoNameY, width: 172, height: 20.0)
            tagContentView.frame = CGRect(x: 46, y: repoTagY, width: 246, height: 23)
            
//            allTags = ["A", "Test", "HAHA"]
            for subview in self.tagContentView.subviews {
                subview.removeFromSuperview()
            }
            var allBtns: [NSButton] = []
            for (index, tag) in allTags.enumerated() {
                let tagB = NSButton()
//                tagB.setButtonType(.momentaryLight)
//                tagB.bezelStyle = .texturedSquare
                tagB.isBordered = false
                tagB.backgColor = NSColor.thDayBlue
                tagB.radius = 3.0
                tagB.attributedTitle = NSAttributedString(string: tag, attributes: tagAttrbute)
//                tagB.radius = 10.0
//                tagB.borderWidth = 1.0
                tagB.tag = index
//                tagB.backgroundColor = NSColor.red
                allBtns.append(tagB)
                tagB.font = NSFont.bfSystemFont(ofSize: 9.0)
                self.tagContentView.addSubview(tagB)
            }
            
            let btnY: CGFloat = 2
            var btnX: CGFloat = 0
            let btnOutsideMagrin: CGFloat = 3.0
            let lineH: CGFloat = 18.0
            
            for (_, btn) in allBtns.enumerated() {
                btn.sizeToFit()
                let btnW = btn.width+3.0
                btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: lineH)
                btnX = btnX + btnW + btnOutsideMagrin
                if btnX > 300 {
                    break
                }
            }
        } else {
            repoNameLbl.frame = CGRect(x: 46, y: repoNameY-moveY, width: 172, height: 20.0)
            tagContentView.isHidden = true
            
            for subview in tagContentView.subviews {
                subview.removeFromSuperview()
            }
        }
        
        
        if let name = objRepos?.name {
            
            let repoNameColor = titleColor
            
            let pstyle = NSMutableParagraphStyle()
            pstyle.alignment = .left
            
            var font = NSFont.bfSystemFont(ofSize: 14.0)
            if (objRepos?.star_tags) != nil {
 
            } else {
                font = NSFont.bfSystemFont(ofSize: 16.0)
            }
            
            let dic = AttributedDictionary.attributeDictionary(foreColor: repoNameColor, backColor: nil, alignment: .left, lineBreak: NSLineBreakMode.byTruncatingTail, baselineOffset: nil, font: font)
            repoNameLbl.attributedTitle = NSAttributedString(string: name, attributes: dic)
            
            //            repoNameLbl.sizeToFit()
            if repoNameLbl.width > 172 {
                font = NSFont.bfSystemFont(ofSize: 14.0)
                let dic = [NSAttributedStringKey.foregroundColor : repoNameColor, NSAttributedStringKey.paragraphStyle : pstyle, NSAttributedStringKey.font: font] as [NSAttributedStringKey : Any]
                repoNameLbl.attributedTitle = NSAttributedString(string: name, attributes: dic)
            }
            repoNameLbl.isHidden = false
        }

        if let desc = objRepos?.cdescription {
            repoDescLbl.isHidden = false
            repoDescLbl.stringValue = desc
        }
    
        refreshSelectionStyle()
    }
}
