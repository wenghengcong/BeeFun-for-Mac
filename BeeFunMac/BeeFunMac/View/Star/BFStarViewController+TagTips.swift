//
//  BFStarViewController+TagTips.swift
//  BeeFun
//
//  Created by WengHengcong on 2018/5/20.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {

    
    /// Tagtip table init
    func starPageToolsViewTagTipTableView() {
        tagTipsTable.delegate = self
        tagTipsTable.dataSource = self
        tagTipsTable.register(NSNib.init(nibNamed: NSNib.Name(rawValue: "BFTagsTipCellView"), bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.TagTipCell))
        tagTipsTable.selectionHighlightStyle = .none
        tagTipsTable.allowsMultipleSelection = false
        tagTipsTable.target = self
        tagTipsTable.action = #selector(didSelectedTagTipsTableView)
        tagTipsTable.enclosingScrollView?.borderType = .noBorder
        toolsView.addSubview(tagTipsTable, positioned: NSWindow.OrderingMode.above, relativeTo: nil)
    }
    
    /// 选中Tag Tip
    @objc func didSelectedTagTipsTableView() {
        let row = tagTipsTable.clickedRow
        let unselected = -1
        
        if row == unselected {
            tagTipsTableViewDidDeselectRow()
        }else if row != unselected {
            tagTipsTableViewDidSelectRow(row)
        }
    }
    
    private func tagTipsTableViewDidDeselectRow() {
        // clicked outside row
    }
    
    func tagTipsTableViewDidSelectRow(_ row : Int){
        // row did select
        print("did selected \(row)")
        selectedRepoRow = row
        for index in 0..<starTable.numberOfRows {
            if let rowCell = starTable.view(atColumn: 0, row: index, makeIfNecessary: false) as? BFStarTableCellView {
                rowCell.didSelectedCell(selected: (index == row))
            }
        }
        if !starReposData.isBeyond(index: selectedRepoRow) {
            let objrepo = starReposData[selectedRepoRow]
            if let html = objrepo.html_url {
                self.repoLoadURL(html)
            }
            //working tags
            refreshWorkingTagsFromRepo(repo: objrepo)
            reLayoutWorkingLayout()
        }
    }
}
