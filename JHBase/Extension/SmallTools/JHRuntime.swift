//
//  File.swift
//  
//
//  Created by jh on 2022/1/13.
//

import UIKit

public func jh_getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
    return objc_getAssociatedObject(object, key) as? T
}

public func jh_setRetainedAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer, _ value: T, _ policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    objc_setAssociatedObject(object, key, value, policy)
}
