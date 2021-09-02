//
//  File.swift
//  
//
//  Created by lifei on 2021/9/1.
//  String 便利方法

import Foundation

extension String {
    public var boolValue: Bool {
        let strLower = self.lowercased()
        let strInt = Int(self) ?? 0
        if strLower == "true" || strLower == "yes" || strInt > 0{
            return true
        }
        return false
    }
    
    public var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    public var floatValue: Float {
        return Float(self) ?? 0
    }
    
    public var intValue: Int {
        return Int(self) ?? 0
    }
}

extension String {
    public var toObject: NSObject? {
        if self.isEmpty {
            return nil
        }
        guard let cls = NSClassFromString(self).self as? NSObject.Type else { return nil }
        return cls.init()
    }
}
