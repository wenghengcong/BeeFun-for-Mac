//
//  StarOrderFilterView.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/9.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa

protocol StarOrderProtocol: class {
    func didSelected(button: BFImageButton, order: StarOrderType)
}

enum StarOrderType: Int {
    case time = 0
    case star = 1
    case a_z = 2
}

class BFStarOrderFilterView: BFView {
    
    @IBOutlet weak var timeOrder: BFImageButton!
    @IBOutlet weak var starOrder: BFImageButton!
    @IBOutlet weak var a_zOrder: BFImageButton!
    
    @IBOutlet weak var progressIndicatorView: NSProgressIndicator!
    
    open weak var delegate: StarOrderProtocol?
    
    var orderButtons: [BFImageButton] = []
    var currentIndex: Int = 0
    var currentOrder: BFImageButton?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        orderButtons = [timeOrder, starOrder, a_zOrder]
        timeOrder.tag = StarOrderType.time.rawValue
        starOrder.tag = StarOrderType.star.rawValue
        a_zOrder.tag = StarOrderType.a_z.rawValue
        
    }
    
    func setupIndicator() {
        progressIndicatorView.isIndeterminate = true
        progressIndicatorView.isDisplayedWhenStopped = false
    }

    func showIndicator() {
        progressIndicatorView.startAnimation(nil)
    }
    
    func hideIndicator() {
        progressIndicatorView.stopAnimation(nil)
    }
    
    /// 选中Order type类型
    func selectOrder(type: StarOrderType) {
        let tag = type.rawValue
        let selBtn = orderButtons[tag]
        clickOrder(selBtn)
    }
    
    @IBAction func clickOrder(_ sender: Any) {
        let button = sender as? BFImageButton
        //选中左侧其他按钮
        for orderBtn in orderButtons {
            if orderBtn != button {
                //选中的不是当前的按钮
                orderBtn.state = .off
            } else {
                orderBtn.state = .on
            }
        }
        
        currentIndex = button!.tag
        currentOrder = button
        let orderType: StarOrderType = StarOrderType(rawValue: currentOrder!.tag) ?? .time
        delegate?.didSelected(button: button!, order: orderType)
    }
    
}
