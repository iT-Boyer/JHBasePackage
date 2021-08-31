//
//  File.swift
//  
//
//  Created by pk on 2021/8/27.
//  NSString 便利方法

import Foundation

@objc extension NSString{
    
    public func isEmptyOrNull() -> Bool {
        if self is NSNull {
            return true
        }
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
    
    public static func isEmptyOrNull(_ content: NSString) -> Bool{
        if content is NSNull {
            return true
        }
        if content.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
            return true
        }
        if content.isEqual(to: "(null)") {
            return true
        }
        if content.isEqual(to: "<null>") {
            return true
        }
        return false
    }
}


