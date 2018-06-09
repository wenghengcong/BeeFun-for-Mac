//
//  BFStarViewController+Table.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2018/1/9.
//  Copyright © 2018年 LuCi. All rights reserved.
//

import Cocoa

extension BFStarViewController {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == starTable {
            return starReposData.count
        } else if tableView == tagTable {
            return allTags.count
        } else if tableView == tagTipsTable {
            return inputTagsTipArr.count
        }
        return 0
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if tableView == starTable {
            return 109
        } else if tableView == tagTable {
            return 40
        } else if tableView == tagTipsTable {
            return 18
        }
        return 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        //        print("tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int)")
        if tableView == starTable {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.StarCell), owner: nil) as? BFStarTableCellView {
                if !starReposData.isBeyond(index: row) {
                    cell.objRepos = starReposData[row]
                }
                cell.didSelectedCell(selected: row == selectedRepoRow)
                return cell
            }
        } else if tableView == tagTable {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.TagCell), owner: nil) as? BFStarTagCellView {
                let tag = allTags[row]
                cell.didSelectedCell(selected: row == selectedTagRow)
                cell.starTag = tag
                return cell
            }
        } else if tableView == tagTipsTable {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.TagTipCell), owner: nil) as? BFTagsTipCellView {
                let tip = inputTagsTipArr[row]
                cell.didSelectedCell(selected: row == selectedTipRow)
                cell.tip = tip
                return cell
            }
        }

        return nil
    }
    
}

// MARK: - Table Other method
extension BFStarViewController {
    
    override func scrollWheel(with event: NSEvent) {
        print(event.momentumPhase)
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let selrows = starTable.selectedRowIndexes
        print("selected mutiple rows: \(selrows)")
    }
        
}
