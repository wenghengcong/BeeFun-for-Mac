
//
//  BFStarTagCellView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/8.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

class BFStarTagCellView: LCBaseTableCellView {
    
    @IBOutlet weak var tagImageV: NSImageView!
    @IBOutlet weak var nameL: NSTextField!
    @IBOutlet weak var numL: NSTextField!
    
    private var bottomLine: NSView = NSView()
    private var selectedMask: NSView = NSView()
    
    var selected: Bool = false

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.origin = CGPoint(x: 0, y: 0)
        //height改变为return row height代理方法中加40=38+2，xib中本身高度只有38
        self.size = CGSize(width: 200, height: 40)
    }
    /* 以下代码尝试高亮颜色
     * 引用：https://stackoverflow.com/questions/9463871/change-selection-color-on-view-based-nstableview
    override var isEmphasized: Bool {
        set {}
        get {
            return false
        }
    }
    
    override var selectionHighlightStyle: NSTableView.SelectionHighlightStyle {
        set {}
        get {
            return .regular
        }
    }

    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 2.5, 2.5)
            NSColor(calibratedWhite: 0.65, alpha: 1).setStroke()
            NSColor(calibratedWhite: 0.82, alpha: 1).setFill()
            let selectionPath = NSBezierPath.init(roundedRect: selectionRect, xRadius: 6, yRadius: 6)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
    */
    var starTag: ObjTag? {
        didSet {
            fillTagToCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTagCellView()
    }
    
    fileprivate func customTagCellView() {
        
        addSubview(bottomLine)
        bottomLine.snp.remakeConstraints { (make) in
            make.height.equalTo(1)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        addSubview(selectedMask)
        selectedMask.snp.remakeConstraints { (make) in
            make.height.equalTo(42)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
        selectedMask.isHidden = true
        
        nameL.font = NSFont.bfSystemFont(ofSize: 18.0)
        numL.isHidden = true
        numL.font = NSFont.bfSystemFont(ofSize: 10.0)
        needsLayout = true
    }
    
    override func layout() {
        super.layout()
        backgColor = .xyWhiteDarkBlack
        bottomLine.backgColor = NSColor.xyLineGray
        selectedMask.backgColor = NSColor(hex: "#0999FF", alpha: 0.1)
        nameL.textColor = NSColor.xyBlackDarkWhite
        numL.textColor = NSColor.xyBlackDarkWhite
    }
    
    func didSelectedCell(selected: Bool) {
        selectedMask.isHidden = !selected
        let selColor = NSColor.xyBlueDarkWhite
        let unSelColor = NSColor.xyBlackDarkWhite
        
        tagImageV.image = BFThemeManager.shared.tagCellImage(selected: selected)

        if selected {
            nameL.textColor = selColor
            numL.textColor = selColor
        } else {
            nameL.textColor = unSelColor
            numL.textColor = unSelColor
        }
    }
    
    func fillTagToCell() {
        
        if let name = starTag?.name {
            nameL.stringValue = name
        }
        
        if let num = starTag?.count {
            numL.stringValue = "\(num)"
        }
    }
}
