//
//  BFStarViewController+Repo.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/9.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa
import ObjectMapper
import Down

// MARK: - Star repo Table
extension BFStarViewController {
    
    func starPageCustomRepoTableView() {
        starTable.delegate = self
        starTable.dataSource = self
        starTable.register(NSNib.init(nibNamed: NSNib.Name(rawValue: "BFStarTableCellView"), bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.StarCell))
        starTable.selectionHighlightStyle = .none
        starTable.allowsMultipleSelection = false
        starTable.target = self
        starTable.action = #selector(didSelectedRepoTableView)
        starTable.enclosingScrollView?.borderType = .noBorder
//        starTable.enclosingScrollView?.scrollerKnobStyle = .default
        
    }
    
    /// 选中行
    @objc func didSelectedRepoTableView() {
        
        resignAllTextFieldFirstResponder()
        let row = starTable.clickedRow
        let unselected = -1
        
        if row == unselected {
            repoTableViewDidDeselectRow()
        }else if row != unselected {
            repoTableViewDidSelectRow(row)
        }
    }
    
    private func repoTableViewDidDeselectRow() {
        // clicked outside row
    }
    
    func repoTableViewDidSelectRow(_ row : Int){
        // row did select
        print("did selected \(row)")
        selectedRepoRow = row
        for index in 0..<starTable.numberOfRows {
            if let rowCell = starTable.view(atColumn: 0, row: index, makeIfNecessary: false) as? BFStarTableCellView {
                rowCell.didSelectedCell(selected: (index == row))
            }
        }
        refreshRepoInfoAndReadMe()
    }
}
