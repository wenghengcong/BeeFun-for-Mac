//
//  DraggableArrayController.swift
//  BeeFun
//
//  Created by Hunt on 2019/3/10.
//  Copyright © 2019 LuCi. All rights reserved.
//

import Foundation

private extension NSPasteboard.PasteboardType {
    
    static let rows = NSPasteboard.PasteboardType("rows")
}


final class DraggableArrayController: NSArrayController, NSTableViewDataSource {
    
    // MARK: Table Data Source Protocol
    
    /// start dragging
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {
        
        // register dragged type
        tableView.registerForDraggedTypes([.rows])
        pboard.declareTypes([.rows], owner: self)
        
        // select rows to drag
        tableView.selectRowIndexes(rowIndexes, byExtendingSelection: false)
        
        // store row index info to pasteboard
        let rows = NSKeyedArchiver.archivedData(withRootObject: rowIndexes)
        pboard.setData(rows, forType: .rows)
        
        return true
    }
    
    
    /// validate when dragged items come to tableView
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        
        // accept only self drag-and-drop
        guard info.draggingSource as? NSTableView == tableView else { return [] }
        
        if dropOperation == .on {
            tableView.setDropRow(row, dropOperation: .above)
        }
        
        return .move
    }
    
    
    /// check acceptability of dragged items and insert them to table
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        
        // accept only self drag-and-drop
        guard info.draggingSource as? NSTableView == tableView else { return false }
        
        // obtain original rows from paste board
        guard
            let data = info.draggingPasteboard.data(forType: .rows),
            let sourceRows = NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexSet else { return false }
        
        let draggingItems = (self.arrangedObjects as AnyObject).objects(at: sourceRows)
        
        let destinationRow = row - sourceRows.count(in: 0...row)  // real insertion point after removing items to move
        let destinationRows = IndexSet(destinationRow..<(destinationRow + draggingItems.count))
        
        // update
        NSAnimationContext.runAnimationGroup({ context in
            // update UI
            tableView.removeRows(at: sourceRows, withAnimation: .effectFade)
            tableView.insertRows(at: destinationRows, withAnimation: .effectGap)
            tableView.selectRowIndexes(destinationRows, byExtendingSelection: false)
        }, completionHandler: {
            // update data
            self.remove(atArrangedObjectIndexes: sourceRows)
            self.insert(contentsOf: draggingItems, atArrangedObjectIndexes: destinationRows)
        })
        
        return true
    }
    
}
