//
//  NSString+Size.swift
//  BeeFunMac
//
//  Created by WengHengcong on 2017/12/11.
//  Copyright © 2017年 LuCi. All rights reserved.
//

import Cocoa
import Foundation

extension NSString {
    
    // FIXME: 为什么无效？？？
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本占宽
    ///   - font: 文本字体
    /// - Returns: 文本高度
    func height(with width: CGFloat, font: NSFont) -> CGFloat {
        let constraintRect = CGSize(width:width, height:.greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    /// 返回文本宽度
    ///
    /// - Parameters:
    ///   - height: 文本占高
    ///   - font: 文本字体
    /// - Returns: 文本宽度
    func width(with height: CGFloat, font: NSFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSString.DrawingOptions.usesLineFragmentOrigin
        
        let boundingBox = boundingRect(with: constraintRect, options: option, attributes: attributes, context: nil)
        return boundingBox.width
    }
}

extension String {
    /// 返回文本高度
    ///
    /// - Parameters:
    ///   - width: 文本占宽
    ///   - font: 文本字体
    /// - Returns: 文本高度
    func height(with width: CGFloat, font: NSFont) -> CGFloat {
        let calString = self as NSString
        return calString.height(with: width, font: font)
    }
    /// 返回文本宽度
    ///
    /// - Parameters:
    ///   - height: 文本占高
    ///   - font: 文本字体
    /// - Returns: 文本宽度
    func width(with height: CGFloat, font: NSFont) -> CGFloat {
        let calString = self as NSString
        return calString.width(with: height, font: font)
    }
}

