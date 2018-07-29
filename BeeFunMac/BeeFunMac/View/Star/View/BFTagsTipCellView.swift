//
//  BFTagsTipCellView.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/20.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

/// 用来做输入tag时的提示
class BFTagsTipCellView: LCBaseTableCellView {

    @IBOutlet weak var tipsLabel: NSTextField!
    private var bottomLine: NSView = NSView()
    private var selectedMask: NSView = NSView()
    
    var titleColor: NSColor = NSColor.black
    var subTitleColor: NSColor = NSColor.subtitleTextColor
    
    var tip: String? {
        didSet {
            if let tipStr = tip {
                tipsLabel.stringValue = tipStr
            }
        }
    }
    
    var tipAttributeString: NSMutableAttributedString? {
        didSet {
            if let attri = tipAttributeString {
                tipsLabel.attributedStringValue = attri
            }
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.origin = CGPoint(x: 0, y: 0)
        //height改变为return row height代理方法中加2=40+2
        self.size = CGSize(width: 200, height: 42)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTipsCellView()
    }
    
    fileprivate func customTipsCellView() {
        self.backgroundColor = .clear
        bottomLine.backgroundColor = NSColor.lineGrayColor
        self.addSubview(bottomLine)
        
        bottomLine.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(1)
        }
        
        selectedMask.backgroundColor = NSColor(hex: "#0099FF", alpha: 0.2)
        self.addSubview(selectedMask)
        selectedMask.snp.remakeConstraints { (make) in
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(111)
        }
        selectedMask.isHidden = true
        tipsLabel.textColor = subTitleColor
    }
    
    func didSelectedCell(selected: Bool) {
        selectedMask.isHidden = !selected
        if selected {
            let color = NSColor.hex("7b7b7b", alpha: 0.5)
            tipsLabel.textColor = color
        } else {
            tipsLabel.textColor = subTitleColor
        }
    }

}
