//
//  File.swift
//  
//
//  Created by lifei on 2021/9/1.
//  String 便利方法

import Foundation
import CoreGraphics
import UIKit

// MARK: - String to NSObjct
extension String {
    
    public var toNSClass: NSObject.Type? {
        if self.isEmpty {
            return nil
        }
        guard let objCls = NSClassFromString(self).self as? NSObject.Type else { return nil }
        return objCls
    }
    
    public var toNSObject: NSObject? {
        guard let objCls = self.toNSClass else { return nil }
        return objCls.init()
    }
}

extension String {
    /// 搜索字符串中的位置
    /// - Parameters:
    ///   - subString: 子字符串
    ///   - ignoreCase: 是否忽略大小写
    /// - Returns: 子字符串的位置 NSRange
    public func getNSRange(of subString: String, _ caseInsensitive: Bool = false) -> NSRange? {
        if self.contains(subString) == false {
            return nil
        }
        let tmpStr = self as NSString
        var tmpRange = tmpStr.range(of: subString)
        if caseInsensitive == true {
            tmpRange = tmpStr.range(of: subString, options: .caseInsensitive)
        }
        return tmpRange
    }
    
    public static func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let height = text.boundingRect(with:CGSize(width: width, height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.systemFont(ofSize: fontSize)], context:nil).size.height
        return height
    }
    
    public static func textWidth(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let width = text.boundingRect(with:CGSize(width:CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font:UIFont.systemFont(ofSize: fontSize)], context:nil).size.width
        return width

    }
    
    
    
}
