//
//  File.swift
//  
//
//  Created by pk on 2021/8/27.
//  NSString 便利方法

import Foundation

@objc extension NSString{
    
    func isEmpty() -> Bool {
        if type(of: self).isEqual(NSNull.self) {
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
    
    static func contentIsNullORNil(content:NSString) -> Bool{
        if type(of: content).isEqual(NSNull.self) {
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


