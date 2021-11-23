//
//  JHBaseObjectExt.swift
//  
//
//  Created by lifei on 2021/9/8.
//  Swift 动态调用 OC

import Foundation

extension NSObject {
    
    @discardableResult
    public static func callFunc(_ aSelector: String, _ param1: AnyObject? = nil, _ param2: AnyObject? = nil) -> AnyObject? {
        if aSelector.isEmpty {
            return nil
        }
        
        let objSel = NSSelectorFromString(aSelector)
        if responds(to: objSel) == false {
            return nil
        }
        
        guard let method = class_getClassMethod(Self.self, objSel) else { return nil }
        let reTypeChar: UnsafeMutablePointer<CChar> = method_copyReturnType(method)
        let reTypeStr: String = String(cString: reTypeChar)
        reTypeChar.deallocate()
        
        if reTypeStr != "@" {
            perform(objSel, with: param1, with: param2)
            return nil
        }
        
        if let result = perform(objSel, with: param1, with: param2) {
            return result.takeUnretainedValue()
        }
        
        return nil
    }
    
    @discardableResult
    public func callFunc(_ aSelector: String, _ param1: AnyObject? = nil, _ param2: AnyObject? = nil) -> AnyObject? {
        if aSelector.isEmpty {
            return nil
        }
        
        let objSel = NSSelectorFromString(aSelector)
        if responds(to: objSel) == false {
            return nil
        }
        
        guard let method = class_getInstanceMethod(Self.self, objSel) else { return nil }
        let reTypeChar: UnsafeMutablePointer<CChar> = method_copyReturnType(method)
        let reTypeStr: String = String(cString: reTypeChar)
        reTypeChar.deallocate()
        
        if reTypeStr != "@" {
            perform(objSel, with: param1, with: param2)
            return nil
        }
        
        if let result = perform(objSel, with: param1, with: param2) {
            return result.takeUnretainedValue()
        }
        
        return nil
    }
    
}
