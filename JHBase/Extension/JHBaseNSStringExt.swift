//
//  File.swift
//  
//
//  Created by pk on 2021/8/27.
//  NSString 便利方法

import Foundation

extension NSString{
    
    public func isEmptyOrNull() -> Bool {
        if self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
            return true
        }
        if self.isEqual(to: "(null)") {
            return true
        }
        if self.isEqual(to: "<null>") {
            return true
        }
        return false
    }
    
    public static func isEmptyOrNull(_ content: String?) -> Bool{
        guard let tmpStr = content else { return true }
        if tmpStr.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
            return true
        }
        if tmpStr == "(null)" {
            return true
        }
        if tmpStr == "<null>" {
            return true
        }
        return false
    }
}


